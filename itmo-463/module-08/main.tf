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

resource "aws_launch_template" "lt" {
  name = "lt-project"
  image_id = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  placement {
    availability_zone = "us-east-2a"
  }
  user_data= filebase64("./install-env.sh")
  vpc_security_group_ids = [aws_security_group.project.id]
  key_name = data.aws_key_pair.key_pair.key_name
  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = var.item_tag
    }
  }
}

##############################################################################
# Create Security Group and create rules for port 80 and 22 access
#
##############################################################################
resource "aws_security_group" "project" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.main.id

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

resource "aws_vpc_security_group_ingress_rule" "allow_http_ipv4" {
  security_group_id = aws_security_group.project.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.project.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}


##############################################################################
# Link to aws_vpc
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc
##############################################################################

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames = true

  tags = {
    Name = var.item_tag
  }
}
##############################################################################
# Create an AWS subnet
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet
##############################################################################

resource "aws_subnet" "us-east-2a" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.0.0/24"
  availability_zone = "us-east-2a"
  map_public_ip_on_launch = true

  tags = {
    Name = var.item_tag
  }
}

resource "aws_subnet" "us-east-2b" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.16.0/24"
  availability_zone = "us-east-2b"
  map_public_ip_on_launch = true

  tags = {
    Name = var.item_tag
  }
}

resource "aws_subnet" "us-east-2c" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.32.0/24"
  availability_zone = "us-east-2c"
  map_public_ip_on_launch = true

  tags = {
    Name = var.item_tag
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = var.item_tag
  }
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table
resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  route {
    cidr_block        = aws_vpc.main.cidr_block
    gateway_id = "local"
  }

  tags = {
    Name = var.item_tag
  }
} 
# link to route association
##############################################################################
# Main Route Table association
# Explanation of what a main route table is (hint important)
# https://docs.aws.amazon.com/vpc/latest/userguide/RouteTables.html
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/main_route_table_association
##############################################################################
resource "aws_main_route_table_association" "a" {
  vpc_id         = aws_vpc.main.id
  route_table_id = aws_route_table.rt.id
}

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.us-east-2a.id
  route_table_id = aws_route_table.rt.id
}

resource "aws_route_table_association" "b" {
  subnet_id      = aws_subnet.us-east-2b.id
  route_table_id = aws_route_table.rt.id
}

resource "aws_route_table_association" "c" {
  subnet_id      = aws_subnet.us-east-2c.id
  route_table_id = aws_route_table.rt.id
}