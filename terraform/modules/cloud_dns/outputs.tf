output "dns_name" {
  value       = google_dns_managed_zone.primary.dns_name
  description = "Nombre del dominio gestionado por Cloud DNS"
}

output "name_servers" {
  value       = google_dns_managed_zone.primary.name_servers
  description = "Servidores de nombres de la zona DNS"
}