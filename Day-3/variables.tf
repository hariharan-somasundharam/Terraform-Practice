# VPC variables
variable "vpc_cidr" {
    description = "Enter CIDR range for your VPC:"
    type = string
}

variable "Pub_sub_cidr" {
    description = "Enter CIDR range for 2 Public Subnets:"
    type = list(string)
}

variable "Pri_sub_cidr" {
    description = "Enter CIDR range for 2 Private Subnets:"
    type = list(string)
}




# Security Group Variables
variable "sec_grp_name" {
  type = string
}

variable "Inbound_Range" {
    description = "Enter Your Security group Inbound CIDR Range:"
    type = string
}

variable "Port_Numbers" {
  description = "Enter 3 Port numbers for ur Port:"
  type = list(number)
}



# EC2 Instance variables
variable "EC2-name" {
    description = "Enter Name for ur Instance:"
    type = string
}