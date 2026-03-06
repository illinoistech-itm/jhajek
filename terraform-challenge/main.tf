resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
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

resource "aws_route_table" "example" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = aws_vpc.main.cidr_block
    gateway_id = aws_internet_gateway.gw.id
  }


  tags = {
    Name = var.item_tag
  }
}
