terraform {
  backend "s3" {
    bucket = "tfstate-ekanshdev-ap-south-1-lni5kq"
    key    = "ekansh/test/terraform.tfstate"
    region = "ap-south-1"
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

provider "kubernetes" {
  config_path = "~/.kubectx/config"
}

