# Terraform for MP2

##############################################################################
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpcs
##############################################################################

data "aws_vpc" "main" {
  default = true
}

output "vpcs" {
  value = data.aws_vpc.main.id
}
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
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones
##############################################################################
data "aws_availability_zones" "primary" {
  filter {
    name   = "zone-name"
    values = ["us-east-2a"]
  }
}

data "aws_availability_zones" "secondary" {
  filter {
    name   = "zone-name"
    values = ["us-east-2b"]
  }
}

##############################################################################
# https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/shuffle#example-usage
##############################################################################

resource "random_shuffle" "az" {
  input        = [data.aws_availability_zones.available.names[0], data.aws_availability_zones.available.names[1], data.aws_availability_zones.available.names[2]]
  result_count = 2
}

##############################################################################
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnets
##############################################################################
# The data value is essentially a query and or a filter to retrieve values
data "aws_subnets" "subneta" {
  filter {
    name   = "availabilityZone"
    values = ["us-east-2a"]
  }
}

data "aws_subnets" "subnetb" {
  filter {
    name   = "availabilityZone"
    values = ["us-east-2b"]
  }
}

data "aws_subnets" "subnetc" {
  filter {
    name   = "availabilityZone"
    values = ["us-east-2c"]
  }
}

output "subnetid-2a" {
  value = [data.aws_subnets.subneta.ids]
}

##############################################################################
# https://registry.terraform.io/providers/hashicorp/aws/5.26.0/docs/resources/lb
##############################################################################
resource "aws_lb" "lb" {
  name               = var.elb-name
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.vpc_security_group_ids]

  subnets = [data.aws_subnets.subneta.ids[0], data.aws_subnets.subnetb.ids[0]]

  enable_deletion_protection = false

  tags = {
    Environment = "production"
  }
}

# output will print a value out to the screen
output "url" {
  value = aws_lb.lb.dns_name
}

##############################################################################
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group
##############################################################################

resource "aws_lb_target_group" "alb-lb-tg" {
  # depends_on is effectively a waiter -- it forces this resource to wait until the listed
  # resource is ready
  depends_on  = [aws_lb.lb]
  name        = var.tg-name
  target_type = "instance"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = data.aws_vpc.main.id
}

##############################################################################
# https://registry.terraform.io/providers/hashicorp/aws/5.26.0/docs/resources/lb_listener
##############################################################################

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.lb.arn
  port              = "80"
  protocol          = "HTTP"
  #ssl_policy        = "ELBSecurityPolicy-2016-08"
  #certificate_arn   = "arn:aws:iam::187416307283:server-certificate/test_cert_rab3wuqwgja25ct3n4jdj2tzu4"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb-lb-tg.arn
  }
}

##############################################################################
# Create launch template
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/launch_template
##############################################################################
resource "aws_launch_template" "mp1-lt" {
  #name_prefix = "foo"
  #name = var.lt-name
  iam_instance_profile {
    name = var.iam-profile
  }
  image_id                             = var.imageid
  instance_initiated_shutdown_behavior = "terminate"
  instance_type                        = var.instance-type
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

resource "aws_autoscaling_group" "bar" {
  name                      = var.asg-name
  depends_on                = [aws_launch_template.mp1-lt]
  desired_capacity          = var.desired
  max_size                  = var.max
  min_size                  = var.min
  health_check_grace_period = 300
  health_check_type         = "EC2"
  target_group_arns         = [aws_lb_target_group.alb-lb-tg.arn]
  availability_zones        = [data.aws_availability_zones.primary.names[0], data.aws_availability_zones.secondary.names[0]]

  launch_template {
    id      = aws_launch_template.mp1-lt.id
    version = "$Latest"
  }
}

##############################################################################
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_attachment
##############################################################################
# Create a new ALB Target Group attachment

resource "aws_autoscaling_attachment" "example" {
  # Wait for lb to be running before attaching to asg
  depends_on  = [aws_lb.lb]
  autoscaling_group_name = aws_autoscaling_group.bar.id
  lb_target_group_arn    = aws_lb_target_group.alb-lb-tg.arn
}

output "alb-lb-tg-arn" {
  value = aws_lb_target_group.alb-lb-tg.arn
}

output "alb-lb-tg-id" {
  value = aws_lb_target_group.alb-lb-tg.id
}
