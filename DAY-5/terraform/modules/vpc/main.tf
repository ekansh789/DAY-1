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
    Name        = "public-subnet"
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

resource "aws_subnet" "private_subnet" {
  vpc_id            = data.aws_vpc.existing_vpc.id
  cidr_block        = "10.0.144.0/24"
  availability_zone = data.aws_availability_zones.available.names[0]

  tags = {
    Name        = "private-subnet"
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

resource "aws_eip" "nat_eip" {
  domain = "vpc"

  tags = {
    Name        = "nat-eip"
    Owner       = var.owner
    DM          = var.dm
    Department  = var.department
    ProjectName = var.project_name
    EndDate     = var.end_date
    BU          = var.bu
  }
}

#########################################################
# NAT GATEWAY
#########################################################

resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public_subnet.id

  tags = {
    Name        = "nat-gateway"
    Owner       = var.owner
    DM          = var.dm
    Department  = var.department
    ProjectName = var.project_name
    EndDate     = var.end_date
    BU          = var.bu
  }

  depends_on = [data.aws_internet_gateway.existing_igw]
}

#########################################################
# PRIVATE ROUTE TABLE
#########################################################

resource "aws_route_table" "private_rt" {
  vpc_id = data.aws_vpc.existing_vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gw.id
  }

  tags = {
    Name        = "private-route-table"
    Owner       = var.owner
    DM          = var.dm
    Department  = var.department
    ProjectName = var.project_name
    EndDate     = var.end_date
    BU          = var.bu
  }
}

#########################################################
# ASSOCIATE PUBLIC SUBNET
# WITH EXISTING PUBLIC ROUTE TABLE
#########################################################

resource "aws_route_table_association" "public_assoc" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = data.aws_route_table.existing_public_rt.id
}

#########################################################
# ASSOCIATE PRIVATE SUBNET
# WITH PRIVATE ROUTE TABLE
#########################################################

resource "aws_route_table_association" "private_assoc" {
  subnet_id      = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.private_rt.id
}