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
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones
##############################################################################

data "aws_availability_zones" "available" {
  state = "available"
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
# Create a Launch Template
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/launch_template
resource "aws_launch_template" "lt" {
  name = "lt-project"
  image_id = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  placement {
    availability_zone = "us-east-2a"
  }
  user_data= filebase64("./install-env.sh")
  vpc_security_group_ids = [aws_security_group.project.id]
  key_name = data.aws_key_pair.key_pair.key_name
  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = var.item_tag
    }
  }
}
##############################################################################
# Create Auto Scaling Group
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_group
##############################################################################
resource "aws_autoscaling_group" "as" {
  vpc_zone_identifier = [aws_subnet.us-east-2a.id, aws_subnet.us-east-2b.id,aws_subnet.us-east-2c.id]
  desired_capacity   = 3
  max_size           = 5
  min_size           = 2
  health_check_grace_period = 300
  health_check_type         = "ELB"

  launch_template {
    id      = aws_launch_template.lt.id
    version = "$Latest"
  }
  tag {
    key                 = "Name"
    value               = var.item_tag
    propagate_at_launch = true
  }

}
##############################################################################
# Attach an elastic-load-balancer to an auto-scaling group 
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_attachment
##############################################################################
# Create a new ALB Target Group attachment
resource "aws_autoscaling_attachment" "example" {
  autoscaling_group_name = aws_autoscaling_group.as.id
  lb_target_group_arn    = aws_lb_target_group.test.arn
}

##############################################################################
# Create an Elastic Load Balancer
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb
##############################################################################
resource "aws_lb" "test" {
  name               = "test-lb-tf"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.project.id]
  subnets            = [aws_subnet.us-east-2a.id, aws_subnet.us-east-2b.id,aws_subnet.us-east-2c.id]

  tags = {
    Name = var.item_tag
  }
}
#################################################################################
# Retrieve data about ELB
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/lb
#################################################################################
data "aws_lb" "test" {
  arn  = aws_lb.test.arn
  name = aws_lb.test.name
}

output "elb_dns" {
  value = data.aws_lb.test.dns_name
  description = "The DNS name of the ELB."
}

# Create ELB listener

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.test.arn
  port              = 80
  protocol          = "HTTP"
 
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.test.arn
  }
}
##############################################################################
# Create Target group
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group
##############################################################################
resource "aws_lb_target_group" "test" {
  name     = "tf-example-lb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id
}

##############################################################################
# Create Security Group and create rules for port 3306
#
##############################################################################
resource "aws_security_group" "db_allow" {
  name        = "allow_db_connection"
  description = "Allow Port 3306 on all outbound traffic"
  vpc_id      = aws_vpc.main.id

  tags = {
    Name = var.item_tag
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_db_ipv4" {
  security_group_id = aws_security_group.db_allow.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 3306
  ip_protocol       = "tcp"
  to_port           = 3306
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4_db" {
  security_group_id = aws_security_group.db_allow.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}
##############################################################################
# Create Security Group and create rules for port 80 and 22 access
#
##############################################################################
resource "aws_security_group" "project" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.main.id

  tags = {
    Name = var.item_tag
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh_ipv4" {
  security_group_id = aws_security_group.project.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_ingress_rule" "allow_http_ipv4" {
  security_group_id = aws_security_group.project.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.project.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}


##############################################################################
# Link to aws_vpc
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc
##############################################################################

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames = true

  tags = {
    Name = var.item_tag
  }
}
##############################################################################
# Create an AWS subnet
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet
##############################################################################

resource "aws_subnet" "us-east-2a" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.0.0/24"
  availability_zone = "us-east-2a"
  map_public_ip_on_launch = true

  tags = {
    Name = var.item_tag
  }
}

resource "aws_subnet" "us-east-2b" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.16.0/24"
  availability_zone = "us-east-2b"
  map_public_ip_on_launch = true

  tags = {
    Name = var.item_tag
  }
}

