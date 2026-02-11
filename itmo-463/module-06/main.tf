# main.tf is the main declarative logic file
# this is where we tell AWS what we want
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones

##############################################################################
# Block of code to create Virtual Private Cloud VPC for all out networking 
# needs
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc
##############################################################################


##############################################################################
# Block to create an Internet Gateway
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway
##############################################################################


# Create VPC DHCP options -- public DNS provided by Amazon
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_dhcp_options



# Associate these options with our VPC now
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_dhcp_options_association


# Now we need to create the route_table to subnets
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table

# Now we need to create the route_table to subnets
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association


# Now associated the route table
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/main_route_table_association


##############################################################################
# Block to create a subnet for our VPC
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet
##############################################################################


##############################################################################
# Block to create a data variable that is a list of all subnets tagged with module-06
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnets
##############################################################################


# Link to get all subnet ids dynamically
# Assign the values to a data object
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnets#example-usage


##############################################################################
# Block to create an AWS Security Group (firewall for AWS Ec2 instances)
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group
##############################################################################

###############################################################################
# Data block to retrieve the custom security group that we have created for the
# project
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/security_group
###############################################################################


##############################################################################
# Block to create AWS ELB (Elastic Load Balancer)
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb
##############################################################################


##############################################################################
# Block to create AWS ELB Listener
# Listen for traffic on a certain port (443 or 80) and balancer based on that
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener
##############################################################################


##############################################################################
# Create AWS Target Group
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group
##############################################################################


##############################################################################
# Register EC2 instances with a target group and attach them to the LB
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group_attachment
##############################################################################


##############################################################################
# Create autoscaling group
# What is an AutoScaling Group? https://docs.aws.amazon.com/autoscaling/ec2/userguide/auto-scaling-groups.html
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_group
##############################################################################


##############################################################################
# How to attach an AutoScaling group to a target group 
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_attachment
##############################################################################



##############################################################################
# AWS EC2 Launch Template for the ASG to create instances for us...  this helps a lot
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/launch_template
##############################################################################
# Collect the current Ubuntu AMI ID
data "aws_ami" "ubuntu" {
  most_recent = true
  
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_launch_template" "production" {
  name = var.lt-name
  block_device_mappings {
    device_name = "/dev/sdf"
    ebs {
      volume_size = 20
    }
  }
#  iam_instance_profile {
#    name = "test"
#  }
  image_id = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  key_name = var.key-name
  vpc_security_group_ids = [aws_security_group.allow_module_06.id]

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = var.tag
    }
  }
  user_data = filebase64("./install-env.sh")
}

##############################################################################
# Creating the policy (rules) for what the role can do
##############################################################################
data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

##############################################################################
# Creating the role
##############################################################################
resource "aws_iam_role" "role" {
  name               = "project_role"
  path               = "/"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json

  tags = {
    Name = var.tag
  }
}

##############################################################################
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy
##############################################################################
resource "aws_iam_role_policy" "s3_fullaccess_policy" {
  name = "s3_fullaccess_policy"
  role = aws_iam_role.role.id

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "s3:*",
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}
##############################################################################
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy
##############################################################################
resource "aws_iam_role_policy" "rds_fullaccess_policy" {
  name = "rds_fullaccess_policy"
  role = aws_iam_role.role.id

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "rds:*",
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}

resource "aws_iam_role_policy" "sm_fullaccess_policy" {
  name = "sm_fullaccess_policy"
  role = aws_iam_role.role.id

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "secretsmanager:*",
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}
