terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "ap-south-1"
}

# VPC
resource "aws_vpc" "yash_uppal_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "Yash_Uppal_VPC"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "yash_uppal_igw" {
  vpc_id = aws_vpc.yash_uppal_vpc.id

  tags = {
    Name = "Yash_Uppal_IGW"
  }
}

# Public Subnets
resource "aws_subnet" "yash_uppal_public_subnet_1" {
  vpc_id                  = aws_vpc.yash_uppal_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "ap-south-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "Yash_Uppal_Public_Subnet_1"
  }
}

resource "aws_subnet" "yash_uppal_public_subnet_2" {
  vpc_id                  = aws_vpc.yash_uppal_vpc.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "ap-south-1b"
  map_public_ip_on_launch = true

  tags = {
    Name = "Yash_Uppal_Public_Subnet_2"
  }
}

# Private Subnets
resource "aws_subnet" "yash_uppal_private_subnet_1" {
  vpc_id            = aws_vpc.yash_uppal_vpc.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "ap-south-1a"

  tags = {
    Name = "Yash_Uppal_Private_Subnet_1"
  }
}

resource "aws_subnet" "yash_uppal_private_subnet_2" {
  vpc_id            = aws_vpc.yash_uppal_vpc.id
  cidr_block        = "10.0.4.0/24"
  availability_zone = "ap-south-1b"

  tags = {
    Name = "Yash_Uppal_Private_Subnet_2"
  }
}

# Elastic IP for NAT Gateway
resource "aws_eip" "yash_uppal_nat_eip" {
  domain = "vpc"

  tags = {
    Name = "Yash_Uppal_NAT_EIP"
  }

  depends_on = [aws_internet_gateway.yash_uppal_igw]
}

# NAT Gateway (in public subnet)
resource "aws_nat_gateway" "yash_uppal_nat_gateway" {
  allocation_id = aws_eip.yash_uppal_nat_eip.id
  subnet_id     = aws_subnet.yash_uppal_public_subnet_1.id

  tags = {
    Name = "Yash_Uppal_NAT_Gateway"
  }

  depends_on = [aws_internet_gateway.yash_uppal_igw]
}

# Public Route Table
resource "aws_route_table" "yash_uppal_public_rt" {
  vpc_id = aws_vpc.yash_uppal_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.yash_uppal_igw.id
  }

  tags = {
    Name = "Yash_Uppal_Public_RT"
  }
}

# Associate Public Subnets with Public Route Table
resource "aws_route_table_association" "yash_uppal_public_subnet_1_association" {
  subnet_id      = aws_subnet.yash_uppal_public_subnet_1.id
  route_table_id = aws_route_table.yash_uppal_public_rt.id
}

resource "aws_route_table_association" "yash_uppal_public_subnet_2_association" {
  subnet_id      = aws_subnet.yash_uppal_public_subnet_2.id
  route_table_id = aws_route_table.yash_uppal_public_rt.id
}

# Private Route Table
resource "aws_route_table" "yash_uppal_private_rt" {
  vpc_id = aws_vpc.yash_uppal_vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.yash_uppal_nat_gateway.id
  }

  tags = {
    Name = "Yash_Uppal_Private_RT"
  }
}

# Associate Private Subnets with Private Route Table
resource "aws_route_table_association" "yash_uppal_private_subnet_1_association" {
  subnet_id      = aws_subnet.yash_uppal_private_subnet_1.id
  route_table_id = aws_route_table.yash_uppal_private_rt.id
}

resource "aws_route_table_association" "yash_uppal_private_subnet_2_association" {
  subnet_id      = aws_subnet.yash_uppal_private_subnet_2.id
  route_table_id = aws_route_table.yash_uppal_private_rt.id
}

# Outputs
output "vpc_id" {
  value = aws_vpc.yash_uppal_vpc.id
}

output "public_subnet_1_id" {
  value = aws_subnet.yash_uppal_public_subnet_1.id
}

output "public_subnet_2_id" {
  value = aws_subnet.yash_uppal_public_subnet_2.id
}

output "private_subnet_1_id" {
  value = aws_subnet.yash_uppal_private_subnet_1.id
}

output "private_subnet_2_id" {
  value = aws_subnet.yash_uppal_private_subnet_2.id
}
