variable "project_name" {}
variable "environment" {}
variable "owner" {}

variable "private_subnet_id" {
  type = list(string)
}

variable "rds_sg_id" {
  type = string
}

variable "db_username" {
  type = string
}

variable "db_password" {
  type      = string
  sensitive = true
}