resource "google_compute_instance" "bastion" {
  name         = "bastion"
  machine_type = "e2-micro"
  zone         = var.zone
  project      = var.project_id

  boot_disk {
    initialize_params {
      image = "projects/${var.project_id}/global/images/family/bastion"
    }
  }

  network_interface {
    subnetwork = var.subnet
    access_config {
      // Ephemeral public IP
    }
  }

  metadata = {
    enable-oslogin = "TRUE"
  }

  service_account {
    email  = "default"
    scopes = ["cloud-platform"]
  }

  tags = ["bastion"]
}

resource "google_compute_firewall" "bastion_ssh" {
  name    = "allow-bastion-ssh"
  network = "default"
  project = var.project_id

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["bastion"]
}