variable "environment_name" {
  description = "Deployment environment (e.g., dev, staging, prod)"
  type        = string
  default     = "dev"
}

variable "aws_region" {
  description = "AWS Region"
  type        = string
  default     = "ap-south-1"
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
