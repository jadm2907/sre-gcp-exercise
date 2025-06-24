variable "project_id" {
  type        = string
  description = "ID del proyecto GCP (rugged-silo-463917-i2)"
}

variable "region" {
  type        = string
  description = "Región de GCP"
  default     = "us-central1"
}

variable "zone" {
  type        = string
  default     = "us-central1-a"
  description = "Zona donde se desplegará el bastion"
}

variable "subnet" {
  type        = string
  description = "Nombre de la subred en la VPC predeterminada"
}

variable "image_family" {
  type        = string
  description = "Familia de imágenes para la instancia bastion"
  default     = "debian-12" # Valor por defecto alternativo
}