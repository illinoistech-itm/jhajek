# We need two blocks

# 1 data block to retrieve our RDS instance ID
##############################################################################
#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/db_instance
##############################################################################

data "aws_db_instance" "database" {
  tags = [var.item_tag_template]

}

# 1 resource block to create a DB snapshot - with tag of that RDS instance
resource "aws_db_snapshot" "" {
  db_instance_identifier = data.aws_db_instance.database.db_instance_identifier
  db_snapshot_identifier = "testsnapshot1"
tags = {
    Name = var.item_tag
  }
}