variable "project_id" {
  type        = string
  description = "ID del proyecto en GCP"
}

variable "region" {
  type        = string
  description = "Región de GCP"
}

variable "database_name" {
  type        = string
  description = "Nombre de la base de datos"
}

variable "database_user" {
  type        = string
  description = "Usuario de la base de datos"
}

variable "database_password" {
  type        = string
  description = "Contraseña de la base de datos"
  sensitive   = true
}