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

resource "aws_internet_gateway_attachment" "example" {
  internet_gateway_id = aws_internet_gateway.gw.id
  vpc_id              = aws_vpc.main.id
}