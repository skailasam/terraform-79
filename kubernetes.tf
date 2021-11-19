data "google_client_config" "provider" {}

provider "kubernetes" {
  host                   = "https://${google_container_cluster.xecm.endpoint}"
  token                  = data.google_client_config.provider.access_token
  cluster_ca_certificate = base64decode(google_container_cluster.xecm.master_auth[0].cluster_ca_certificate)
}

provider "kubectl" {
  host                   = "https://${google_container_cluster.xecm.endpoint}"
  token                  = data.google_client_config.provider.access_token
  cluster_ca_certificate = base64decode(google_container_cluster.xecm.master_auth[0].cluster_ca_certificate)
  load_config_file       = false
}

resource "kubernetes_namespace" "xecm" {
  metadata {
    name = "xecm"
  }
}

resource "kubernetes_namespace" "cert_manager" {
  metadata {
    name = "cert-manager"
  }
}

provider "helm" {
  kubernetes {
    host                   = "https://${google_container_cluster.xecm.endpoint}"
    token                  = data.google_client_config.provider.access_token
    cluster_ca_certificate = base64decode(google_container_cluster.xecm.master_auth[0].cluster_ca_certificate)
  }
}

resource "helm_release" "cert_manager" {
  name       = "cert-manager"
  repository = "https://charts.jetstack.io"
  chart      = "cert-manager"
  namespace  = "cert-manager"

  set {
    name  = "installCRDs"
    value = "true"
  }

  depends_on = [
    kubernetes_namespace.cert_manager
  ]
}

resource "kubectl_manifest" "cluster_issuer" {
  yaml_body = file("../otxecm/cluster-issuer-nginx.yaml")

  depends_on = [
    helm_release.cert_manager
  ]
}

resource "helm_release" "otxecm_ingress" {
  name       = "otxecm-ingress"
  repository = "https://kubernetes.github.io/ingress-nginx"
  chart      = "ingress-nginx"
  namespace  = "${var.namespace}"

  set {
    name  = "rabc.create=true"
    value = "true"
  } 
  set {
    name  = "controller.service.loadBalancerIP"
    value = google_compute_address.xecm_ip_address.address
  } 
}

resource "helm_release" "xecm" {
  name       = "otxecm"
  chart      = "../otxecm"
  namespace  = "${var.namespace}"

  timeout = 600
  wait = false

  values = [
    "${file("../otxecm/platforms/gcp.yaml")}"
  ]
  set {
    name  = "otpd-db.enabled"
    value = "true"
  } 
  set {
    name  = "otpd.enabled"
    value = "true"
  }
  set {
    name  = "otiv.enabled"
    value = "false"
  } 
  set {
    name  = "otcs.image.name"
    value = "otxecm"
  } 
}
