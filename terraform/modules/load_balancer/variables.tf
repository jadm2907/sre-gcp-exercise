variable "project_id" {
  type        = string
  description = "ID del proyecto en GCP"
}

variable "region" {
  type        = string
  description = "Región de GCP"
}

variable "instance_group" {
  type        = string
  description = "URL del grupo de instancias o grupo de backend (por ejemplo, grupo de instancias de GKE)"
}