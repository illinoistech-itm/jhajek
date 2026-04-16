# We need two blocks

# 1 data block to retrieve our RDS instance ID
##############################################################################
#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/db_instance
##############################################################################

data "aws_db_instance" "database" {
  tags = {
    Name = var.item_tag_template
  }

}

output "aws_db_instance_output" {
  value = data.aws_db_instance.database.db_name
  description = "db_name output"
}
##############################################################################
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_snapshot
##############################################################################

# 1 resource block to create a DB snapshot - with tag of that RDS instance
resource "aws_db_snapshot" "snap" {
  db_instance_identifier = data.aws_db_instance.database.db_instance_identifier
  db_snapshot_identifier = "testsnapshot1"
tags = {
    Name = var.item_tag
  }
}