data "aws_ami" "al2023" {
  most_recent = true

  owners = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023*-x86_64"]
  }
}

module "vpc" {
  source = "./modules/vpc"

  owner        = var.owner
  dm           = var.dm
  department   = var.department
  project_name = var.project_name
  end_date     = var.end_date
  bu           = var.bu
  vpc_id       = var.vpc_id
  route_table_id      = var.route_table_id
  internet_gateway_id = var.internet_gateway_id
}

module "security_group" {
  source = "./modules/security-group"

  vpc_id         = var.vpc_id
  allowed_ssh_ip = var.allowed_ssh_ip

  owner        = var.owner
  dm           = var.dm
  department   = var.department
  project_name = var.project_name
  end_date     = var.end_date
  bu           = var.bu
}

module "flow_logs" {
  source = "./modules/flow-logs"

  vpc_id = var.vpc_id
}


module "ec2" {
  source = "./modules/ec2"

  subnet_id         = module.vpc.public_subnet_ids[0]
  security_group_id = module.security_group.sg_id
  key_name          = var.key_name
  owner        = var.owner
  dm           = var.dm
  department   = var.department
  project_name = var.project_name
  end_date     = var.end_date
  bu           = var.bu
}

module "s3" {
  source = "./modules/s3"
  
  owner        = var.owner
  dm           = var.dm
  department   = var.department
  project_name = var.project_name
  end_date     = var.end_date
  bu           = var.bu
  

}

module "eks" {
  source = "./modules/eks"

  cluster_name       = var.cluster_name
  cluster_version    = var.cluster_version
  vpc_id             = var.vpc_id
  security_group_id = [ module.security_group.sg_id ]
  private_subnet_id = module.vpc.public_subnet_ids
  desired_size = var.desired_size
  min_size = var.min_size
  max_size = var.max_size
  owner        = var.owner
  dm           = var.dm
  department   = var.department
  project_name = var.project_name
  end_date     = var.end_date
  bu           = var.bu
  instance_type =[ var.instance_type ]
  environment =  var.environment
  allowed_cidr = var.allowed_cidr
  public_cidr =  var.public_cidr
  }

module "rds" {
  source = "./modules/rds"

  project_name     = var.project_name
  environment      = var.environment
  owner            = var.owner

  private_subnet_id = module.vpc.private_subnet_ids

  rds_sg_id = module.security_group.rds_sg_id

  db_username = var.db_username
  db_password = var.db_password
}