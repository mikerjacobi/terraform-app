# ingress/cert.tf

resource "kubernetes_manifest" "nginx_cert" {
  manifest = {
    "apiVersion" = "networking.gke.io/v1"
    "kind"       = "ManagedCertificate"
    "metadata" = {
      "name" = "${terraform.workspace}-nginx-cert"
      "namespace" = "default"
    }
    "spec" = {
      "domains" = [var.api_domain]
    }
  }
}

resource "google_compute_managed_ssl_certificate" "app_cert" {
  name = "${terraform.workspace}-app-cert"
  project = var.project_id
  managed {
    domains = [var.app_domain]
  }
}
