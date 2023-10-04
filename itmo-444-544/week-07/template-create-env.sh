#!/bin/bash

######################################################################
# Format of arguments.txt
# ${1} image-id
# ${2} instance-type
# ${3} key-name
# ${4} security-group-ids
# ${5} count
# ${6} user-data file name
# ${7} availability-zone 1 (choose a)
# ${8} elb name
# ${9} target group name
# ${10} availability-zone 2 (choose b)
# ${11} auto-scaling group name
# ${12} launch configuration name
# ${13} db instance identifier (database name)
# ${14} db instance identifier (for read-replica), append -rpl to the database name
# ${13} min-size = 2
# ${14} max-size = 5
# ${15} desired-capacity = 3
######################################################################

######################################################################
# New tasks to add
# Note this is NOT in any order -- you need to think about this 
# logically first -- perhaps write out on a piece of paper what you
# want to happen - then try to code it
######################################################################

# Create auto-scaling group
# Attach Launch configuration to auto-scaling group
# Attach load-balancer to auto-scaling group
# May have to change the logic of target group
# Create RDS instance of mariadb (default values for now are fine)
# Create and Read-Replica of RDS instance
# Create all necessary wait commands

# Tasks to accomplish

# Get Subnet 1 ID
# Get Subnet 2 ID
SUBNET2A=$(aws ec2 describe-subnets --output=text --query='Subnets[*].SubnetId' --filter "Name=availability-zone,Values=us-east-2a")
SUBNET2B=$(aws ec2 describe-subnets --output=text --query='Subnets[*].SubnetId' --filter "Name=availability-zone,Values=us-east-2b")
VPCID=$(aws ec2 describe-vpcs --output=text --query='Vpcs[*].VpcId')
SUBNET=$(aws ec2 describe-subnets --output=json | jq -r '.Subnets[1,2].SubnetId')

# Create Launch Configuration
# https://awscli.amazonaws.com/v2/documentation/api/latest/reference/autoscaling/create-launch-configuration.html

# Create autoscaling group
# https://awscli.amazonaws.com/v2/documentation/api/latest/reference/autoscaling/create-auto-scaling-group.html

aws ec2 run-instances --image-id $1 --instance-type $2 --key-name $3 --security-group-ids $4 --count ${5} --user-data file://$6 --placement AvailabilityZone=$7
# Using jq from the command line
# INSTANCEIDS=$(aws ec2 describe-instances --output=json | jq -r '.Reservations[].Instances[].InstanceId')

# Using aws --query functions to query for the InstanceIds of only RUNNING instances, not terminated IDs
# https://docs.aws.amazon.com/cli/latest/userguide/cli-usage-filter.html 
INSTANCEIDS=$(aws ec2 describe-instances --query 'Reservations[*].Instances[?State.Name==`running`].InstanceId')

aws elbv2 create-load-balancer --name $8 --subnets $SUBNET --type application --security-groups $4
ELBARN=$(aws elbv2 describe-load-balancers --output=json | jq -r '.LoadBalancers[].LoadBalancerArn')

aws elbv2 wait load-balancer-available --load-balancer-arns $ELBARN

#https://docs.aws.amazon.com/cli/latest/reference/elbv2/create-target-group.html
TARGETARN=$(aws elbv2 create-target-group --name $9 --protocol HTTP --port 80 --target-type instance --vpc-id $VPCID --output=json | jq -r '.TargetGroups[].TargetGroupArn')

# https://docs.aws.amazon.com/cli/latest/reference/elbv2/register-targets.html
# For loop that goes takes every value in INSTANCEIDS and puts it in IIDS 
for IIDS in $INSTANCEIDS;
do aws elbv2 register-targets --target-group-arn $TARGETARN --targets Id=$IIDS;
done

#Attach target group to ELB listener
#The listener is how AWS knows that a target group is accesible, without it the next wait target-in-service will not see anything and will be stuck
# https://docs.aws.amazon.com/cli/latest/reference/elbv2/create-listener.html
aws elbv2 create-listener --load-balancer-arn $ELBARN --protocol HTTP --port 80 --default-actions Type=forward,TargetGroupArn=$TARGETARN

# Create waiter for registering targets
# https://docs.aws.amazon.com/cli/latest/reference/elbv2/wait/target-in-service.html
aws elbv2 wait target-in-service --target-group-arn $TARGETARN

# Describe ELB - find the URL of the load-balancer

URL=$(aws elbv2 describe-load-balancers --output=json | jq -r  '.LoadBalancers[].DNSName')

echo $URL

# NOTES
# https://docs.aws.amazon.com/cli/latest/
