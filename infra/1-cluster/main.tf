resource "google_container_cluster" "primary" {
  project             = var.project_id
  name                = var.cluster_name
  location            = var.location
  initial_node_count  = var.initial_node_count
  deletion_protection = false

  node_config {
    machine_type = var.machine_type
  }
}

provider "google" {
  project = var.project_id
  zone    = var.location
}

data "google_client_config" "default" {}

terraform {
  backend "gcs" {
    bucket = "winball-terraform-remote-state"
    prefix = "cluster"
  }
}