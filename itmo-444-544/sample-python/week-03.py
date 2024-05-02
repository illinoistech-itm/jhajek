#!/usr/bin/python3

# Rob is here
# Jeremy is here
# Rich W is here
# https://aws.amazon.com/sdk-for-python/

import boto3

ec2 = boto3.client('ec2')

responseEC2 = ec2.describe_vpcs(
    Filters=[
        {
            'Name': 'is-default',
            'Values': [
                'true',
            ]
        }
    ]
)

print("VPC ID is: " + responseEC2)

responseSubnetEC2 = ec2.describe_subnets(
    Filters=[
        {
            'Name': 'availability-zone',
            'Values': [
                '${10}',
            ]
        },
    ],
    SubnetIds=[
        'string',
    ],
    DryRun=True|False,
    NextToken='string',
    MaxResults=123
)

'''
if [ $# = 0 ]
then
  echo 'You do not have enough variable in your arguments.txt, perhaps you forgot to run: bash ./create-env.sh $(< ~/arguments.txt)'
  exit 1
else
echo "Finding and storing default VPCID value..."
# https://awscli.amazonaws.com/v2/documentation/api/latest/reference/ec2/describe-vpcs.html
VPCID=$(aws ec2 describe-vpcs --filters "Name=is-default,Values=true" --query "Vpcs[*].VpcId" --output=text)
echo $VPCID



echo "Finding and storing the subnet IDs for defined in arguments.txt Availability Zone 1 and 2..."
SUBNET2A=$(aws ec2 describe-subnets --output=text --query='Subnets[*].SubnetId' --filter "Name=availability-zone,Values=${10}")
SUBNET2B=$(aws ec2 describe-subnets --output=text --query='Subnets[*].SubnetId' --filter "Name=availability-zone,Values=${11}")
echo $SUBNET2A
echo $SUBNET2B


echo 'Creating the TARGET GROUP and storing the ARN in $TARGETARN...'
# https://awscli.amazonaws.com/v2/documentation/api/2.0.34/reference/elbv2/create-target-group.html
TARGETARN=

# Decrease the deregistration timeout (deregisters faster than the default 300 second timeout per instance)
# https://awscli.amazonaws.com/v2/documentation/api/latest/reference/elbv2/modify-target-group-attributes.html
aws elbv2 modify-target-group-attributes --target-group-arn $TARGETARN --attributes Key=deregistration_delay.timeout_seconds,Value=30

echo "Creating ELBv2 Elastic Load Balancer..."
#https://awscli.amazonaws.com/v2/documentation/api/2.0.34/reference/elbv2/create-load-balancer.html
ELBARN=
echo $ELBARN

# AWS elbv2 wait for load-balancer available
# https://awscli.amazonaws.com/v2/documentation/api/latest/reference/elbv2/wait/load-balancer-available.html
echo "Waiting for load balancer to be available..."
aws elbv2 wait load-balancer-available 
echo "Load balancer available..."
# create AWS elbv2 listener for HTTP on port 80
#https://awscli.amazonaws.com/v2/documentation/api/latest/reference/elbv2/create-listener.html
aws elbv2 create-listener 

echo "Beginning to create and launch instances..."
# https://awscli.amazonaws.com/v2/documentation/api/latest/reference/ec2/run-instances.html
# Make sure to launch your instances into a subnet that is part of your load-balancer
aws ec2 run-instances 

# Collect Instance IDs
# https://stackoverflow.com/questions/31744316/aws-cli-filter-or-logic
INSTANCEIDS=$(aws ec2 describe-instances --output=text --query 'Reservations[*].Instances[*].InstanceId' --filter "Name=instance-state-name,Values=running,pending")

#https://awscli.amazonaws.com/v2/documentation/api/latest/reference/ec2/wait/instance-running.html
echo "Waiting until instances are in the RUNNING state..."
echo $INSTANCEIDS

if [ "$INSTANCEIDS" != "" ]
  then
    aws ec2 wait instance-running --instance-ids $INSTANCEIDS
    echo "Waiting for Instances to be in the RUNNING state..."
    echo "$INSTANCEIDS to be registered with the target group..."
    # https://awscli.amazonaws.com/v2/documentation/api/2.0.34/reference/elbv2/register-targets.html
    # Assignes the value of $EC2IDS and places each element (seperated by a space) into an array element
    INSTANCEIDSARRAY=($INSTANCEIDS)
    for INSTANCEID in ${INSTANCEIDSARRAY[@]};
      do
      aws elbv2 register-targets 
      done
  else
    echo "There are no running or pending instances in $INSTANCEIDS to wait for..."
fi 

# Retreive ELBv2 URL via aws elbv2 describe-load-balancers --query and print it to the screen
#https://awscli.amazonaws.com/v2/documentation/api/latest/reference/elbv2/describe-load-balancers.html
URL=$(aws elbv2 describe-load-balancers 
echo $URL

# end of outer fi - based on arguments.txt content
fi


'''