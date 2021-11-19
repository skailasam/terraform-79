resource "google_filestore_instance" "otiv_storage" {
  name = "otiv-storage"
  zone = var.zone
  tier = "STANDARD"

  file_shares {
    capacity_gb = 1024
    name        = "otiv"
  }

  networks {
    network = var.vpc_name
    modes   = ["MODE_IPV4"]
  }

  depends_on = [
    google_compute_network.vpc
  ]
}

resource "helm_release" "otiv_storage" {
  name       = "otiv-storage"
  repository = "https://kubernetes-sigs.github.io/nfs-subdir-external-provisioner/"
  chart      = "nfs-subdir-external-provisioner/nfs-subdir-external-provisioner"
  namespace  = "${var.namespace}"

  set {
    name  = "nfs.server"
    value = google_filestore_instance.otiv_storage.networks.0.ip_addresses.0
  } 
  set {
    name  = "storageClass.name"
    value = "nfs"
  } 
  set {
    name  = "nfs.path"
    value = "/otiv"
  } 

  depends_on = [
    google_filestore_instance.otiv_storage
  ]
}
