#!/bin/bash

######################################################################
# Since all elements have been created no need to send any inputs 
# use the --query to get all of the needed IDs and reverse everything
# you did in the create-env.sh 
# you may need to use WAIT in some steps
######################################################################

# Use aws rds describe-db-instances and a query to select the database instance IDs

# You can speed up your RDS termination by requesting RDS to skip taking a final snapshot of data upon delete for a database.
# https://awscli.amazonaws.com/v2/documentation/api/latest/reference/rds/delete-db-instance.html 
# delete-db-instance for both database and read-replica `--skip-final-snapshot`

# https://awscli.amazonaws.com/v2/documentation/api/latest/reference/rds/wait/db-instance-deleted.html
# Wait command for database instance to be deleted

# Describe Load-balancer ARN, and Target Group ARN use query to assign values to SHELL variables

# https://awscli.amazonaws.com/v2/documentation/api/latest/reference/autoscaling/detach-load-balancer-target-groups.html
# To remove instances from the Auto Scaling group before deleting it, call the DetachInstances API with the list of 
# instances and the option to decrement the desired capacity. This ensures that Amazon EC2 Auto Scaling does not launch
# replacement instances.
# detach-load-balancer-target-groups

# Delete Auto Scaling Group
# https://awscli.amazonaws.com/v2/documentation/api/latest/reference/autoscaling/delete-auto-scaling-group.html

# Delete Launch Configuration
# https://awscli.amazonaws.com/v2/documentation/api/latest/reference/autoscaling/delete-launch-configuration.html

# Deregister instances from target group
# https://awscli.amazonaws.com/v2/documentation/api/latest/reference/elbv2/deregister-targets.html

# Delete target group
# https://awscli.amazonaws.com/v2/documentation/api/latest/reference/elbv2/delete-target-group.html

# Delete EC2 instances
# Resuse code from week-06

# Delete load-balancer
# Resuse code from week-06

# Delete load-balancer listener
# Resuse code from week-06
