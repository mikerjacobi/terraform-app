# cluster/outputs.tf

output "cluster_name" {
  description = "The name of the GKE cluster"
  value       = google_container_cluster.primary.name
}

output "cluster_endpoint" {
  description = "The endpoint of the GKE cluster"
  value       = google_container_cluster.primary.endpoint
}

output "cluster_ca_certificate" {
  description = "The cluster CA certificate for the GKE cluster"
  value       = google_container_cluster.primary.master_auth[0].cluster_ca_certificate
}

output "token" {
  description = "The access token for authenticating to the GKE cluster"
  value       = data.google_client_config.default.access_token
  sensitive   = true
}

output "project_id" {
  description = "The GCP project ID"
  value       = var.project_id
}

output "location" {
  description = "The GCP region or zone"
  value       = var.location
}
