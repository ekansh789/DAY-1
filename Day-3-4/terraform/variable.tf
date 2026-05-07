variable "aws_region" {
  description = "AWS Region"
  default     = "ap-south-1"
}

variable "key_name" {
  description = "Existing AWS EC2 Key Pair Name"
  type        = string
}

variable "allowed_ssh_ip" {
  description = "Your Public IP with /32"
  type        = string
}

variable "owner" {
  type = string
}

variable "dm" {
  type = string
}

variable "department" {
  type = string
}

variable "project_name" {
  type = string
}

variable "end_date" {
  type = string
}

variable "bu" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "route_table_id" {
 type = string 
}

variable "internet_gateway_id" {
  type = string
}