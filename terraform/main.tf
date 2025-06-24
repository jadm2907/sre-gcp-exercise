provider "google" {
  project = var.project_id
  region  = var.region
}

# Habilitar APIs necesarias
resource "google_project_service" "services" {
  for_each = toset([
    "container.googleapis.com",
    "compute.googleapis.com",
    "servicenetworking.googleapis.com",
    "artifactregistry.googleapis.com",
    "sqladmin.googleapis.com"
  ])
  
  project = var.project_id
  service = each.key
}

# Health Check para el Load Balancer
resource "google_compute_health_check" "http" {
  name    = "http-health-check"
  project = var.project_id

  http_health_check {
    port         = 80
    request_path = "/"
  }

  check_interval_sec    = 5
  timeout_sec           = 5
  healthy_threshold     = 2
  unhealthy_threshold   = 3

  depends_on = [google_project_service.services]
}

module "gke" {
  source     = "./modules/gke"
  project_id = var.project_id
  region     = var.region
  zone       = var.zone
  subnet     = data.google_compute_subnetwork.default.name

  depends_on = [google_project_service.services]
}

module "load_balancer" {
  source         = "./modules/load_balancer"
  project_id     = var.project_id
  region         = var.region
  instance_group = module.gke.instance_group_url

  depends_on = [
    google_project_service.services,
    google_compute_health_check.http,
    module.gke
  ]
}

module "cloud_dns" {
  source           = "./modules/cloud_dns"
  project_id       = var.project_id
  domain           = var.domain
  load_balancer_ip = module.load_balancer.ip_address

  depends_on = [module.load_balancer]
}

module "bastion" {
  source     = "./modules/bastion"
  project_id = var.project_id
  region     = var.region
  zone       = var.zone
  subnet     = data.google_compute_subnetwork.default.name

  depends_on = [google_project_service.services]
}

resource "google_artifact_registry_repository" "docker_repo" {
  project       = var.project_id
  location      = var.region
  repository_id = "docker-repo"
  format        = "DOCKER"
  description   = "Repositorio Docker para imágenes de contenedores"

  depends_on = [google_project_service.services]
}

module "cloud_sql" {
  source           = "./modules/cloud_sql"
  project_id       = var.project_id
  region           = var.region
  database_name    = var.database_name
  database_user    = var.database_user
  database_password = var.database_password

  depends_on = [google_project_service.services]
}

data "google_compute_network" "default" {
  name = "default"
}

data "google_compute_subnetwork" "default" {
  name   = "default"
  region = var.region
}