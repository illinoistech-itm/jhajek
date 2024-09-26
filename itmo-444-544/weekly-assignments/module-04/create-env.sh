#!/bin/bash

# Create ELB - 3 EC2 instances attached

# ${1} image-id
# ${2} instance-type
# ${3} key-name
# ${4} security-group-ids
# ${5} count
# ${6} user-data file name
# ${7} availability-zone
# ${8} elb name
# ${9} target group name
# ${10} us-east-2a
# ${11} us-east-2b
# ${12} us-east-2c
# ${13} tag value

echo "Finding and storing the subnet IDs for defined in arguments.txt Availability Zone 1 and 2..."
SUBNET2A=$(aws ec2 describe-subnets --output=text --query='Subnets[*].SubnetId' --filter "Name=availability-zone,Values=${10}")
SUBNET2B=$(aws ec2 describe-subnets --output=text --query='Subnets[*].SubnetId' --filter "Name=availability-zone,Values=${11}")
SUBNET2C=$(aws ec2 describe-subnets --output=text --query='Subnets[*].SubnetId' --filter "Name=availability-zone,Values=${12}")
echo $SUBNET2A
echo $SUBNET2B
echo $SUBNET2C

# https://docs.aws.amazon.com/cli/latest/reference/elbv2/create-load-balancer.html
aws elbv2 create-load-balancer \
    --name ${8} \
    --subnets $SUBNET2A $SUBNET2B $SUBNET2C \
    --security-groups ${4} \
    --tags Key='name',Value=${13}  
    
# https://docs.aws.amazon.com/cli/latest/reference/elbv2/describe-listeners.html
ELBARN=$(aws elbv2 describe-load-balancers --output=text --query='LoadBalancers[*].LoadBalancerArn')
echo "*****************************************************************"
echo "Printing ELBARN: $ELBARN"
echo "*****************************************************************"

# add elv2 wait running reference
# https://docs.aws.amazon.com/cli/latest/reference/elbv2/wait/
# https://awscli.amazonaws.com/v2/documentation/api/latest/reference/elbv2/wait/load-balancer-available.html
echo "Waiting for ELB to become available..."
aws elbv2 wait load-balancer-available --load-balancer-arns $ELBARN
echo "ELB is available..."

# https://awscli.amazonaws.com/v2/documentation/api/latest/reference/ec2/run-instances.html
aws ec2 run-instances --image-id ${1} --instance-type ${2}  --key-name ${3} --security-group-ids ${4} --count ${5} --user-data file://${6}

echo "Retrieving Instance ID"
EC2IDS=$(aws ec2 describe-instances \
    --output=text \
    --query='Reservations[*].Instances[*].InstanceId' --filter Name=instance-state-name,Values=pending,running)

echo "Waiting for instances..."
#https://docs.aws.amazon.com/cli/latest/reference/ec2/wait/instance-running.html
aws ec2 wait instance-running --instance-ids $EC2IDS
echo "Instances are up!"

# Find the VPC
# Note: the way I did it, I added a new argument on the arguments.txt file for VPC ID
#https://docs.aws.amazon.com/cli/latest/reference/ec2/describe-vpcs.html
MYVPCID=$(aws ec2 describe-vpcs --output=text --query='Vpcs[*].VpcId' )

# https://docs.aws.amazon.com/cli/latest/reference/elbv2/create-target-group.html
aws elbv2 create-target-group \
    --name ${9} \
    --protocol HTTP \
    --port 80 \
    --target-type instance \
    --vpc-id $MYVPCID
 
#https://docs.aws.amazon.com/cli/latest/reference/elbv2/describe-target-groups.html
TGARN=$(aws elbv2 describe-target-groups --output=text --query='TargetGroups[*].TargetGroupArn' --names ${9})
echo "Target group ARN: $TGARN"

#Creating listener
#https://awscli.amazonaws.com/v2/documentation/api/latest/reference/elbv2/create-listener.html
echo "Creating elbv2 listener..."
aws elbv2 create-listener --load-balancer-arn $ELBARN --protocol HTTP --port 80 --default-actions Type=forward,TargetGroupArn=$TGARN
echo "Created elbv2 listener..."

# https://awscli.amazonaws.com/v2/documentation/api/latest/reference/elbv2/register-targets.html
# https://awscli.amazonaws.com/v2/documentation/api/latest/reference/elbv2/wait/target-in-service.html
# Register targets and wait for them to be in service
# Create a bash Array so we can loop through it and take care of the Id= 
declare -a IDSARRAY
IDSARRAY=( $EC2IDS )

for ID in ${IDSARRAY[@]};
do
  echo "Now registering ID: $ID..."
  aws elbv2 register-targets \
    --target-group-arn $TGARN --targets Id=$ID
  echo "Waiting for $ID to be registered..."
  aws elbv2 wait target-in-service  --target-group-arn $TGARN --targets Id=$ID,Port=80
  echo "Target $ID is in service"
done

# GO to the elbv2 describe-load-balancers
# find DNS URL in the return object - and print the URL to the screen


DNSNAME=$(aws elbv2 describe-load-balancers --output=text --query='LoadBalancers[*].DNSName')
DNSNAME="http://$DNSNAME"
echo "DNS URL: $DNSName"