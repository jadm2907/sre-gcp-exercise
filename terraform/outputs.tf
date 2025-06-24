output "load_balancer_ip" {
  description = "IP pública del balanceador de carga"
  value       = module.load_balancer.ip_address
}

output "bastion_ip" {
  description = "IP pública de la instancia bastion"
  value       = module.bastion.ip_address
}

output "cloud_sql_connection" {
  description = "Nombre de conexión para Cloud SQL"
  value       = module.cloud_sql.connection_name
}

output "gke_cluster_name" {
  description = "Nombre del cluster GKE"
  value       = module.gke.cluster_name
}

output "artifact_registry_url" {
  description = "URL del Artifact Registry"
  value       = "${var.region}-docker.pkg.dev/${var.project_id}/docker-repo"
}

output "health_check_status" {
  description = "Estado del health check"
  value       = google_compute_health_check.http.self_link
}
output "health_check_name" {
  description = "Nombre del health check configurado"
  value       = google_compute_health_check.http.name
}