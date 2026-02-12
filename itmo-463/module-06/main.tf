# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "example" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type

  tags = {
    Name = var.item_tag
  }
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