#!/bin/bash



# Find the auto scaling group
# https://docs.aws.amazon.com/cli/latest/reference/autoscaling/describe-auto-scaling-groups.html
echo "Retrieving autoscaling group name..."
ASGNAME=$(aws autoscaling describe-auto-scaling-groups --output=text --query='AutoScalingGroups[*].AutoScalingGroupName')
echo "*****************************************************************"
echo "Autoscaling group name: $ASGNAME"
echo "*****************************************************************"

# Update the auto scaling group to remove the min and max values to zero
# https://docs.aws.amazon.com/cli/latest/reference/autoscaling/update-auto-scaling-group.html
echo "Updating $ASGNAME autoscaling group to set minimum and desired capacity to 0..."
aws autoscaling update-auto-scaling-group \
    --auto-scaling-group-name $ASGNAME \
    --health-check-type ELB \
    --min-size 0 \
    --desired-capacity 0
echo "$ASGNAME autoscaling group was updated!"

# Collect EC2 instance IDS
# First Describe EC2 instances
# https://docs.aws.amazon.com/cli/latest/reference/ec2/describe-instances.html
EC2IDS=$(aws ec2 describe-instances \
    --output=text \
    --query='Reservations[*].Instances[*].InstanceId' --filter Name=instance-state-name,Values=pending,running  )

declare -a IDSARRAY
IDSARRAY=( $EC2IDS )
# Add ec2 wait instances IDS terminated
# https://awscli.amazonaws.com/v2/documentation/api/latest/reference/ec2/wait/instance-terminated.html
# Now Terminate all EC2 instances
echo "Waiting for instances..."
aws ec2 wait instance-terminated --instance-ids $EC2IDS
echo "Instances are terminated!"

# Delete listeners after deregistering target group
ELBARN=$(aws elbv2 describe-load-balancers --output=text --query='LoadBalancers[*].LoadBalancerArn')
#https://docs.aws.amazon.com/cli/latest/reference/elbv2/describe-listeners.html
LISTARN=$(aws elbv2 describe-listeners --load-balancer-arn $ELBARN --output=text --query='Listeners[*].ListenerArn' )
#https://awscli.amazonaws.com/v2/documentation/api/latest/reference/elbv2/delete-listener.html
aws elbv2 delete-listener --listener-arn $LISTARN
aws elbv2 delete-target-group --target-group-arn $TGARN
aws elbv2 wait target-deregistered --target-group-arn $TGARN


#Dynamically detect your infrastrcuture and destroy it/terminate it
# SUBNET2B=$(aws ec2 describe-subnets --output=text --query='Subnets[*].SubnetId' --filter "Name=availability-zone,Values=${12}")
# First Query to get the ELB name using the --query and --filters
# https://docs.aws.amazon.com/cli/latest/reference/elbv2/describe-listeners.html
ELBARN=$(aws elbv2 describe-load-balancers --output=text --query='LoadBalancers[*].LoadBalancerArn')
echo "*****************************************************************"
echo "Printing ELBARN: $ELBARN"
echo "*****************************************************************"

#Delete loadbalancer
# https://docs.aws.amazon.com/cli/latest/reference/elbv2/delete-load-balancer.html
aws elbv2 delete-load-balancer --load-balancer-arn $ELBARN
aws elbv2 wait load-balancers-deleted --load-balancer-arns $ELBARN
echo "Load balancers deleted!"

# Delete the auto-scaling group
# https://docs.aws.amazon.com/cli/latest/reference/autoscaling/delete-auto-scaling-group.html
echo "Deleting $ASGNAME autoscaling group..."
aws autoscaling delete-auto-scaling-group \
    --auto-scaling-group-name $ASGNAME
echo "$ASGNAME autoscaling group was deleted!"






