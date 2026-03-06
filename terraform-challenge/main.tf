resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames = true
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = var.item_tag
  }
}

##############################################################################
# Create an AWS subnet
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet
##############################################################################

resource "aws_subnet" "us-east-2a" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.0.0/24"
  availability_zone       = "us-east-2a"
  map_public_ip_on_launch = true

  tags = {
    Name = var.item_tag
  }
}

resource "aws_subnet" "us-east-2b" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.16.0/24"
  availability_zone       = "us-east-2b"
  map_public_ip_on_launch = true

  tags = {
    Name = var.item_tag
  }
}

resource "aws_subnet" "us-east-2c" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.32.0/24"
  availability_zone       = "us-east-2c"
  map_public_ip_on_launch = true

  tags = {
    Name = var.item_tag
  }
}

resource "aws_route_table" "example" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  route {
    cidr_block = aws_vpc.main.cidr_block
    gateway_id = "local"
  }

  tags = {
    Name = var.item_tag
  }
}

resource "aws_route_table_association" "us-east-2a" {
  subnet_id      = aws_subnet.us-east-2a.id
  route_table_id = aws_route_table.example.id
}

resource "aws_route_table_association" "us-east-2b" {
  subnet_id      = aws_subnet.us-east-2b.id
  route_table_id = aws_route_table.example.id
}

resource "aws_route_table_association" "us-east-2c" {
  subnet_id      = aws_subnet.us-east-2c.id
  route_table_id = aws_route_table.example.id
}

##############################################################################
# Main Route Table association
# Explanation of what a main route table is (hint important)
# https://docs.aws.amazon.com/vpc/latest/userguide/RouteTables.html
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/main_route_table_association
##############################################################################
resource "aws_main_route_table_association" "a" {
  vpc_id         = aws_vpc.main.id
  route_table_id = aws_route_table.example.id
}