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