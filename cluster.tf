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
  location = var.region
  
  initial_node_count       = var.cluster_nodes

  network    = google_compute_network.vpc.name
}
