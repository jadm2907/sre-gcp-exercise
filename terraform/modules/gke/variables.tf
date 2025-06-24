variable "project_id" {
  type        = string
  description = "ID del proyecto en GCP"
}

variable "region" {
  type        = string
  description = "Región de GCP"
}

variable "zone" {
  type        = string
  description = "Zona de GCP"
}

variable "subnet" {
  type        = string
  description = "Nombre de la subred en la VPC predeterminada"
}