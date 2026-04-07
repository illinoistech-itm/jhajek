# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance

data "aws_instance" "ubuntu" {
  filter {
    name = "tag:Name"
    values = [var.item_tag_template]
  }
}


resource "aws_ami_from_instance" "custom_ami" {
  name               = "project"
  source_instance_id = data.aws_instance.ubuntu.id
  snapshot_without_reboot = false

  tags = {
    Name = var.item_tag_template,
    Type = "CustomAMI"
  }
}