resource "aws_subnet" "us-east-2c" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.32.0/24"
  availability_zone = "us-east-2c"
  map_public_ip_on_launch = true

  tags = {
    Name = var.item_tag
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = var.item_tag
  }
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table
resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  route {
    cidr_block        = aws_vpc.main.cidr_block
    gateway_id = "local"
  }

  tags = {
    Name = var.item_tag
  }
} 
# link to route association
##############################################################################
# Main Route Table association
# Explanation of what a main route table is (hint important)
# https://docs.aws.amazon.com/vpc/latest/userguide/RouteTables.html
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/main_route_table_association
##############################################################################
resource "aws_main_route_table_association" "a" {
  vpc_id         = aws_vpc.main.id
  route_table_id = aws_route_table.rt.id
}

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.us-east-2a.id
  route_table_id = aws_route_table.rt.id
}

resource "aws_route_table_association" "b" {
  subnet_id      = aws_subnet.us-east-2b.id
  route_table_id = aws_route_table.rt.id
}

resource "aws_route_table_association" "c" {
  subnet_id      = aws_subnet.us-east-2c.id
  route_table_id = aws_route_table.rt.id
}

##############################################################################
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_subnet_group
##############################################################################
resource "aws_db_subnet_group" "project" {
  name       = "main"
  subnet_ids = [aws_subnet.us-east-2a.id,aws_subnet.us-east-2b.id,aws_subnet.us-east-2c.id]

  tags = {
    Name = var.item_tag
  }
}

##############################################################################
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_instance
##############################################################################

resource "aws_db_instance" "default" {
  depends_on = [ aws_secretsmanager_secret_version.itmo_project_password, aws_secretsmanager_secret_version.itmo_project_username ]
  instance_class       = "db.t3.micro"
  username             = data.aws_secretsmanager_secret_version.project_username.secret_string
  password             = data.aws_secretsmanager_secret_version.project_password.secret_string
  snapshot_identifier = var.snapshot_identifier
  skip_final_snapshot  = true
  db_subnet_group_name = aws_db_subnet_group.project.name
  vpc_security_group_ids = [aws_security_group.db_allow.id]
}

# Generate random password -- this way its never hardcoded into our variables and inserted directly as a secretcheck 
# No one will know what it is!
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/secretsmanager_random_password
data "aws_secretsmanager_random_password" "itmo_project" {
  password_length = 30
  exclude_numbers = true
  exclude_punctuation = true
}

# Create the actual secret (not adding a value yet)
# Provides a resource to manage AWS Secrets Manager secret metadata. To manage
# secret rotation, see the aws_secretsmanager_secret_rotation resource. To 
# manage a secret value, see the aws_secretsmanager_secret_version resource.
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret
resource "aws_secretsmanager_secret" "itmo_project_username" {
  name = "uname"
  # https://github.com/hashicorp/terraform-provider-aws/issues/4467
  # This will automatically delete the secret upon Terraform destroy 
  recovery_window_in_days = 0
  tags = {
    Name = var.item_tag
  }
}

resource "aws_secretsmanager_secret" "itmo_project_password" {
  name = "pword"
  # https://github.com/hashicorp/terraform-provider-aws/issues/4467
  # This will automatically delete the secret upon Terraform destroy 
  recovery_window_in_days = 0
  tags = {
    Name = var.item_tag
  }
}

# Provides a resource to manage AWS Secrets Manager secret version including its secret value.
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret_version
# Used to set the value
resource "aws_secretsmanager_secret_version" "itmo_project_username" {
  #depends_on = [ aws_secretsmanager_secret_version.project_username ]
  secret_id     = aws_secretsmanager_secret.itmo_project_username.id
  secret_string = data.aws_secretsmanager_random_password.itmo_project.random_password
}

resource "aws_secretsmanager_secret_version" "itmo_project_password" {
  #depends_on = [ aws_secretsmanager_secret_version.project_password ]
  secret_id     = aws_secretsmanager_secret.itmo_project_password.id
  secret_string = data.aws_secretsmanager_random_password.itmo_project.random_password
}

# Retrieve secrets value set in secret manager
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/secretsmanager_secret_version
# https://github.com/hashicorp/terraform-provider-aws/issues/14322
data "aws_secretsmanager_secret_version" "project_username" {
  depends_on = [ aws_secretsmanager_secret_version.itmo_project_username ]
  secret_id = aws_secretsmanager_secret.itmo_project_username.id
}

data "aws_secretsmanager_secret_version" "project_password" {
  depends_on = [ aws_secretsmanager_secret_version.itmo_project_password ]
  secret_id = aws_secretsmanager_secret.itmo_project_password.id
}