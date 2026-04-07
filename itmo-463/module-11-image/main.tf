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


resource "aws_instance" "example" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  #vpc_security_group_ids = [aws_security_group.project.id]
  #subnet_id = aws_subnet.us-east-2a.id
  user_data_base64 = filebase64("./install-env.sh")
  #key_name = data.aws_key_pair.key_pair.key_name

  tags = {
    Name = var.item_tag
  }
}

resource "aws_ami_from_instance" "custom_ami" {
  name               = "project"
  source_instance_id = aws_instance.example.id
  snapshot_without_reboot = false

  tags = {
    Name = var.item_tag,
    Type = "CustomAMI"
  }
}