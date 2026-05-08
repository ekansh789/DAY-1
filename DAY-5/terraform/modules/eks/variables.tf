variable "cluster_name" {}
variable "cluster_version" {}
variable "vpc_id" {}


variable "security_group_id" {
  type = list(string)
}


variable "desired_size" {}
variable "min_size" {}
variable "max_size" {}

variable "instance_type" {
}

variable "environment" {}
variable "owner" {
  type = string
  }
variable "bu" {}
variable "project_name" {}
variable "dm" {}
variable "department" {}
variable "end_date" {}
variable "private_subnet_id" {
  type = list(string)
}
variable "allowed_cidr" {
  type = string
}


