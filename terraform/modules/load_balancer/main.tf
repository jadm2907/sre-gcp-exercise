resource "google_compute_global_address" "default" {
  name    = "lb-ip"
  project = var.project_id
}

resource "google_compute_global_forwarding_rule" "default" {
  name       = "lb-forwarding-rule"
  project    = var.project_id
  ip_address = google_compute_global_address.default.address
  port_range = "80"
  target     = google_compute_target_http_proxy.default.self_link
}

resource "google_compute_target_http_proxy" "default" {
  name    = "lb-http-proxy"
  project = var.project_id
  url_map = google_compute_url_map.default.self_link
}

resource "google_compute_url_map" "default" {
  name            = "lb-url-map"
  project         = var.project_id
  default_service = google_compute_backend_service.default.self_link
}

resource "google_compute_backend_service" "default" {
  name        = "lb-backend"
  project     = var.project_id
  port_name   = "http"
  protocol    = "HTTP"
  timeout_sec = 30

  backend {
    group = var.instance_group
  }

  health_checks = [google_compute_health_check.default.self_link]
}

resource "google_compute_health_check" "default" {
  name               = "lb-health-check"
  project            = var.project_id
  check_interval_sec = 5
  timeout_sec        = 5

  tcp_health_check {
    port = 80
  }
}