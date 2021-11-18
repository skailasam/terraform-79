output "region" {
  value       = var.region
  description = "GCloud Region"
}

output "project" {
  value       = var.project
  description = "GCloud Project ID"
}

output "kubernetes_cluster_name" {
  value       = google_container_cluster.xecm.name
  description = "GKE Cluster Name"
}

output "kubernetes_cluster_host" {
  value       = google_container_cluster.xecm.endpoint
  description = "GKE Cluster Host"
}
