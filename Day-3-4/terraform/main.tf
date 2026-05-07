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

  subnet_id         = module.vpc.public_subnet_id
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