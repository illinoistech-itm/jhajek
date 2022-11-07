#!/bin/bash

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
# $9 auto-scaling group name
# ${10} launch configuration name
# ${11} db instance identifier (database name)
# ${12} db instance identifier (for read-replica), append *-rpl*
# ${13} min-size = 2
# ${14} max-size = 5
# ${15} desired-capacity = 3
# ${16} Database engine (use mariadb)
# ${17} Database name ( use company )
# ${18} s3 raw bucket name (use initials and -raw)
# ${19} s3 finished bucket name (use initials and -fin)
# ${20} aws secret name
# ${21} iam-instance-profile
######################################################################

######################################################################
# New tasks to add
# Note this is not in any order -- you need to think about this 
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
SUBNET2A=$(aws ec2 describe-subnets --output=text --query='Subnets[*].SubnetId' --filter "Name=
availability-zone,Values=us-east-2a")
SUBNET2B=$(aws ec2 describe-subnets --output=text --query='Subnets[*].SubnetId' --filter "Name=
availability-zone,Values=us-east-2b")
VPCID=$(aws ec2 describe-vpcs --output=text --query='Vpcs[*].VpcId')

######################################################################################################################
# New MP1 requirements
######################################################################################################################
# Modify the database launches to not have a public IP address - no pubic ip and conncet them to the same subnet as your EC2 instances so they can communicate securely
# Remove your application layer security groups from the create-database, attach the two you set for ingress and egress

# https://awscli.amazonaws.com/v2/documentation/api/latest/reference/rds/create-db-instance.html
# --publicly-accessible | --no-publicly-accessible (boolean)

# Attach to a db-subnet-group
# --db-subnet-group-name

# Create a db-subnet-group and add your subnets to it
# https://awscli.amazonaws.com/v2/documentation/api/latest/reference/rds/create-db-subnet-group.html
# --vpc-security-group-ids (list)

#A list of Amazon EC2 VPC security groups to associate with this DB instance.
#Attach two groups (see demo) -- one with ingress rules for 3306 and one with egress rules for 3306 and make the source your 

# Create RDS subnet groups

# Create IAM role
# https://awscli.amazonaws.com/v2/documentation/api/latest/reference/iam/create-role.html

# Create IAM policy
# https://awscli.amazonaws.com/v2/documentation/api/latest/reference/iam/create-policy.html
# https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_policies_grammar.html

######################################################################################################################
# Week-07 template
######################################################################################################################

# Create Launch Configuration
# https://awscli.amazonaws.com/v2/documentation/api/latest/reference/autoscaling/create-launch-configuration.html

aws autoscaling create-launch-configuration --launch-configuration-name ${10} --image-id $1 --instance-type $2 --key-name $3 --security-groups $4 --user-data file://install-env.sh

echo "Creating target group: $8"
# Create AWS elbv2 target group (use default values for health-checks)
TGARN=$(aws elbv2 create-target-group --name $8 --protocol HTTP --port 80 --target-type instance --vpc-id $VPCID --query="TargetGroups[*].TargetGroupArn")

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

# Create autoscaling group
# https://awscli.amazonaws.com/v2/documentation/api/latest/reference/autoscaling/create-auto-scaling-group.html

echo "Launch configuration name is: ${10}"

aws autoscaling create-auto-scaling-group --auto-scaling-group-name ${9} --launch-configuration-name ${10} --min-size ${13} --max-size ${14} --desired-capacity ${15} --target-group-arns $TGARN  --health-check-type ELB --health-check-grace-period 600 --vpc-zone-identifier $SUBNET2A

# Retreive ELBv2 URL via aws elbv2 describe-load-balancers --query and print it to the screen
#https://awscli.amazonaws.com/v2/documentation/api/latest/reference/elbv2/describe-load-balancers.html
URL=$(aws elbv2 describe-load-balancers --output=json --load-balancer-arns $ELBARN --query='LoadBalancers[*].DNSName')
echo $URL