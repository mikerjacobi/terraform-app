# ingress/static_site.tf

resource "google_storage_bucket" "static_site" {
  name          = var.app_domain
  location      = "US"
  uniform_bucket_level_access = true 
  force_destroy = true
  website {
    main_page_suffix = "index.html"
    not_found_page   = "index.html"
  }
}

resource "google_compute_backend_bucket" "static_site_backend" {
  name        = "${var.app_slug}-backend"
  bucket_name = google_storage_bucket.static_site.name
  enable_cdn  = true
}

resource "google_compute_url_map" "static_site_map" {
  name            = var.app_slug
  default_service = google_compute_backend_bucket.static_site_backend.self_link
}

resource "google_compute_target_http_proxy" "static_site_proxy" {
  name    = "${var.app_slug}-http-proxy"
  url_map = google_compute_url_map.static_site_map.self_link
}

resource "google_compute_target_https_proxy" "static_site_https_proxy" {
  name        = "${var.app_slug}-https-proxy"
  url_map     = google_compute_url_map.static_site_map.self_link
  ssl_certificates = [google_compute_managed_ssl_certificate.app_cert.self_link]
}

resource "google_compute_global_forwarding_rule" "static_site_forwarding_rule" {
  name                  = "${var.app_slug}-forwarding-rule"
  target                = google_compute_target_http_proxy.static_site_proxy.self_link
  port_range            = "80"
  load_balancing_scheme = "EXTERNAL"
}

resource "google_compute_global_forwarding_rule" "static_site_https_forwarding_rule" {
  name                  = "${var.app_slug}-https-forwarding-rule"
  target                = google_compute_target_https_proxy.static_site_https_proxy.self_link
  port_range            = "443"
  load_balancing_scheme = "EXTERNAL"
}

# Allow public access to the static site
resource "google_storage_bucket_iam_member" "public_access" {
  bucket = google_storage_bucket.static_site.name
  role   = "roles/storage.objectViewer"
  member = "allUsers"
}