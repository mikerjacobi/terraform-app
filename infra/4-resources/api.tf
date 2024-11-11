# resources/api.tf

locals {
  api_labels = {
    app = "api"
  }
  env_vars = {
    APP_NAME : "api"
    DB_HOST : var.db_host
    DB_NAME : var.db_name
    DB_USER : var.db_user
    DB_PASS : var.db_pass
  }
}

resource "kubernetes_deployment" "api" {
  metadata {
    name = "api-deployment"
  }
  spec {
    replicas = 1
    selector {
      match_labels = local.api_labels
    }
    template {
      metadata {
        labels = local.api_labels
      }
      spec {
        container {
          name  = "api-container"
          image = "gcr.io/socket-os/api:latest"
          port {
            container_port = 3000
          }
          dynamic "env" {
            for_each = local.env_vars
            content {
              name  = env.key
              value = env.value
            }
          }

        }
      }
    }
  }
}

resource "kubernetes_service" "api" {
  metadata {
    name = "api-service"
  }
  spec {
    type = "LoadBalancer"
    selector = local.api_labels
    port {
      port        = 80
      target_port = 3000
    }
  }
}