# Terraform for Final Summative Assesment
##############################################################################
# You will need to fill in the blanks
# This assessment combines Module 5, 6, and 7 requriements into one Terraform script
#
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
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb
##############################################################################
resource "aws_lb" "lb" {
  name               = 
  internal           = false
  load_balancer_type = 
  security_groups    = 

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
  name        = 
  target_type = 
  port        = 
  protocol    = 
  vpc_id      = 
}

##############################################################################
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener
##############################################################################

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = 
  port              = 
  protocol          = 

  default_action {
    type             = "forward"
    target_group_arn = 
  }
}

##############################################################################
# Create launch template
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/launch_template
##############################################################################
resource "aws_launch_template" "mp1-lt" {
  #name_prefix = "foo"
  #name = var.lt-name
  image_id                             = 
  instance_initiated_shutdown_behavior = "terminate"
  instance_type                        = 
  key_name                             = 
  monitoring {
    enabled = false
  }
  placement {
    availability_zone = data.aws_availability_zones.primary.id
  }

# Add first device_block_mapping /dev/sdc here of ebs.size
  block_device_mappings {
    
  }

# Add second device_block_mapping /dev/sdd here of ebs.size
  block_device_mappings {
 
 
   }

  vpc_security_group_ids = [var.vpc_security_group_ids]
  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = var.module-tag
    }
  }
  user_data = filebase64("./install-env.sh")
}

##############################################################################
# Create autoscaling group
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_group
##############################################################################

resource "aws_autoscaling_group" "bar" {
  name                      = 
  depends_on                = [aws_launch_template.mp1-lt]
  desired_capacity          = 
  max_size                  = 
  min_size                  = 
  health_check_grace_period = 300
  health_check_type         = 
  target_group_arns         = 
  availability_zones        = [data.aws_availability_zones.primary.names[0], data.aws_availability_zones.secondary.names[0]]

 tag {
    key                 = "assessment"
    value               = 
    propagate_at_launch = true
  }

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
  autoscaling_group_name = 
  lb_target_group_arn    = 
}

output "alb-lb-tg-arn" {
  value = aws_lb_target_group.alb-lb-tg.arn
}

output "alb-lb-tg-id" {
  value = aws_lb_target_group.alb-lb-tg.id
}

##############################################################################
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dynamodb_table
##############################################################################

resource "aws_dynamodb_table" "mp2-dynamodb-table" {
  name           = 
  billing_mode   = "PROVISIONED"
  read_capacity  = 20
  write_capacity = 20
  hash_key       = "Email"
  range_key      = "RecordNumber"

  # This will be the UUID and how we uniquely identify records
  attribute {
    name = "RecordNumber"
    type = "S"
  }

  attribute {
    name = "Email"
    type = "S"
  }

  tags = {
    Name        = 
  }
}

##############################################################################
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dynamodb_table_item
##############################################################################

resource "aws_dynamodb_table_item" "insert-sample-record" {
  depends_on = [aws_dynamodb_table.mp2-dynamodb-table]
  table_name = 
  hash_key   = aws_dynamodb_table.mp2-dynamodb-table.hash_key
  range_key  = aws_dynamodb_table.mp2-dynamodb-table.range_key

  item = <<ITEM
{
  "Email": {"S": "hajek@iit.edu"},
  "RecordNumber": {"S": "9e8091b0-8d53-11ee-95e6-035fc6c6cfb4"},
  "CustomerName": {"S": "Jeremy Hajek"},
  "Phone": {"S": "6306389708"},
  "Stat": {"N": "0"},
  "RAWS3URL": {"S": ""},
  "FINSIHEDS3URL": {"S": ""}
}
ITEM
}

##############################################################################
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_policy
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket
# https://stackoverflow.com/questions/65984400/how-to-delete-non-empty-s3-bucket-with-terraform
##############################################################################

resource "aws_s3_bucket" "raw-bucket" {
  bucket = 
  force_destroy = true
}

resource "aws_s3_bucket" "finished-bucket" {
  bucket = 
  force_destroy = true
}
