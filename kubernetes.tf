resource "kubernetes_namespace" "xecm" {
  metadata {
    name = "xecm"
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





/*
resource "kubernetes_deployment" "test" {
  metadata {
    name      = "nginx"
    namespace = kubernetes_namespace.test.metadata.0.name
  }
  spec {
    replicas = 2
    selector {
      match_labels = {
        app = "MyTestApp"
      }
    }
    template {
      metadata {
        labels = {
          app = "MyTestApp"
        }
      }
      spec {
        container {
          image = "nginx"
          name  = "nginx-container"
          port {
            container_port = 80
          }
        }
      }
    }
  }
}
*/