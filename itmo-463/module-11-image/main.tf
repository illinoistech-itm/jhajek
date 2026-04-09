##############################################################################
# Data block to retrieve AMI
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance
##############################################################################

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

resource "aws_instance" "example" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  vpc_security_group_ids = [aws_security_group.project.id]
  #subnet_id = aws_subnet.us-east-2a.id
  #user_data_base64 = filebase64("./install-env.sh")
  key_name = data.aws_key_pair.key_pair.key_name

  tags = {
    Name = var.item_tag_template
  }
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


##############################################################################
# Create Security Group and create rules for port 22 and 3306 access
#
##############################################################################

resource "aws_security_group" "project" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic and all outbound traffic"

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

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.project.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

resource "aws_vpc_security_group_ingress_rule" "allow_db_ipv4" {
  security_group_id = aws_security_group.project.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 3306
  ip_protocol       = "tcp"
  to_port           = 3306
}

# Get code from module-11 on launching an RDS instance
##############################################################################
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_instance
##############################################################################

resource "aws_db_instance" "default" {
  depends_on = [ aws_secretsmanager_secret_version.itmo_project_password, aws_secretsmanager_secret_version.itmo_project_username ]
  allocated_storage    = 10
  db_name              = "mydb"
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t3.micro"
  username             = data.aws_secretsmanager_secret_version.project_username.secret_string
  password             = data.aws_secretsmanager_secret_version.project_password.secret_string
  parameter_group_name = "default.mysql8.0"
  skip_final_snapshot  = true
  # db_subnet_group_name = aws_db_subnet_group.project.name
  vpc_security_group_ids = [aws_security_group.project.id]
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