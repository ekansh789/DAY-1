#########################################################
# FETCH EXISTING VPC
#########################################################

data "aws_vpc" "existing_vpc" {
  id = var.vpc_id
}

#########################################################
# FETCH EXISTING INTERNET GATEWAY
#########################################################

data "aws_internet_gateway" "existing_igw" {
  internet_gateway_id = var.internet_gateway_id
}

#########################################################
# FETCH EXISTING PUBLIC ROUTE TABLE
#########################################################

data "aws_route_table" "existing_public_rt" {
  route_table_id = var.route_table_id
}

#########################################################
# FETCH AVAILABILITY ZONES
#########################################################

data "aws_availability_zones" "available" {}

#########################################################
# PUBLIC SUBNET
#########################################################

resource "aws_subnet" "public_subnet" {
  vpc_id                  = data.aws_vpc.existing_vpc.id
  cidr_block              = "10.0.14.0/24"
  availability_zone       = data.aws_availability_zones.available.names[0]
  map_public_ip_on_launch = true

  tags = {
    Name        = "ekansh-public-subnet"
    Owner       = var.owner
    DM          = var.dm
    Department  = var.department
    ProjectName = var.project_name
    EndDate     = var.end_date
    BU          = var.bu
  }
}

#########################################################
# PRIVATE SUBNET
#########################################################

resource "aws_subnet" "public_subnets" {
  vpc_id            = data.aws_vpc.existing_vpc.id
  cidr_block        = "10.0.144.0/24"
  availability_zone = data.aws_availability_zones.available.names[1]
  map_public_ip_on_launch = true
  tags = {
    Name        = "EKansh-public-subnet"
    Owner       = var.owner
    DM          = var.dm
    Department  = var.department
    ProjectName = var.project_name
    EndDate     = var.end_date
    BU          = var.bu
  }
}

#########################################################
# ELASTIC IP FOR NAT GATEWAY
#########################################################


#########################################################
# ASSOCIATE PUBLIC SUBNET
# WITH EXISTING PUBLIC ROUTE TABLE
#########################################################

resource "aws_route_table_association" "public_assoc" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = data.aws_route_table.existing_public_rt.id
}


resource "aws_route_table_association" "publicc_assoc" {
  subnet_id      = aws_subnet.public_subnets.id
  route_table_id = data.aws_route_table.existing_public_rt.id
}


#########################################################
# ASSOCIATE PRIVATE SUBNET
# WITH PRIVATE ROUTE TABLE
#########################################################

