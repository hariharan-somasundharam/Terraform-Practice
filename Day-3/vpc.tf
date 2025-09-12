# Virtual Private Cloud
resource "aws_vpc" "vpc" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"

  tags = {
    Name = "Harish-VPC"
  }
}

# Public Subnet 1
resource "aws_subnet" "Pub-Sub-1" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.Pub_sub_cidr[0]
  availability_zone = "us-west-2a"
  map_public_ip_on_launch = true

  tags = {
    Name = "Pub-Sub-1"
  }
}

# Public Subnet 2
resource "aws_subnet" "Pub-Sub-2" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.Pub_sub_cidr[1]
  availability_zone = "us-west-2b"
  map_public_ip_on_launch = true

  tags = {
    Name = "Pub-Sub-2"
  }
}

# Private Subnet 1
resource "aws_subnet" "Pri-Sub-1" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.Pri_sub_cidr[0]
  availability_zone = "us-west-2a"

  tags = {
    Name = "Pri-Sub-1"
  }
}

# Private Subnet 2
resource "aws_subnet" "Pri-Sub-2" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.Pri_sub_cidr[1]
  availability_zone = "us-west-2b"

  tags = {
    Name = "Pri-Sub-2"
  }
}

# Public Route Table
resource "aws_route_table" "Pub-Route-Tab" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "Public-Route-Table"
  }
}

# Private Route Table
resource "aws_route_table" "Pri-Route-Tab" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "Private-Route-Table"
  }
}

# Public Route Table Assosciation
resource "aws_route_table_association" "Pub-Sub1-to-Pub-Route" {
    subnet_id = aws_subnet.Pub-Sub-1.id
    route_table_id = aws_route_table.Pub-Route-Tab.id
}

resource "aws_route_table_association" "Pub-Sub2-to-Pub-Route" {
    subnet_id = aws_subnet.Pub-Sub-2.id
    route_table_id = aws_route_table.Pub-Route-Tab.id
}

# Private Route Table 
resource "aws_route_table_association" "Pri-Sub1-to-Pri-Route" {
    subnet_id = aws_subnet.Pri-Sub-1.id
    route_table_id = aws_route_table.Pri-Route-Tab.id
}

resource "aws_route_table_association" "Pri-Sub2-to-Pri-Route" {
    subnet_id = aws_subnet.Pri-Sub-2.id
    route_table_id = aws_route_table.Pri-Route-Tab.id
}

# Internet Gateway
resource "aws_internet_gateway" "My-IGW" {
    vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "My-IGW"
  }
}

resource "aws_route" "IGW-Route" {
    depends_on = [ aws_internet_gateway.My-IGW ]
    route_table_id = aws_route_table.Pub-Route-Tab.id
    destination_cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.My-IGW.id
}