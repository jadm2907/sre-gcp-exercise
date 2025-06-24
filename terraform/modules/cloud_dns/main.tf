resource "google_dns_managed_zone" "primary" {
  name     = "my-dns-zone"
  dns_name = "${var.domain}."
  project  = var.project_id
}

resource "google_dns_record_set" "a" {
  name         = google_dns_managed_zone.primary.dns_name
  type         = "A"
  ttl          = 300
  managed_zone = google_dns_managed_zone.primary.name
  rrdatas      = [var.load_balancer_ip]
  project      = var.project_id
}