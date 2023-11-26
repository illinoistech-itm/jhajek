# Terraform for MP2

##############################################################################
# https://developer.hashicorp.com/terraform/tutorials/configuration-language/data-source
##############################################################################
data "aws_availability_zones" "available" {
  state = "available"
/*
  filter {
    name   = "zone-type"
    values = ["availability-zone"]
  }
*/
}

##############################################################################
# https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/shuffle#example-usage
##############################################################################

resource "random_shuffle" "az" {
  input        = [data.aws_availability_zones.available.names[0],data.aws_availability_zones.available.names[1],data.aws_availability_zones.available.names[2]]
  result_count = 2
}

##############################################################################
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnets
##############################################################################
data "aws_subnets" "subnets" {
  filter {
    name   = "vpc-id"
    values = ["vpc-id"]
  }

}

data "aws_subnet" "az0-subnet0" {
  filter {
    name = "availablity_zones"
    values = "all"
  }
}

data "aws_subnet" "az1-subnet1" {
  filter {
    name = "availablity_zones"
    values = "b"
  }
}

data "aws_subnet" "example" {
  for_each = toset(data.aws_subnets.subnets.ids)
  id       = each.value
}

output "subnet_cidr_blocks" {
  value = [for s in data.aws_subnet.example : s.availability_zone]
}

##############################################################################
# https://registry.terraform.io/providers/hashicorp/aws/5.26.0/docs/resources/lb
##############################################################################
resource "aws_lb" "alb" {
  name               = var.elb-name
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.vpc_security_group_ids]
  #subnets            = [for subnet in data.aws_subnet.example : subnet.id]
  subnets            = [data.aws_subnet.az0-subnet0.subnet.id,data.aws_subnet.az1-subnet1.subnet.id]

  enable_deletion_protection = true

  tags = {
    Environment = "production"
  }
}

##############################################################################
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group
##############################################################################
resource "aws_lb_target_group" "alb" {
  name     = var.tg-name
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
resource "aws_launch_template" "mp1-lt" {
  name_prefix = "foo"
  #name = var.lt-name

  iam_instance_profile {
    name = var.iam-profile
  }

  image_id = var.imageid

  instance_initiated_shutdown_behavior = "terminate"

  instance_type = var.instance-type

  monitoring {
    enabled = false
  }

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
/* 
resource "aws_autoscaling_group" "bar" {
  name = var.asg-name
  availability_zones = [random_shuffle.az.result[0],random_shuffle.az.result[1]]
  desired_capacity   = var.desired
  max_size           = var.max
  min_size           = var.min
  health_check_grace_period = 300
  health_check_type         = "ELB"
  #target_group_arns         = data.aws_lb_target_group.alb.arn

  launch_template {
    id      = aws_launch_template.foo.id
    version = "$Latest"
  }
}
*/ 
##############################################################################
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_attachment
##############################################################################
# Create a new ALB Target Group attachment
/* 
resource "aws_autoscaling_attachment" "example" {
  autoscaling_group_name = aws_autoscaling_group.bar.id
  lb_target_group_arn    = aws_lb_target_group.alb.arn
} 
*/


resource "aws_autoscaling_group" "mp1" {
  name                      = var.asg-name
  # We want this to explicitly depend on the launch config above
  depends_on = [aws_launch_template.mp1-lt]
  availability_zones = [random_shuffle.az.result[0],random_shuffle.az.result[1]]
  health_check_grace_period = 60
  health_check_type         = "ELB"
  desired_capacity   = var.desired
  max_size           = var.max
  min_size           = var.min

  launch_template {
    id      = aws_launch_template.mp1-lt.id
    version = "$Latest"
  }

  #vpc_zone_identifier       = [random_shuffle.az.result[0],random_shuffle.az.result[1]]
}

resource "aws_autoscaling_attachment" "asg_attachment_elb" {
  autoscaling_group_name = aws_autoscaling_group.mp1.name
  lb_target_group_arn = aws_lb_target_group.alb.arn
}

##############################################################################
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group_attachment
##############################################################################

resource "aws_lb_target_group_attachment" "mp1-alb-to-tg" {
  target_group_arn = aws_lb_target_group.alb.arn
  target_id        = aws_lb.alb.arn
  
}