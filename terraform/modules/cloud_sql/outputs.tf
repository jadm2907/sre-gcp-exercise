output "connection_name" {
  value       = google_sql_database_instance.instance.connection_name
  description = "Nombre de conexión de la instancia de Cloud SQL"
}

output "database_name" {
  value       = google_sql_database.database.name
  description = "Nombre de la base de datos"
}