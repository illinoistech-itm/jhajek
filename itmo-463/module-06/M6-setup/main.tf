# Create an EC2 instance to execute the SQL commands on
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance
resource "aws_instance" "helloworld" {
  ami                    = var.imageid
  instance_type          = var.instance-type
  key_name               = var.key-name
  vpc_security_group_ids = [var.vpc_security_group_ids]
  user_data              = filebase64("./install-env.sh")

  tags = {
    Name = var.tag-name
  }
}

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

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_instance
resource "aws_db_instance" "default" {
  depends_on = [ aws_secretsmanager_secret_version.project_password, aws_secretsmanager_secret_version.project_username ]
  allocated_storage    = 10
  db_name              = var.dbname
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t3.micro"
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
