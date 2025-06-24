variable "project_id" {
  description = "ID del proyecto GCP"
  type        = string
  validation {
    condition     = length(var.project_id) > 0
    error_message = "El project_id no puede estar vacío"
  }
}

variable "region" {
  description = "Región de GCP donde se desplegarán los recursos"
  type        = string
  default     = "us-central1"
}

variable "zone" {
  description = "Zona de GCP dentro de la región"
  type        = string
  default     = "us-central1-a"
}

variable "domain" {
  description = "Dominio base para configurar en Cloud DNS"
  type        = string
  validation {
    condition     = can(regex("^[a-zA-Z0-9.-]+$", var.domain))
    error_message = "El dominio debe ser válido (ejemplo: example.com)"
  }
}

variable "database_name" {
  description = "Nombre de la base de datos en Cloud SQL"
  type        = string
  default     = "appdb"
}

variable "database_user" {
  description = "Usuario principal de la base de datos"
  type        = string
  default     = "appuser"
  sensitive   = true
}

variable "database_password" {
  description = "Contraseña para el usuario de la base de datos"
  type        = string
  sensitive   = true
  validation {
    condition     = length(var.database_password) >= 8
    error_message = "La contraseña debe tener al menos 8 caracteres"
  }
}

variable "health_check_path" {
  description = "Ruta para el health check HTTP"
  type        = string
  default     = "/"
}

variable "health_check_port" {
  description = "Puerto para el health check"
  type        = number
  default     = 80
}