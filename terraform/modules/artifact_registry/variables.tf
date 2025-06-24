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
  default     = "us-central1"  # Valor por defecto añadido
}