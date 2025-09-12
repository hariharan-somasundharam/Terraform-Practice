# Creating EC2 Instance using the Above vpc
resource "aws_instance" "Harish-EC2" {
    vpc_security_group_ids = [ aws_security_group.Harish-Sec-Grp.id ]
    ami = data.aws_ami.amazon_linux.image_id
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
    ami = data.aws_ami.amazon_linux.image_id
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
