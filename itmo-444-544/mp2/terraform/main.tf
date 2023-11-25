# Terraform for MP2

##############################################################################
# https://developer.hashicorp.com/terraform/tutorials/configuration-language/data-source
##############################################################################
data "aws_availability_zones" "available" {
  state = "available"

  filter {
    name   = "zone-type"
    values = ["availability-zone"]
  }
}

##############################################################################
# https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/shuffle#example-usage
##############################################################################

resource "random_shuffle" "az" {
  input        = [for z in data.aws_availability_zones.available.names : z.names]
  result_count = 2
}

##############################################################################
# https://stackoverflow.com/questions/69498813/how-to-filter-aws-subnets-in-terraform
##############################################################################
/*
data "aws_vpc" "selected" {
  default = true
  id = var.vpc_id
}
*/
##############################################################################
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnets
##############################################################################
data "aws_subnets" "subnets" {
  filter {
    name   = "vpc-id"
    values = ["vpc-id"]
  }

}

data "aws_subnet" "example" {
  for_each = toset(data.aws_subnets.subnets.ids)
  id       = each.value
}

output "subnet_cidr_blocks" {
  value = [for s in data.aws_subnet.example : s.cidr_block]
}

##############################################################################
# https://registry.terraform.io/providers/hashicorp/aws/5.26.0/docs/resources/lb
##############################################################################
resource "aws_lb" "test" {
  name               = var.elb-name
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.vpc_security_group_ids]
  for_each           = toset(data.aws_subnets.subnets.ids)
  subnets            = [each.value]

  enable_deletion_protection = true

  tags = {
    Environment = "production"
  }
}

##############################################################################
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group
##############################################################################
resource "aws_lb_target_group" "test" {
  name     = var.asg-name
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id
}

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
}


##############################################################################
# Create launch template
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/launch_template
##############################################################################
resource "aws_launch_template" "foo" {
  name_prefix = "foo"
  #name = var.lt-name

  disable_api_stop        = true
  disable_api_termination = true

  ebs_optimized = true

  iam_instance_profile {
    name = var.iam-profile
  }

  image_id = var.imageid

  instance_initiated_shutdown_behavior = "terminate"

  instance_type = var.instance-type

  monitoring {
    enabled = false
  }

#  network_interfaces {
#    associate_public_ip_address = true
#    security_groups = [var.vpc_security_group_ids]
#  }

  placement {
    availability_zone = random_shuffle.az.result[0]
  }

  vpc_security_group_ids = [var.vpc_security_group_ids]

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "mp1-project"
    }
  }

  user_data = filebase64("./install-env.sh")
}

##############################################################################
# Create autoscaling group
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_group
##############################################################################
resource "aws_autoscaling_group" "bar" {
  name = var.asg-name
  availability_zones = [random_shuffle.az.result[0],random_shuffle.az.result[1]]
  desired_capacity   = var.desired
  max_size           = var.max
  min_size           = var.min
  health_check_grace_period = 300
  health_check_type         = "ELB"

  launch_template {
    id      = aws_launch_template.foo.id
    version = "$Latest"
  }
}