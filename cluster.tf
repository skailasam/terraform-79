provider "google" {
  project = var.project_id
  region  = var.region
}

# VPC
resource "google_compute_network" "vpc" {
  name                    = "${var.cluster-name}-vpc"
  auto_create_subnetworks = "true"
}

# GKE cluster
resource "google_container_cluster" "primary" {
  name     = "${var.project_id}-gke"
  location = var.region
  
  initial_node_count       = "${var.cluster_nodes}"

  network    = google_compute_network.vpc.name
  subnetwork = google_compute_subnetwork.subnet.name
}
