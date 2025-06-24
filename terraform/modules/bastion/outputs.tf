output "ip_address" {
  value       = google_compute_instance.bastion.network_interface[0].access_config[0].nat_ip
  description = "Dirección IP pública del bastion"
}

output "instance_name" {
  value       = google_compute_instance.bastion.name
  description = "Nombre de la instancia bastion"
}