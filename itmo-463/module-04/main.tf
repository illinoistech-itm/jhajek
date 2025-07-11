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
# Block to create a data variable that is a list of all subnets tagged with module-04
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnets
##############################################################################
data "aws_subnets" "project" {
  filter {
    name   = "tag:Name"
    values = [var.tag]
  }
}

# Link to get all subnet ids dynamically
# Assign the values to a data object
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnets#example-usage
data "aws_subnet" "project" {
  for_each = toset(data.aws_subnets.project.ids)
  id       = each.value
}

output "subnet_ids" {
  value = [for s in data.aws_subnet.project : s.id]
}

##############################################################################
# BLock to create an AWS Security Group (firewall for AWS Ec2 instances)
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group
##############################################################################

resource "aws_security_group" "allow_module_04" {
  name        = "allow_module_03"
  description = "Allow HTTP inbound traffic and all outbound traffic for module 03"
  vpc_id      = aws_vpc.main.id

  tags = {
    Name = var.tag
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_http_ipv4" {
  security_group_id = aws_security_group.allow_module_04.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_ingress_rule" "allow_https_ipv4" {
  security_group_id = aws_security_group.allow_module_04.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh_ipv4" {
  security_group_id = aws_security_group.allow_module_04.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.allow_module_04.id
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

resource "aws_instance" "module_04" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance-type
  key_name = var.key-name
  vpc_security_group_ids = [aws_security_group.allow_module_04.id]
  subnet_id = aws_subnet.subneta.id
  user_data = file("./install-env.sh")

  tags = {
    Name = var.tag
  }
}

##############################################################################
# Block to create AWS ELB (Elastic Load Balancer)
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb
##############################################################################
resource "aws_lb" "production" {
  depends_on = [ data.aws_subnets.project, data.aws_subnet.project ]
  name               = var.elb-name
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.allow_module_04.id]
  subnets            = [aws_subnet.subneta.id,aws_subnet.subnetb.id,aws_subnet.subnetc.id]
  #subnets            = [for subnet in data.aws_subnet.project : subnet.id]

  tags = {
    Name = var.tag,
    Environment = "production"
  }
}

##############################################################################
# Block to create AWS ELB Listener
# Listen for traffic on a certain port (443 or 80) and balancer based on that
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener
##############################################################################

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.production.arn
  port              = "80"
  protocol          = "HTTP"
  #ssl_policy        = "ELBSecurityPolicy-2016-08"
  #certificate_arn   = "arn:aws:iam::187416307283:server-certificate/test_cert_rab3wuqwgja25ct3n4jdj2tzu4"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.front_end.arn
  }
}

##############################################################################
# Create AWS Target Group
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group
##############################################################################
resource "aws_lb_target_group" "front_end" {
  name     = var.tg-name
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id
}

##############################################################################
# Register EC2 instances with a target group and attach them to the LB
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group_attachment
##############################################################################
resource "aws_lb_target_group_attachment" "front_end" {
  target_group_arn = aws_lb_target_group.front_end.arn
  target_id        = aws_instance.module_04.id
  port             = 80
}
