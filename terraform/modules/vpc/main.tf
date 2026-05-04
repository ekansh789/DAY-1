resource "aws_vpc" "Ekansh_vpc_bootcamp" {
  cidr_block           = "10.10.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name        = "secure-vpc"
    Owner       = var.owner
    DM          = var.dm
    Department  = var.department
    ProjectName = var.project_name
    EndDate     = var.end_date
    BU          = var.bu
  }
}

resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.Ekansh_vpc_bootcamp.id
  cidr_block              = "10.10.1.0/24"
  availability_zone       = "ap-south-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.Ekansh_vpc_bootcamp.id
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.Ekansh_vpc_bootcamp.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_route_table_association" "assoc" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public_rt.id
}