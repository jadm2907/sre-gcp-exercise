provider "google" {
  project = var.project_id
  region  = var.region
}

module "load_balancer" {
  source = "./modules/load_balancer"
}

module "cloud_dns" {
  source = "./modules/cloud_dns"
  project_id = var.project_id
  domain = var.domain
}

module "bastion" {
  source = "./modules/bastion"
  project_id = var.project_id
  region = var.region
  zone = var.zone
  subnet = data.google_compute_subnetwork.default.name
}

module "gke" {
  source = "./modules/gke"
  project_id = var.project_id
  region = var.region
  zone = var.zone
  subnet = data.google_compute_subnetwork.default.name
}

module "container_registry" {
  source = "./modules/container_registry"
  project_id = var.project_id
}

module "cloud_sql" {
  source = "./modules/cloud_sql"
  project_id = var.project_id
  region = var.region
  database_name = var.database_name
  database_user = var.database_user
  database_password = var.database_password
}

data "google_compute_network" "default" {
  name = "default"
}

data "google_compute_subnetwork" "default" {
  name   = "default"
  region = var.region
}