
terraform {
  backend "gcs" {
    bucket = "winball-terraform-remote-state"
    prefix = "ingress"
  }
}