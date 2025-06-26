# main.tf is the main declarative logic file
# this is where we tell AWS what we want
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones

##############################################################################
# Block of code to create Virtual Private Cloud VPC for all out networking 
# needs
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc
##############################################################################
resource "aws_vpc" "main" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = var.tag
  }
}

##############################################################################
# BLock to create a subnet for our VPC
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet
##############################################################################
resource "aws_subnet" "main" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = var.tag
  }
}

##############################################################################
# BLock to create an AWS Security Group (firewall for AWS Ec2 instances)
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group
##############################################################################

resource "aws_security_group" "allow_module_03" {
  name        = "allow_module_03"
  description = "Allow HTTP inbound traffic and all outbound traffic for module 03"
  vpc_id      = aws_vpc.main.id

  tags = {
    Name = var.tag
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_http_ipv4" {
  security_group_id = aws_security_group.allow_module_03.id
  cidr_ipv4         = aws_vpc.main.cidr_block
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh_ipv4" {
  security_group_id = aws_security_group.allow_module_03.id
  cidr_ipv4         = aws_vpc.main.cidr_block
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.allow_module_03.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

###############################################################################
# Block to create AWS EC2 instance
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance
##############################################################################
data "aws_ami" "ubuntu" {
  most_recent = true
  
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "module_03" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance-type
  key_name = var.key-name
  vpc_security_group_ids = [aws_security_group.allow_module_03.id]
  subnet_id = aws_subnet.main.id

  tags = {
    Name = var.tag
  }
}