provider "aws" {
  region = "us-west-2"
}

# Virtual Private Cloud
resource "aws_vpc" "vpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "Harish-VPC"
  }
}

# Public Subnet 1
resource "aws_subnet" "Pub-Sub-1" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-west-2a"
  map_public_ip_on_launch = true

  tags = {
    Name = "Pub-Sub-1"
  }
}

# Public Subnet 2
resource "aws_subnet" "Pub-Sub-2" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "us-west-2b"
  map_public_ip_on_launch = true

  tags = {
    Name = "Pub-Sub-2"
  }
}

# Private Subnet 1
resource "aws_subnet" "Pri-Sub-1" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = "10.0.3.0/24"
  availability_zone = "us-west-2a"

  tags = {
    Name = "Pri-Sub-1"
  }
}

# Private Subnet 2
resource "aws_subnet" "Pri-Sub-2" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = "10.0.4.0/24"
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

# Security Group
resource "aws_security_group" "Harish-Sec-Grp" {
    name = "Harish-Sec-Grp"
    vpc_id = aws_vpc.vpc.id

    tags = {
      Name = "Harish-Sec-Grp"
    }
}

# Inbound Rule for Security Group
resource "aws_security_group_rule" "Allow_HTTP" {
    type = "ingress"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["49.37.215.33/32"]
    security_group_id = aws_security_group.Harish-Sec-Grp.id

}

resource "aws_security_group_rule" "Allow_HTTPS" {
    type = "ingress"
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["49.37.215.33/32"]
    security_group_id = aws_security_group.Harish-Sec-Grp.id

}

resource "aws_security_group_rule" "Allow_SSH" {
    type = "ingress"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    security_group_id = aws_security_group.Harish-Sec-Grp.id

}

# Outbound Rule for Security Group
resource "aws_security_group_rule" "ToAll" {
    type = "egress"
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    security_group_id = aws_security_group.Harish-Sec-Grp.id
}

# Creating EC2 Instance using the Above vpc
resource "aws_instance" "Harish-EC2" {
    vpc_security_group_ids = [ aws_security_group.Harish-Sec-Grp.id ]
    ami = "ami-031e41cca3593a9ef"
    instance_type = "t3.micro"
    subnet_id = aws_subnet.Pub-Sub-1.id
    key_name = "Harish-Key"

    user_data = <<-EOF
        #!/bin/bash
        yum update -y
        yum install httpd -y
        systemctl start httpd
        systemctl enable httpd
        echo "<center><h1>Terraform Template Instance <strong style='color:red'>HariHaran</strong></h1></center>" > /var/www/html/index.html
        EOF

    tags = {
      Name = "Harish-EC2"
    }
}


# Creating EC2 Instance using the Above vpc
resource "aws_instance" "Prathi-EC2" {
    vpc_security_group_ids = [ aws_security_group.Harish-Sec-Grp.id ]
    ami = "ami-0940cd7067a1e7086"
    instance_type = "t3.micro"
    subnet_id = aws_subnet.Pub-Sub-2.id
    key_name = "Harish-Key"

    user_data = <<-EOF
        #!/bin/bash
        yum update -y
        yum install httpd -y
        systemctl start httpd
        systemctl enable httpd
        echo "<center><h1>Terraform Template Instance <strong style='color:blue'>Pratheeba</strong></h1></center>" > /var/www/html/index.html
        EOF

    tags = {
      Name = "Prathi-EC2"
    }
}

#Outputs
output "VPC-ID" {
    value = aws_vpc.vpc.id
}

output "Security-Group-ID" {
    value = aws_security_group.Harish-Sec-Grp.id
}

output "IGW_ID" {
    value = aws_internet_gateway.My-IGW.id
}

output "EC2-ID" {
    value = aws_instance.Harish-EC2.id
}