#!/bin/bash
##############################################################################
# Module-05
# This assignment requires you to modify your previous scripts and use the 
# Launch Template and Autoscaling group commands for creating EC2 instances
# You will need an additional script to generate a JSON file with parameters
# for your launch template. You will need to add an extras storage harddisk (EBS)
# to each EC2 instance, define and IAM profile to use and define the name of two
# S3 buckets to create
# 
# You will need to define these variables in a txt file named: arguments.txt
# 1 image-id
# 2 instance-type
# 3 key-name
# 4 security-group-ids
# 5 count
# 6 user-data file name
# 7 Tag (use the module name - later we can use the tags to query/filter
# 8 Target Group (use your initials)
# 9 elb-name (use your initials)
# 10 Availability Zone 1
# 11 Availablitty Zone 2
# 12 Launch Template Name
# 13 ASG name
# 14 ASG min
# 15 ASG max
# 16 ASG desired
# 17 AWS Region for LaunchTemplate (use your default region)
# 18 EBS disk storage size in GB
# 19 S3 Bucket One
# 20 S3 Bucket Two
##############################################################################

ltconfigfile="./config.json"

if [ $# = 0 ]
then
  echo "You don't have enough variables in your arugments.txt, perhaps you forgot to run: bash ./create-env.sh \$(< ~/arguments.txt)"
  exit 1 
elif ! [[ -a $ltconfigfile ]]
  then
  echo "The launch template configuration JSON file doesn't exist - make sure you run/ran the command: bash ./create-lt-json.sh \$(< ~/arguments.txt) command before running the create-env.sh \$(< ~/arguments.txt)"
   echo "Now exiting the program..."
   exit 1
# else run the creation logic
else
if [ -a $ltconfigfile ]
    then
    echo "Launch template data file: $ltconfigfile exists..." 
fi
echo "Finding and storing default VPCID value..."
# https://awscli.amazonaws.com/v2/documentation/api/latest/reference/ec2/describe-vpcs.html
VPCID=$(aws ec2 describe-vpcs --filters "Name=is-default,Values=true" --query "Vpcs[*].VpcId" --output=text)
echo $VPCID

echo "Finding and storing the subnet IDs for defined in arguments.txt Availability Zone 1 and 2..."
SUBNET2A=$(aws ec2 describe-subnets --output=text --query='Subnets[*].SubnetId' --filter "Name=availability-zone,Values=${10}")
SUBNET2B=$(aws ec2 describe-subnets --output=text --query='Subnets[*].SubnetId' --filter "Name=availability-zone,Values=${11}")
echo $SUBNET2A
echo $SUBNET2B

echo "Creating the AutoScalingGroup Launch Template..."
aws ec2 create-launch-template --launch-template-name ${12} --version-description AutoScalingVersion1 --launch-template-data file://config.json --region ${17}
echo "Launch Template created..."

# Launch Template Id
LAUNCHTEMPLATEID=

echo "Creating the TARGET GROUP and storing the ARN in \$TARGETARN"
# https://awscli.amazonaws.com/v2/documentation/api/2.0.34/reference/elbv2/create-target-group.html
TARGETARN=
echo $TARGETARN

echo "Creating ELBv2 Elastic Load Balancer..."
#https://awscli.amazonaws.com/v2/documentation/api/2.0.34/reference/elbv2/create-load-balancer.html
ELBARN=
echo $ELBARN

# AWS elbv2 wait for load-balancer available
# https://awscli.amazonaws.com/v2/documentation/api/latest/reference/elbv2/wait/load-balancer-available.html
echo "Waiting for load balancer to be available..."
aws elbv2 wait load-balancer-available --load-balancer-arns $ELBARN
echo "Load balancer available..."
# create AWS elbv2 listener for HTTP on port 80
#https://awscli.amazonaws.com/v2/documentation/api/latest/reference/elbv2/create-listener.html
aws elbv2 create-listener --load-balancer-arn $ELBARN --protocol HTTP --port 80 --default-actions Type=forward,TargetGroupArn=$TARGETARN

echo 'Creating Auto Scaling Group...'
# Create Autoscaling group ASG - needs to come after Target Group is created
# Create autoscaling group
# https://awscli.amazonaws.com/v2/documentation/api/latest/reference/autoscaling/create-auto-scaling-group.html
aws autoscaling create-auto-scaling-group 

echo 'Waiting for Auto Scaling Group to spin up EC2 instances and attach them to the TargetARN...'
# Create waiter for registering targets
# https://docs.aws.amazon.com/cli/latest/reference/elbv2/wait/target-in-service.html
aws elbv2 wait target-in-service --target-group-arn 
echo "Targets attached to Auto Scaling Group..."

# Collect Instance IDs
# https://stackoverflow.com/questions/31744316/aws-cli-filter-or-logic
INSTANCEIDS=$(aws ec2 describe-instances --output=text --query 'Reservations[*].Instances[*].InstanceId' --filter "Name=instance-state-name,Values=running,pending")

if [ "$INSTANCEIDS" != "" ]
  then
    aws ec2 wait instance-running --instance-ids 
    echo "Finished launching instances..."
  else
    echo 'There are no running or pending values in $INSTANCEIDS to wait for...'
fi 

# Add S3api commands to create two S3 buckets
# https://awscli.amazonaws.com/v2/documentation/api/latest/reference/s3api/index.html
echo "Creating S3 bucket: ${19}..."
aws s3api create-bucket 
echo "Created S3 bucket: ${19}..."

echo "Creating S3 bucket: ${20}..."
aws s3api create-bucket 
echo "Created S3 bucket: ${20}..."

# S3 commands
# https://awscli.amazonaws.com/v2/documentation/api/latest/reference/s3/index.html
# Upload illinoistech.png and rohit.jpg to bucket ${19}
echo "Uploading image: ./images/illinoistech.png to s3://${19}..."
aws s3 cp 
echo "Uploaded image: ./images/illinoistech.png to s3://${19}..."

echo "Uploading image: ./images/rohit.jpg to s3://${19}..."
aws s3 cp 
echo "Uploaded image: ./images/rohit.jpg to s3://${19}..."

echo "Listing content of bucket: s3://${19}..."
aws s3 ls 

# Upload ranking.jpg and elevate.webp to bucket ${20}
echo "Uploading image: ./images/elevate.webp to s3://${20}..."
aws s3 cp 
echo "Uploaded image: ./images/elevate.webp to s3://${20}..."

echo "Uploading image: ./images/ranking.jpg to s3://${20}..."
aws s3 cp 
echo "Uploaded image: ./images/ranking.jpg to s3://${20}..."

echo "Listing content of bucket: s3://${20}..."
aws s3 ls 

# Retreive ELBv2 URL via aws elbv2 describe-load-balancers --query and print it to the screen
#https://awscli.amazonaws.com/v2/documentation/api/latest/reference/elbv2/describe-load-balancers.html
URL=
echo $URL

# end of outer fi - based on arguments.txt content
fi
