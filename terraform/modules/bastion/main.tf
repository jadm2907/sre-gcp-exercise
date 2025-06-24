resource "google_compute_instance" "bastion" {
  name         = "bastion-host-${formatdate("YYYYMMDD", timestamp())}"
  machine_type = "e2-medium"
  zone         = var.zone
  project      = var.project_id

  boot_disk {
    initialize_params {
      # Usamos la imagen específica que creó Packer
      image = "projects/${var.project_id}/global/images/bastion-1750794437"
      # Alternativa usando la familia (si prefieres siempre la última imagen)
      # image = "projects/${var.project_id}/global/images/family/bastion"
    }
  }

  network_interface {
    subnetwork = var.subnet
    access_config {
      // Ephemeral public IP
    }
  }

  metadata = {
    enable-oslogin = "FALSE"
    ssh-keys       = "debian:${file("~/.ssh/id_rsa.pub")}" # Asegúrate de tener esta clave
  }

  service_account {
    email  = "default"
    scopes = ["cloud-platform"]
  }

  tags = ["bastion"]

  lifecycle {
    ignore_changes = [
      boot_disk[0].initialize_params[0].image,
      metadata["ssh-keys"]
    ]
  }
}