resource "google_compute_global_address" "lb_ip" {
  name = "lb-ip-address"
}

# Health Check para el balanceador de carga
resource "google_compute_health_check" "http" {
  name = "http-health-check-new"  # Change to a unique name
  http_health_check {
    port         = 80
    request_path = "/"
  }
  check_interval_sec   = 5
  timeout_sec          = 5
  healthy_threshold    = 2
  unhealthy_threshold  = 3
}

resource "google_compute_backend_service" "default" {
  name        = "web-backend-service"
  port_name   = "http"
  protocol    = "HTTP"
  timeout_sec = 30
  enable_cdn  = false

  health_checks = [google_compute_health_check.http.id]  # Health check añadido aquí

  backend {
    group = replace(
      var.instance_group,
      "instanceGroupManagers",
      "instanceGroups"
    )
    balancing_mode = "UTILIZATION"
  }
}

resource "google_compute_url_map" "default" {
  name            = "web-map"
  default_service = google_compute_backend_service.default.self_link
}

resource "google_compute_target_http_proxy" "default" {
  name    = "http-proxy"
  url_map = google_compute_url_map.default.self_link
}

resource "google_compute_global_forwarding_rule" "default" {
  name       = "http-rule"
  target     = google_compute_target_http_proxy.default.self_link
  port_range = "80"
  ip_address = google_compute_global_address.lb_ip.address
}