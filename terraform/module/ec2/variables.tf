variable "key_name" {}
variable "vpc_id" {}
variable "subnet_id" {}
variable "allowed_ssh_ip" {}

variable "owner" {}
variable "dm" {}
variable "department" {}
variable "project_name" {}
variable "end_date" {}
variable "bu" {}
variable "security_group_id" {
  description = "Security Group ID for EC2"
  type        = string
}