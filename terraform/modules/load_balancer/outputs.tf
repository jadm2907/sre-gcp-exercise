output "ip_address" {
  value       = google_compute_global_address.default.address
  description = "Dirección IP pública del balanceador de carga"
}