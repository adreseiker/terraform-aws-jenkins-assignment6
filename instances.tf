# - All EC2 in our VPC & subnets
# - Uses SSM Parameter for latest AL2023 AMI
# - Subnet placement: main_a for Jenkins/Testing/Staging, main_b for Prod1/Prod2 

# Latest Amazon Linux 2023 AMI via SSM
data "aws_ssm_parameter" "al2023" {
  name = "/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-6.1-x86_64"
}

locals {
  ami_id = data.aws_ssm_parameter.al2023.value
}

# Jenkins Controller
resource "aws_instance" "JenkinsController" {
  ami                         = local.ami_id
  instance_type               = "t3.micro"
  subnet_id                   = aws_subnet.main_a.id
  vpc_security_group_ids      = [aws_security_group.jenkins_sg.id]
  key_name                    = var.key_name
  associate_public_ip_address = true

  tags = { Name = "JenkinsController" }

  # Minimal user_data to install Jenkins
  user_data = <<-EOF
    #!/bin/bash
    set -e
    dnf update -y
    dnf install -y java-21-amazon-corretto wget
    rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
    dnf install -y https://pkg.jenkins.io/redhat-stable/jenkins-2.462.3-1.1.noarch.rpm
    systemctl enable --now jenkins
  EOF

  root_block_device {
    volume_size = 20
    volume_type = "gp3"
    delete_on_termination = true
  }
}

# Testing
resource "aws_instance" "Testing_Env" {
  ami                         = local.ami_id
  instance_type               = "t3.micro"
  subnet_id                   = aws_subnet.main_a.id
  vpc_security_group_ids      = [aws_security_group.web_sg.id]
  key_name                    = var.key_name
  associate_public_ip_address = true
  tags = { Name = "Testing_Env" }

  user_data = <<-EOF
    #!/bin/bash
    dnf update -y
    dnf install -y httpd
    systemctl enable --now httpd
    echo "<h1>Testing_Env</h1>" > /var/www/html/index.html
  EOF
}

# Staging
resource "aws_instance" "Staging_Env" {
  ami                         = local.ami_id
  instance_type               = "t3.micro"
  subnet_id                   = aws_subnet.main_a.id
  vpc_security_group_ids      = [aws_security_group.web_sg.id]
  key_name                    = var.key_name
  associate_public_ip_address = true
  tags = { Name = "Staging_Env" }

  user_data = <<-EOF
    #!/bin/bash
    dnf update -y
    dnf install -y httpd
    systemctl enable --now httpd
    echo "<h1>Staging_Env</h1>" > /var/www/html/index.html
  EOF
}

# Production 1
resource "aws_instance" "Production_Env1" {
  ami                         = local.ami_id
  instance_type               = "t3.micro"
  subnet_id                   = aws_subnet.main_b.id
  vpc_security_group_ids      = [aws_security_group.web_sg.id]
  key_name                    = var.key_name
  associate_public_ip_address = true
  tags = { Name = "Production_Env1" }

  user_data = <<-EOF
    #!/bin/bash
    dnf update -y
    dnf install -y httpd
    systemctl enable --now httpd
    echo "<h1>Hello from Production_Env1</h1>" > /var/www/html/index.html
  EOF
}

# Production 2
resource "aws_instance" "Production_Env2" {
  ami                         = local.ami_id
  instance_type               = "t3.micro"
  subnet_id                   = aws_subnet.main_b.id
  vpc_security_group_ids      = [aws_security_group.web_sg.id]
  key_name                    = var.key_name
  associate_public_ip_address = true
  tags = { Name = "Production_Env2" }

  user_data = <<-EOF
    #!/bin/bash
    dnf update -y
    dnf install -y httpd
    systemctl enable --now httpd
    echo "<h1>Hello from Production_Env2</h1>" > /var/www/html/index.html
  EOF
}
