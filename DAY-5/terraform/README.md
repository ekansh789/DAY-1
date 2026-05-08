Terraform AWS Infrastructure Setup Overview

This project provisions AWS infrastructure using Terraform modules and follows Infrastructure as Code (IaC) best practices.
The setup includes:

VPC integration Public and Private subnet creation NAT Gateway configuration Route tables and associations EC2 module S3 module VPC Flow Logs module Remote backend configuration using S3 Resource tagging standards Modular Terraform structure Implemented Components VPC Integration Used an existing VPC as the base infrastructure. Fetched existing: VPC Internet Gateway Route Table Created: Public subnet Private subnet Private route table Route table associations Networking Setup Public Subnet Auto assigns public IPs Uses existing Internet Gateway Associated with existing public route table Private Subnet Internet access through NAT Gateway Associated with dedicated private route table NAT Gateway Created Elastic IP Attached NAT Gateway in public subnet Configured private subnet outbound internet access Terraform Modules Created VPC Module

Handles:

VPC related resources Subnets Route tables NAT Gateway Networking components EC2 Module

Handles:

EC2 instance creation Security groups Instance configuration S3 Module

Handles:

S3 bucket creation Versioning configuration Backend bucket setup Flow Logs Module

Handles:

VPC Flow Logs CloudWatch integration/logging Remote Backend Configuration

Created a dedicated S3 bucket for Terraform remote backend.

Features configured:

Remote state storage State locking readiness Bucket versioning enabled

Example backend configuration:

terraform { backend "s3" { bucket = "tfstate-ekanshdev-ap-south-1-lni5kq" key = "terraform/dev/terraform.tfstate" region = "ap-south-1" } } Resource Tagging Standard

Applied consistent tagging across all resources.

Tags used:

tags = { Owner = var.owner DM = var.dm Department = var.department ProjectName = var.project_name EndDate = var.end_date BU = var.bu } Validation & Testing

Successfully tested:

VPC resource creation Public and private subnet provisioning NAT Gateway deployment Route table associations Internet connectivity Remote backend functionality S3 bucket creation Terraform module integration