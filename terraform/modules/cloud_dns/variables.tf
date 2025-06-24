variable "project_id" {
  type        = string
  description = "ID del proyecto en GCP"
}

variable "domain" {
  type        = string
  description = "Nombre de dominio para Cloud DNS (ejemplo: example.com)"
}

variable "load_balancer_ip" {
  type        = string
  description = "Dirección IP del balanceador de carga"
}