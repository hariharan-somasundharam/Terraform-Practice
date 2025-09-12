# Security Group
resource "aws_security_group" "Harish-Sec-Grp" {
    name = var.sec_grp_name
    vpc_id = aws_vpc.vpc.id

    tags = {
      Name = var.sec_grp_name
    }
}

# Inbound Rule for Security Group
resource "aws_security_group_rule" "Allow_HTTP" {
    type = "ingress"
    from_port = var.Port_Numbers[0] 
    to_port = var.Port_Numbers[0]
    protocol = "tcp"
    cidr_blocks = [var.Inbound_Range]
    security_group_id = aws_security_group.Harish-Sec-Grp.id

}

resource "aws_security_group_rule" "Allow_HTTPS" {
    type = "ingress"
    from_port = var.Port_Numbers[1]
    to_port = var.Port_Numbers[1]
    protocol = "tcp"
    cidr_blocks = [var.Inbound_Range]
    security_group_id = aws_security_group.Harish-Sec-Grp.id

}

resource "aws_security_group_rule" "Allow_SSH" {
    type = "ingress"
    from_port = var.Port_Numbers[2]
    to_port = var.Port_Numbers[2]
    protocol = "tcp"
    cidr_blocks = [var.Inbound_Range]
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
