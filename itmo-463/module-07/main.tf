# main.tf is the main declarative logic file
# this is where we tell AWS what we want
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones

##############################################################################
# Block of code to create Virtual Private Cloud VPC for all out networking 
# needs
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc
##############################################################################
resource "aws_vpc" "main" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"
  enable_dns_hostnames = true

  tags = {
    Name = var.tag
  }
}

##############################################################################
# Block to create an Internet Gateway
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway
##############################################################################

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = var.tag,
    Type = "main"
  }
}

# Create VPC DHCP options -- public DNS provided by Amazon
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_dhcp_options

resource "aws_vpc_dhcp_options" "dns_resolver" {
  domain_name_servers = ["AmazonProvidedDNS"]
}

# Associate these options with our VPC now
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_dhcp_options_association

resource "aws_vpc_dhcp_options_association" "dns_resolver" {
  vpc_id          = aws_vpc.main.id
  dhcp_options_id = aws_vpc_dhcp_options.dns_resolver.id
}

# Now we need to create the route_table to subnets
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table
resource "aws_route_table" "main" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = var.tag
  }
}

# Now we need to create the route_table to subnets
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.subneta.id
  route_table_id = aws_route_table.main.id
}

resource "aws_route_table_association" "b" {
  subnet_id      = aws_subnet.subnetb.id
  route_table_id = aws_route_table.main.id
}

resource "aws_route_table_association" "c" {
  subnet_id      = aws_subnet.subnetc.id
  route_table_id = aws_route_table.main.id
}

# Now associated the route table
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/main_route_table_association

resource "aws_main_route_table_association" "a" {
  vpc_id         = aws_vpc.main.id
  route_table_id = aws_route_table.main.id
}

##############################################################################
# BLock to create a subnet for our VPC
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet
##############################################################################
resource "aws_subnet" "subneta" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"
  availability_zone = var.az[0]
  map_public_ip_on_launch = true

  tags = {
    Name = var.tag
  }
}

resource "aws_subnet" "subnetb" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.2.0/24"
  availability_zone = var.az[1]
  map_public_ip_on_launch = true

  tags = {
    Name = var.tag
  }
}

resource "aws_subnet" "subnetc" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.3.0/24"
  availability_zone = var.az[2]
  map_public_ip_on_launch = true

  tags = {
    Name = var.tag
  }
}

##############################################################################
# Block to create a data variable that is a list of all subnets tagged with module-06
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnets
##############################################################################
data "aws_subnets" "project" {
  filter {
    name   = "tag:Name"
    values = [var.tag]
  }
}

# Link to get all subnet ids dynamically
# Assign the values to a data object
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnets#example-usage
data "aws_subnet" "project" {
  for_each = toset(data.aws_subnets.project.ids)
  id       = each.value
}

output "subnet_ids" {
  value = [for s in data.aws_subnet.project : s.id]
}

##############################################################################
# Block to create an AWS Security Group (firewall for AWS Ec2 instances)
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group
##############################################################################

resource "aws_security_group" "allow_module_07" {
  name        = "allow_module_07"
  description = "Allow HTTP inbound traffic and all outbound traffic for module 03"
  vpc_id      = aws_vpc.main.id

  tags = {
    Name = var.tag
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_http_ipv4" {
  security_group_id = aws_security_group.allow_module_07.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_ingress_rule" "allow_https_ipv4" {
  security_group_id = aws_security_group.allow_module_07.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh_ipv4" {
  security_group_id = aws_security_group.allow_module_07.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.allow_module_07.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

##############################################################################
# Block to create AWS ELB (Elastic Load Balancer)
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb
##############################################################################
resource "aws_lb" "production" {
  depends_on = [ data.aws_subnets.project, data.aws_subnet.project ]
  name               = var.elb-name
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.allow_module_07.id]
  subnets            = [aws_subnet.subneta.id,aws_subnet.subnetb.id,aws_subnet.subnetc.id]
  #subnets            = [for subnet in data.aws_subnet.project : subnet.id]

  tags = {
    Name = var.tag,
    Environment = "production"
  }
}

# output will print a value out to the screen
output "url" {
  value = aws_lb.production.dns_name
}

##############################################################################
# Block to create AWS ELB Listener
# Listen for traffic on a certain port (443 or 80) and balancer based on that
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener
##############################################################################

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.production.arn
  port              = "80"
  protocol          = "HTTP"
  #ssl_policy        = "ELBSecurityPolicy-2016-08"
  #certificate_arn   = "arn:aws:iam::187416307283:server-certificate/test_cert_rab3wuqwgja25ct3n4jdj2tzu4"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.front_end.arn
  }
}

##############################################################################
# Create AWS Target Group
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group
##############################################################################
resource "aws_lb_target_group" "front_end" {
  name     = var.tg-name
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id
}

##############################################################################
# Register EC2 instances with a target group and attach them to the LB
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group_attachment
##############################################################################
#resource "aws_lb_target_group_attachment" "front_end" {
#  target_group_arn = aws_lb_target_group.front_end.arn
#  target_id        = aws_instance.module_07.id
#  port             = 80
#}

