provider "google" {
  project = var.project
  region  = var.region
  zone    = var.zone
}

# Static IP Address
resource "google_compute_address" "xecm_ip_address" {
  name = var.ip_address_name
}

# VPC
resource "google_compute_network" "vpc" {
  name                    = var.vpc_name
  auto_create_subnetworks = true
}

# GKE cluster
resource "google_container_cluster" "xecm" {
  name     = var.cluster_name
  location = var.zone
  
  initial_node_count       = var.cluster_nodes

  node_config {
    machine_type = var.machine_type

    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
  }

  network    = google_compute_network.vpc.name
}
