#!/bin/bash

# Jeremy Hajek
# Andrei Neacsu :3
# Tomas Granickas
# Pranit Patil
# Ssanidhya Barraptay
# Daniela Munoz 
# Michael Martinez
# Naga Prasath
# Amith Satyanarayan

# VPCID=$(aws ec2 describe-vpcs --output=json | jq -r '.Vpcs[].VpcId') does the same as below
VPCID=$(aws ec2 describe-vpcs --query "Vpcs[].VpcId")
SUBNET=$(aws ec2 describe-subnets --output=json | jq -r '.Subnets[1,2].SubnetId')

aws ec2 run-instances --image-id $1 --instance-type $2 --key-name $3 --security-group-ids $4 --count ${5} --user-data file://$6
INSTANCEIDS=$(aws ec2 describe-instances --output=json | jq -r '.Reservations[].Instances[].InstanceId')

aws elbv2 create-load-balancer --name $8 --subnets $SUBNET
ELBARN=$(aws elbv2 describe-load-balancers --output=json | jq -r '.LoadBalancers[].LoadBalancerArn')

aws elbv2 wait load-balancer-available --load-balancer-arns $ELBARN

#https://docs.aws.amazon.com/cli/latest/reference/elbv2/create-target-group.html
TARGETARN=$(aws elbv2 create-target-group --name $9 --protocol HTTP --port 80 --target-type instance --vpc-id $VPCID --output=json | jq -r '.TargetGroups[].TargetGroupArn')

# https://docs.aws.amazon.com/cli/latest/reference/elbv2/register-targets.html
aws elbv2 register-targets --target-group-arn $TARGETARN --targets $INSTANCEIDS

# Create waiter for registering targets
# https://docs.aws.amazon.com/cli/latest/reference/elbv2/wait/target-in-service.html
aws elbv2 wait target-in-service --target-group-arn $TARGETARN

#Attach target group to ELB listener
# https://docs.aws.amazon.com/cli/latest/reference/elbv2/create-listener.html
aws elbv2 create-listener --load-balancer-arn $ELBARN --protocol HTTP --port 80 --default-actions Type=forward,TargetGroupArn=$TARGETARN

# Describe ELB - find the URL of the load-balancer

# NOTES
# https://docs.aws.amazon.com/cli/latest/