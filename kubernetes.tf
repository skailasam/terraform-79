data "google_client_config" "provider" {}

provider "kubernetes" {
  host                   = "https://${google_container_cluster.xecm.endpoint}"
  token                  = data.google_client_config.provider.access_token
  cluster_ca_certificate = base64decode(google_container_cluster.xecm.master_auth[0].cluster_ca_certificate)
}

resource "kubernetes_namespace" "xecm" {
  metadata {
    name = "xecm"
  }
}

resource "kubernetes_namespace" "cert-manager" {
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

resource "helm_release" "cert-manager" {
  name       = "cert-manager"
  chart      = "jetstack/cert-manager"
  namespace  = "cert-manager"

  set {
    name  = "installCRDs"
    value = "true"
  } 
}

resource "helm_release" "otxecm-ingress" {
  name       = "otxecm-ingress"
  chart      = "ingress-nginx/ingress-nginx"
  namespace  = "xecm"

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
  namespace  = "xecm"

  values = [
    "${file("../otxecm/platforms/gcp.yaml")}",
    "${file("../otxecm/sizings/test-nonproduction.yaml")}"
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
}
