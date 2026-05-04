variable "aws_region" {
  default = "ap-south-1"
}

variable "key_name" {
  description = "SSH Key Pair"
}

variable "public_key_path" {
  description = "Path to SSH public key"
}

variable "vpc_id" {}

variable "subnet_id" {}

variable "allowed_ssh_ip" {
  description = "Your public IP"
}

variable "owner" {}
variable "dm" {}
variable "department" {}
variable "project_name" {}
variable "end_date" {}
variable "bu" {}