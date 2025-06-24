variable "project_id" { type = string }
variable "region" { default = "us-central1" }
variable "zone" { default = "us-central1-a" }
variable "domain" { type = string }
variable "database_name" { default = "appdb" }
variable "database_user" { default = "appuser" }
variable "database_password" { type = string }