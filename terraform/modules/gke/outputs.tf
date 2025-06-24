output "cluster_name" {
  value       = google_container_cluster.primary.name
  description = "Nombre del clúster GKE"
}

output "endpoint" {
  value       = google_container_cluster.primary.endpoint
  description = "Endpoint del clúster GKE"
}