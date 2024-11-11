# resources/variables.tf

variable "db_host" {
  description = "The host of the database"
  type = string
}
variable "db_name" {
  description = "The name of the database"
  type = string
}
variable "db_user" {
  description = "The username for the database"
  type = string
}
variable "db_pass" {
  description = "The password for the database"
  type = string
}
