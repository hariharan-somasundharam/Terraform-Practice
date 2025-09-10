variable "vpc_cidr" {
    description = "VPC CIDR Block Range"
    type = string
    default = "10.0.0.0/16"
}

variable "Pub_sub1_cidr" {
    description = "Public Subnet 1's CIDR Block Range"
    type = string
    default = "10.0.1.0/24"
}

variable "Pub_sub2_cidr" {
    description = "Public Subnet 2's CIDR Block Range"
    type = string
    default = "10.0.2.0/24"
}

variable "Pri_sub1_cidr" {
    description = "Private Subnet 1's CIDR Block Range"
    type = string
    default = "10.0.3.0/24"
}

variable "Pri_sub2_cidr" {
    description = "Private Subnet 2's CIDR Block Range"
    type = string
    default = "10.0.4.0/24"
}

variable "Inbound_Range" {
    description = "Private Subnet 2's CIDR Block Range"
    type = string
    default = "0.0.0.0/0"
}
