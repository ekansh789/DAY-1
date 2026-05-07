terraform { 
   backend "s3" {
     bucket = "tfstate-ekanshdev-ap-south-1-lni5kq"
     region = "ap-south-1"
     key = "s3/backend-test/terraform.tfstate"
     use_lockfile = true

   } 
  required_version = ">= 1.5.0" 
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}



provider "aws" {
  region = var.aws_region
}


