#!/bin/bash
set -e
set -x

######################################################################
# Format of arguments.txt
# $1 image-id
# $2 instance-type
# $3 key-name
# $4 security-group-ids
# $5 count (3)
# $6 availability-zone
# $7 elb name
# $8 target group name
######################################################################
# Tasks to accomplish

# Get Subnet 1 ID
# Get Subnet 2 ID
SUBNET2A=$(aws ec2 describe-subnets --output=text --query='Subnets[*].SubnetId' --filter "Name=
availability-zone,Values=us-east-2a")
SUBNET2B=$(aws ec2 describe-subnets --output=text --query='Subnets[*].SubnetId' --filter "Name=
availability-zone,Values=us-east-2b")
# Get VPCID
VPCID=$(aws ec2 describe-vpcs --output=text --query='Vpcs[*].VpcId')

# Need to launch 3 Ec2 instances. Create a target group, register EC2 instances with target group.  Attach Target group to Load balancer - via a listerner we will route requests via the LB to our instances in the TG

# Launch 3 EC2 instnaces 
# --placement $6
echo "launching EC2 instances of count: $5" 
aws ec2 run-instances --image-id $1 --instance-type $2 --key-name $3 --security-group-ids $4 --count $5  --user-data file://install-env.sh --no-cli-pager

# This code will filter for the instance IDs
EC2IDS=$(aws ec2 describe-instances --filters Name=instance-state-name,Values=running,pending --query='Reservations[*].Instances[*].InstanceId')
echo "EC2IDS content: $EC2IDS"

# Run EC2 wait until EC2 instances are in the running state
# https://awscli.amazonaws.com/v2/documentation/api/latest/reference/ec2/wait/index.html

echo "Waiting for instances to be in running state."
aws ec2 wait instance-running --instance-ids $EC2IDS

echo "Creating target group: $8"
# Create AWS elbv2 target group (use default values for health-checks)
TGARN=$(aws elbv2 create-target-group --name $8 --protocol HTTP --port 80 --target-type instance --vpc-id $VPCID --query="TargetGroups[*].TargetGroupArn")

# Register targets with the created target group
# https://awscli.amazonaws.com/v2/documentation/api/latest/reference/elbv2/register-targets.html
echo "Attaching EC2 targets to Target Group"
# Assignes the value of $EC2IDS and places each element (seperated by a space) into an array element
EC2IDSARRAY=($EC2IDS)

for EC2ID in ${EC2IDSARRAY[@]};
do
aws elbv2 register-targets --target-group-arn $TGARN --targets Id=$EC2ID
done
echo "Targets are registered"

# create AWS elbv2 load-balancer
echo "creating load balancer"
ELBARN=$(aws elbv2 create-load-balancer --security-groups $4 --name $7 --subnets $SUBNET2A $SUBNET2B --query='LoadBalancers[*].LoadBalancerArn')

# AWS elbv2 wait for load-balancer available
# https://awscli.amazonaws.com/v2/documentation/api/latest/reference/elbv2/wait/load-balancer-available.html
echo "waiting for load balancer to be available"
aws elbv2 wait load-balancer-available --load-balancer-arns $ELBARN
echo "Load balancer available"
# create AWS elbv2 listener for HTTP on port 80
#https://awscli.amazonaws.com/v2/documentation/api/latest/reference/elbv2/create-listener.html
aws elbv2 create-listener --load-balancer-arn $ELBARN --protocol HTTP --port 80 --default-actions Type=forward,TargetGroupArn=$TGARN

# Retreive ELBv2 URL via aws elbv2 describe-load-balancers --query and print it to the screen
#https://awscli.amazonaws.com/v2/documentation/api/latest/reference/elbv2/describe-load-balancers.html
URL=$(aws elbv2 describe-load-balancers --output=json --load-balancer-arns $ELBARN --query='LoadBalancers[*].DNSName')
echo $URL