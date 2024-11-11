# ingress/variables.tf

variable "project_id" {
  description = "The ID of the GCP project to deploy to"
}

variable "api_domain" {
  description = "The domain of the api"
}

variable "app_domain" {
  description = "The domain of the app"
}

variable "app_slug" {
  description = "The slug of the app"
}
