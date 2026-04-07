# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "example" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  vpc_security_group_ids = [aws_security_group.project.id]
  #subnet_id = aws_subnet.us-east-2a.id
  #user_data_base64 = filebase64("./install-env.sh")
  key_name = data.aws_key_pair.key_pair.key_name

  tags = {
    Name = var.item_tag_template
  }
}

##############################################################################
# Data block to retrieve key pair name with particular filter
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/key_pair
##############################################################################
data "aws_key_pair" "key_pair" {

    filter {
    name = "tag:Name"
    values = [var.item_tag]
  }
}


##############################################################################
# Create Security Group and create rules for port 22 access
#
##############################################################################

resource "aws_security_group" "project" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic and all outbound traffic"

  tags = {
    Name = var.item_tag
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh_ipv4" {
  security_group_id = aws_security_group.project.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.project.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

