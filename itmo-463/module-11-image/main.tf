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
  #vpc_security_group_ids = [aws_security_group.project.id]
  #subnet_id = aws_subnet.us-east-2a.id
  user_data_base64 = filebase64("./install-env.sh")
  #key_name = data.aws_key_pair.key_pair.key_name

  tags = {
    Name = var.item_tag
  }
}
