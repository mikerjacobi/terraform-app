# cluster/variables.tf

variable "project_id" {
  description = "The ID of the GCP project to deploy to"
}

variable "cluster_name" {
  description = "The name of this cluster"
}

variable "location" {
  description = "The region or zone to deploy the cluster in"
  type        = string
  default     = "us-west2-a"
}

variable "machine_type" {
  description = "The machine type to use for the cluster nodes"
  type        = string
}

variable "initial_node_count" {
  description = "The initial number of nodes to create in the cluster"
  type        = number
}
