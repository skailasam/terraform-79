provider "kubernetes" {
  host                   = "https://${data.google_container_cluster.xecm.endpoint}"
  token                  = data.google_client_config.provider.access_token
  cluster_ca_certificate = base64decode(data.google_container_cluster.xecm.master_auth[0].cluster_ca_certificate)
}

resource "kubernetes_namespace" "xecm" {
  metadata {
    name = "xecm"
  }
}

provider "helm" {
  kubernetes {
    host                   = "https://${data.google_container_cluster.xecm.endpoint}"
    token                  = data.google_client_config.provider.access_token
    cluster_ca_certificate = base64decode(data.google_container_cluster.xecm.master_auth[0].cluster_ca_certificate)
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
