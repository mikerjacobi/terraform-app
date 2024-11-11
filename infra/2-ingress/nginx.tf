# ingress/nginx.tf

resource "kubernetes_ingress_v1" "nginx" {
  metadata {
    name = "${terraform.workspace}-nginx-ingress"
    annotations = {
      "kubernetes.io/ingress.class"                  = "gce"
      "networking.gke.io/managed-certificates"       = "${terraform.workspace}-nginx-cert"
    }
  }

  spec {
    ingress_class_name = "gce"

    # allow direct curl access to this ip, without host header
    default_backend {
      service {
        name = kubernetes_service.nginx.metadata[0].name
        port {
          number = 80
        }
      }
    }

    rule {
      host = var.api_domain

      http {
        path {
          path      = "/"
          path_type = "Prefix"

          backend {
            service {
              name = kubernetes_service.nginx.metadata[0].name
              port {
                number = 80
              }
            }
          }
        }
      }
    }
  }
}

resource "kubernetes_deployment" "nginx" {
  metadata {
    name = "${terraform.workspace}-nginx-deployment"
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "nginx"
      }
    }

    template {
      metadata {
        labels = {
          app = "nginx"
        }
      }

      spec {
        container {
          name  = "nginx"
          image = "gcr.io/${var.project_id}/nginx:latest"

          port {
            container_port = 80
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "nginx" {
  metadata {
    name = "${terraform.workspace}-nginx-service"
    annotations = {
      "cloud.google.com/app-protocols" = jsonencode({
        "http" = "HTTP",
      })
    }
  }

  spec {
    selector = {
      app = "nginx"
    }

    type = "LoadBalancer"

    port {
      name        = "http"
      port        = 80
      target_port = 80
    }
  }
}