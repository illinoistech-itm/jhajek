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
  enable_dns_hostnames = true

  tags = {
    Name = var.tag
  }
}

##############################################################################
# Block to create an Internet Gateway
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway
##############################################################################

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = var.tag,
    Type = "main"
  }
}

# Create VPC DHCP options -- public DNS provided by Amazon
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_dhcp_options

resource "aws_vpc_dhcp_options" "dns_resolver" {
  domain_name_servers = ["AmazonProvidedDNS"]

    tags = {
    Name = var.tag
  }
}

# Associate these options with our VPC now
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_dhcp_options_association

resource "aws_vpc_dhcp_options_association" "dns_resolver" {
  vpc_id          = aws_vpc.main.id
  dhcp_options_id = aws_vpc_dhcp_options.dns_resolver.id
}

# Now we need to create the route_table to subnets
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table
resource "aws_route_table" "main" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = var.tag
  }
}

# Now we need to create the route_table to subnets
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.subneta.id
  route_table_id = aws_route_table.main.id
}

resource "aws_route_table_association" "b" {
  subnet_id      = aws_subnet.subnetb.id
  route_table_id = aws_route_table.main.id
}

resource "aws_route_table_association" "c" {
  subnet_id      = aws_subnet.subnetc.id
  route_table_id = aws_route_table.main.id
}

# Now associated the route table
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/main_route_table_association

resource "aws_main_route_table_association" "a" {
  vpc_id         = aws_vpc.main.id
  route_table_id = aws_route_table.main.id
}

##############################################################################
# BLock to create a subnet for our VPC
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet
##############################################################################
resource "aws_subnet" "subneta" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"
  availability_zone = var.az[0]
  map_public_ip_on_launch = true

  tags = {
    Name = var.tag
  }
}

resource "aws_subnet" "subnetb" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.2.0/24"
  availability_zone = var.az[1]
  map_public_ip_on_launch = true

  tags = {
    Name = var.tag
  }
}

resource "aws_subnet" "subnetc" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.3.0/24"
  availability_zone = var.az[2]
  map_public_ip_on_launch = true

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
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh_ipv4" {
  security_group_id = aws_security_group.allow_module_03.id
  cidr_ipv4         = "0.0.0.0/0"
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
  subnet_id = aws_subnet.subneta.id
  user_data = file("./install-env.sh")

  tags = {
    Name = var.tag
  }
}