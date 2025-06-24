resource "google_artifact_registry_repository" "docker_repo" {
  location      = var.region  # Usando la variable region definida globalmente
  repository_id = "docker-repo"
  format        = "DOCKER"
  project       = var.project_id  # Usando la variable project_id definida globalmente

  description = "Repositorio Docker para imágenes de contenedores"
  
  docker_config {
    immutable_tags = false
  }
}