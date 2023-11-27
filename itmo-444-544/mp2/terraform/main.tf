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
/*
data "aws_subnet" "example" {
  for_each = toset(data.aws_subnets.subnets.ids)
  id       = each.value
}
*/
output "subnetid-2a" {
  value = [data.aws_subnets.subneta.ids]
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
  subnets            = [data.aws_subnets.subneta.ids[0],data.aws_subnets.subnetb.ids[0]]

  enable_deletion_protection = false

  tags = {
    Environment = "production"
  }
}

##############################################################################
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group
##############################################################################

resource "aws_lb_target_group" "alb-lb-tg" {
  name        = var.tg-name
  target_type = "alb"
  port        = 80
  protocol    = "TCP"
  vpc_id      = aws_vpc.main.id
}

##############################################################################
# https://registry.terraform.io/providers/hashicorp/aws/5.26.0/docs/resources/lb_listener
##############################################################################

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.alb.arn
  port              = "80"
  protocol          = "HTTP"
  #ssl_policy        = "ELBSecurityPolicy-2016-08"
  #certificate_arn   = "arn:aws:iam::187416307283:server-certificate/test_cert_rab3wuqwgja25ct3n4jdj2tzu4"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb-lb-tg.arn
  }
}

