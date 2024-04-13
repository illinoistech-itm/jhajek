#!/bin/bash
# Use aws rds describe-db-instances and a query to select the database instance IDs

DATAINSTANCE=$(aws rds describe-db-instances --output=json | jq -r '.DBInstances[0].DBInstanceIdentifier')

# You can speed up your RDS termination by requesting RDS to skip taking a final snapshot of data upon delete for a database.
# https://awscli.amazonaws.com/v2/documentation/api/latest/reference/rds/delete-db-instance.html
# delete-db-instance for both database and read-replica `--skip-final-snapshot`

aws rds delete-db-instance --db-instance-identifier $DATAINSTANCE --skip-final-snapshot

echo "------------------------------------------"
echo "Deleted DB instance, skipped the final snapshot"
echo "------------------------------------------"

# https://awscli.amazonaws.com/v2/documentation/api/latest/reference/rds/wait/db-instance-deleted.html
# Wait command for database instance to be deleted

aws rds wait db-instance-deleted --db-instance-identifier $DATAINSTANCE

# Describe Load-balancer ARN, and Target Group ARN use query to assign values to SHELL variables

TARGETARN=$(aws elbv2 describe-target-groups --output=json | jq -r '.TargetGroups[].TargetGroupArn')
LOADARN=$(aws elbv2 describe-load-balancers --output=json | jq -r '.LoadBalancers[0].LoadBalancerArn')
ASGNAME=$(aws autoscaling describe-auto-scaling-groups --output=json | jq -r '.AutoScalingGroups[0].AutoScalingGroupName')

# https://awscli.amazonaws.com/v2/documentation/api/latest/reference/autoscaling/detach-load-balancer-target-groups.html
# To remove instances from the Auto Scaling group before deleting it, call the DetachInstances API with the list of
# instances and the option to decrement the desired capacity. This ensures that Amazon EC2 Auto Scaling does not launch
# replacement instances.
# detach-load-balancer-target-groups

aws autoscaling detach-load-balancer-target-groups --auto-scaling-group-name $ASGNAME --target-group-arns $TARGETARN

echo "------------------------------------------"
echo "Removed instances from auto scaling group. Replacement instances halted."
echo "------------------------------------------"

# Delete Auto Scaling Group
# https://awscli.amazonaws.com/v2/documentation/api/latest/reference/autoscaling/delete-auto-scaling-group.html

aws autoscaling update-auto-scaling-group --auto-scaling-group-name $ASGNAME --min-size 0 --desired-capacity 0

echo "------------------------------------------"
echo "Deleted auto scaling group"
echo "------------------------------------------"

# Delete Launch Configuration
# https://awscli.amazonaws.com/v2/documentation/api/latest/reference/autoscaling/delete-launch-configuration.html

LAUNCHTEMP=$(aws ec2 describe-launch-templates --output=json | jq -r '.LaunchTemplates[0].LaunchTemplateName')
aws ec2 delete-launch-template --launch-template-name $LAUNCHTEMP

echo "------------------------------------------"
echo "Deleted launch template"
echo "------------------------------------------"

# Deregister instances from target group
# https://awscli.amazonaws.com/v2/documentation/api/latest/reference/elbv2/deregister-targets.html

INSTANCEIDS=$(aws ec2 describe-instances --query 'Reservations[*].Instances[?State.Name==running].InstanceId')

for IIDS in $INSTANCEIDS;
do
        aws elbv2 deregister-targets --target-group-arn $TARGETARN --targets Id=$IIDS;
        echo "Instance removed from target group"
done

echo "------------------------------------------"
echo "Deregistered ELB targets"
echo "------------------------------------------"

# Delete target group
# https://awscli.amazonaws.com/v2/documentation/api/latest/reference/elbv2/delete-target-group.html

# Delete target group
# https://awscli.amazonaws.com/v2/documentation/api/latest/reference/elbv2/delete-target-group.html

aws elbv2 wait delete-target-group --target-group-arn $TARGETARN

echo "------------------------------------------"
echo "Deleted target group"
echo "------------------------------------------"

# Delete EC2 instances

IDS=$(aws ec2 describe-instances --output=json | jq -r '.Reservations[].Instances[].InstanceId')
aws ec2 terminate-instances --instance-ids $IDS

echo "------------------------------------------"
echo "Terminated instances"
echo "------------------------------------------"

# Delete load-balancer

ELBARN=$(aws elbv2 describe-load-balancers --output=json | jq -r '.LoadBalancers[].LoadBalancerArn')
aws elbv2 delete-load-balancer --load-balancer-arn $ELBARN

echo "------------------------------------------"
echo "Deleted ELB load balancer."
echo "------------------------------------------"

# Delete load-balancer listener
LISTENARN=$(aws elbv2 describe-listeners --load-balancer-arn $ELBARN --query 'Listeners[0].ListenerArn' --output=json)
aws elbv2 delete-listener --load-balancer-arn $ELBARN --listener-arn $LISTENARN --port 80

echo "------------------------------------------"
echo "Deleted ELB listener"
echo "------------------------------------------"
echo "All services deleted"
echo "------------------------------------------"