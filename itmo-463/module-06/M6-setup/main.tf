# Generate random password -- this way its never hardcoded into our variables and inserted directly as a secretcheck 
# No one will know what it is!
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/secretsmanager_random_password
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
}

resource "aws_secretsmanager_secret" "project_password" {
  name = "pword"
  # https://github.com/hashicorp/terraform-provider-aws/issues/4467
  # This will automatically delete the secret upon Terraform destroy 
  recovery_window_in_days = 0
}

# Provides a resource to manage AWS Secrets Manager secret version including its secret value.
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret_version
# Used to set the value
resource "aws_secretsmanager_secret_version" "project_username" {
  #depends_on = [ aws_secretsmanager_secret_version.project_username ]
  secret_id     = aws_secretsmanager_secret.project_username.id
  secret_string = var.username
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
# Data Block to filter and retrieve our custom VPC ID for use in looking up
# custom subnet IDs to pass to the db subnet group create function
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc
data "aws_vpc" "selected" {
  filter {
    name   = "tag:Name"
    values = [var.tag-name]
  }
}
##############################################################################
# Data block to retrieve our custom subnet IDs
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnet
##############################################################################
data "aws_subnets" "project" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.selected.id]
  }
}

data "aws_subnet" "example" {
  for_each = toset(data.aws_subnets.project.ids)
  id       = each.value
}

output "subnet_cidr_blocks" {
  value = [for s in data.aws_subnet.example : s.id]
}

##############################################################################
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_subnet_group
resource "aws_db_subnet_group" "project" {
  name       = "db_subnet_group"
  #subnet_ids = [aws_subnet.frontend.id, aws_subnet.backend.id]
  subnet_ids = [for s in data.aws_subnet.example : s.id]
  
  tags = {
    Name = var.tag-name
  }
}

###############################################################################
# Block to create AWS EC2 instance
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance
##############################################################################
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

#############################################################################
# From Co-pilot how to get a single random Subnet ID
#############################################################################
resource "random_integer" "pick" {
  min = 0
  max = length(data.aws_subnets.project.ids) - 1
}

output "random_subnet_id" {
  value = element(data.aws_subnets.selected.ids, random_integer.pick.result)
}


##############################################################################
# Temporary EC2 instance that will be used to run the create.sql program and 
# then discarded
##############################################################################
resource "aws_instance" "db_setup" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance-type
  key_name = var.key-name
  #vpc_security_group_ids = [aws_security_group.allow_module_04.id]
  subnet_id = element(data.aws_subnets.selected.ids, random_integer.pick.result)

  tags = {
    Name = var.temp-tag
  }
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_instance
resource "aws_db_instance" "default" {
  depends_on = [ aws_secretsmanager_secret_version.project_password, aws_secretsmanager_secret_version.project_username ]
  allocated_storage    = 10
  db_name              = var.dbname
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t3.micro"
  db_subnet_group_name = aws_db_subnet_group.project.name
  # Retrieve secrets value set in secret manager
  username             = data.aws_secretsmanager_secret_version.project_username.secret_string
  password             = data.aws_secretsmanager_secret_version.project_password.secret_string
  parameter_group_name = "default.mysql8.0"
  skip_final_snapshot  = true
  #vpc_security_group_ids = aws_security_group
  
  tags = {
    Name = var.tag-name
  }
} 

output "db-address" {
  description = "Endpoint URL "
  value = aws_db_instance.default.address
}

output "db-name" {
  description = "DB Name "
  value = aws_db_instance.default.db_name
}