##############################################################################
# Create autoscaling group
# What is an AutoScaling Group? https://docs.aws.amazon.com/autoscaling/ec2/userguide/auto-scaling-groups.html
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_group
##############################################################################
resource "aws_autoscaling_group" "production" {
  name                      = var.asg-name
  max_size                  = 5
  min_size                  = 2
  health_check_grace_period = 300
  health_check_type         = "ELB"
  desired_capacity          = 3
  force_delete              = true
  #launch_configuration      = aws_launch_template.production.id
  vpc_zone_identifier       = [aws_subnet.subneta.id,aws_subnet.subnetb.id,aws_subnet.subnetc.id]

  launch_template {
    id      = aws_launch_template.production.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = var.tag
    propagate_at_launch = true
  }
}

##############################################################################
# How to attach an AutoScaling group to a target group 
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_attachment
##############################################################################

# Create a new ALB Target Group attachment
resource "aws_autoscaling_attachment" "production" {
  autoscaling_group_name = aws_autoscaling_group.production.id
  lb_target_group_arn    = aws_lb_target_group.front_end.arn
}

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
  vpc_security_group_ids = [aws_security_group.allow_module_07.id]

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

##############################################################################
# Generate random password -- this way its never hardcoded into our variables 
#and inserted directly as a secretcheck
# No one will know what it is!
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/secretsmanager_random_password
##############################################################################
data "aws_secretsmanager_random_password" "project" {
  password_length = 30
  exclude_numbers = true
  exclude_punctuation = true
}

# Create the actual secret (not adding a value yet)
# Provides a resource to manage AWS Secrets Manager secret metadata. To manage
# secret rotation, see the aws_secretsmanager_secret_rotation resource. To 
# manage a secret value, see the aws_secretsmanager_secret_version resource.
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret
resource "aws_secretsmanager_secret" "project_username" {
  name = "uname"
  # https://github.com/hashicorp/terraform-provider-aws/issues/4467
  # This will automatically delete the secret upon Terraform destroy 
  recovery_window_in_days = 0
  tags = {
    Name = var.tag
  }
}

resource "aws_secretsmanager_secret" "project_password" {
  name = "pword"
  # https://github.com/hashicorp/terraform-provider-aws/issues/4467
  # This will automatically delete the secret upon Terraform destroy 
  recovery_window_in_days = 0
  tags = {
    Name = var.tag
  }
}

# Provides a resource to manage AWS Secrets Manager secret version including its secret value.
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret_version
# Used to set the value
resource "aws_secretsmanager_secret_version" "project_username" {
  #depends_on = [ aws_secretsmanager_secret_version.project_username ]
  secret_id     = aws_secretsmanager_secret.project_username.id
  secret_string = var.username
  #secret_string = data.aws_secretsmanager_random_password.project.random_password
}

resource "aws_secretsmanager_secret_version" "project_password" {
  #depends_on = [ aws_secretsmanager_secret_version.project_password ]
  secret_id     = aws_secretsmanager_secret.project_password.id
  secret_string = data.aws_secretsmanager_random_password.project.random_password
}

# Retrieve secrets value set in secret manager
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/secretsmanager_secret_version
# https://github.com/hashicorp/terraform-provider-aws/issues/14322
data "aws_secretsmanager_secret_version" "project_username" {
  depends_on = [ aws_secretsmanager_secret_version.project_username ]
  secret_id = aws_secretsmanager_secret.project_username.id
}

data "aws_secretsmanager_secret_version" "project_password" {
  depends_on = [ aws_secretsmanager_secret_version.project_password ]
  secret_id = aws_secretsmanager_secret.project_password.id
}

##############################################################################
# Block to create an AWS Security Group (firewall for AWS Ec2 instances)
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group
##############################################################################
# Create a security group for just database access
resource "aws_security_group" "allow_database_access" {
  name        = "allow_db_access"
  description = "Allow inbound traffic and all outbound traffic for to port 3306"
  vpc_id      = aws_vpc.main.id

  tags = {
    #Name = var.tag
    Type = "db"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_db_ipv4" {
  security_group_id = aws_security_group.allow_database_access.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 3306
  ip_protocol       = "tcp"
  to_port           = 3306
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4_db" {
  security_group_id = aws_security_group.allow_database_access.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

##############################################################################
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_subnet_group
resource "aws_db_subnet_group" "project" {
  name       = "db_subnet_group"
  subnet_ids = [for s in data.aws_subnet.project : s.id]
  
  tags = {
    Name = var.tag
  }
}

##############################################################################
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/db_snapshot
# Use the latest production snapshot to create a dev instance.
##############################################################################
resource "aws_db_instance" "default" {
  instance_class      = "db.t3.micro"
  snapshot_identifier = var.snapshot_identifier
  skip_final_snapshot  = true
  username             = data.aws_secretsmanager_secret_version.project_username.secret_string
  password             = data.aws_secretsmanager_secret_version.project_password.secret_string
  vpc_security_group_ids = [aws_security_group.allow_database_access.id]
  db_subnet_group_name  = aws_db_subnet_group.project.ids
}

output "db-address" {
  description = "Endpoint URL "
  value = aws_db_instance.default.address
}

output "db-name" {
  description = "DB Name "
  value = aws_db_instance.default.db_name
}
