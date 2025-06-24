output "ip_address" {
  description = "IP pública del balanceador de carga"
  value       = google_compute_global_address.lb_ip.address
}

output "health_check_name" {
  description = "Nombre del health check configurado"
  value       = google_compute_health_check.http.name
}

output "backend_service_name" {
  description = "Nombre del backend service"
  value       = google_compute_backend_service.default.name
}