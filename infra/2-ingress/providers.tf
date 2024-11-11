# ingress/providers.tf

data "terraform_remote_state" "cluster" {
  backend = "gcs"
  config = {
    bucket = "winball-terraform-remote-state"
    prefix = "cluster"
  }
  workspace = terraform.workspace
}

provider "google" {
  project = data.terraform_remote_state.cluster.outputs.project_id
  zone = data.terraform_remote_state.cluster.outputs.location
}

data "google_client_config" "default" {}

provider "kubernetes" {
  host                   = "https://${data.terraform_remote_state.cluster.outputs.cluster_endpoint}"
  token                  = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(data.terraform_remote_state.cluster.outputs.cluster_ca_certificate)
}
