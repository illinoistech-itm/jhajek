#!/bin/bash
##############################################################################
# Final Assessment Module
# This assignment requires you combine all the features of module 4, 5 and 6 
# into a single script
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
# 21 Secret Name
# 22 Database Name
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
aws ec2 create-launch-template --launch-template-name  --version-description AutoScalingVersion1 --launch-template-data file://config.json --region
echo "Launch Template created..."

# Launch Template Id
LAUNCHTEMPLATEID=

echo "Creating the TARGET GROUP and storing the ARN in \$TARGETARN"
# https://awscli.amazonaws.com/v2/documentation/api/2.0.34/reference/elbv2/create-target-group.html
TARGETARN=$(aws elbv2 create-target-group --name  --protocol  --port  --target-type instance --vpc-id $VPCID --query="")
echo $TARGETARN

echo "Creating ELBv2 Elastic Load Balancer..."
#https://awscli.amazonaws.com/v2/documentation/api/2.0.34/reference/elbv2/create-load-balancer.html
ELBARN=$(aws elbv2 create-load-balancer --name  --security-groups  --subnets  --query='')
echo $ELBARN

# AWS elbv2 wait for load-balancer available
# https://awscli.amazonaws.com/v2/documentation/api/latest/reference/elbv2/wait/load-balancer-available.html
echo "Waiting for load balancer to be available..."
aws elbv2 wait load-balancer-available --load-balancer-arns
echo "Load balancer available..."
# create AWS elbv2 listener for HTTP on port 80
#https://awscli.amazonaws.com/v2/documentation/api/latest/reference/elbv2/create-listener.html
aws elbv2 create-listener --load-balancer-arn $ELBARN --protocol HTTP --port 80 --default-actions Type=forward,TargetGroupArn=$TARGETARN

echo 'Creating Auto Scaling Group...'
# Create Autoscaling group ASG - needs to come after Target Group is created
# Create autoscaling group
# https://awscli.amazonaws.com/v2/documentation/api/latest/reference/autoscaling/create-auto-scaling-group.html
aws autoscaling create-auto-scaling-group \
    --auto-scaling-group-name  \
    --launch-template LaunchTemplateId=$LAUNCHTEMPLATEID \
    --target-group-arns  \
    --health-check-grace-period 600 \
    --min-size  \
    --max-size  \
    --desired-capacity  \
    --availability-zones  \
    --health-check-type EC2 \
    --tags "ResourceId=${13},ResourceType=auto-scaling-group,Key=assessment,Value=${7},PropagateAtLaunch=true" 

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
aws s3api create-bucket \
    --bucket \
    --region us-east-1
echo "Created S3 bucket: ${19}..."

# https://awscli.amazonaws.com/v2/documentation/api/latest/reference/s3api/wait/bucket-exists.html
echo "Waiting for bucket ${19} to be in a ready state..."
# add a s3api wait for bucket here!!!!!!!!!!!!!!!!!!!
echo "Bucket ${19} is in a ready state..."

echo "Creating S3 bucket: ${20}..."
aws s3api create-bucket \
    --bucket \
    --region us-east-1
echo "Created S3 bucket: ${20}..."

# https://awscli.amazonaws.com/v2/documentation/api/latest/reference/s3api/wait/bucket-exists.html
echo "Waiting for bucket ${20} to be in a ready state..."
# add a s3api wait for bucket here!!!!!!!!!!!!!!!!!!!
echo "Bucket ${20} is in a ready state..."

# S3 commands
# https://awscli.amazonaws.com/v2/documentation/api/latest/reference/s3/index.html
# Upload illinoistech.png and rohit.jpg to bucket ${19}
echo "Uploading image: ./images/illinoistech.png to s3://${19}..."
aws s3 cp ./images/illinoistech.png s3://${19}
echo "Uploaded image: ./images/illinoistech.png to s3://${19}..."

echo "Uploading image: ./images/rohit.jpg to s3://${19}..."
aws s3 cp ./images/rohit.jpg s3://${19}
echo "Uploaded image: ./images/rohit.jpg to s3://${19}..."

echo "Listing content of bucket: s3://${19}..."
aws s3 ls s3://${19}

# Upload ranking.jpg and elevate.webp to bucket ${20}
echo "Uploading image: ./images/elevate.webp to s3://${20}..."
aws s3 cp ./images/elevate.webp s3://${20}
echo "Uploaded image: ./images/elevate.webp to s3://${20}..."

echo "Uploading image: ./images/ranking.jpg to s3://${20}..."
aws s3 cp ./images/ranking.jpg s3://${20}
echo "Uploaded image: ./images/ranking.jpg to s3://${20}..."

echo "Listing content of bucket: s3://${20}..."
aws s3 ls s3://${20}

# Retreive ELBv2 URL via aws elbv2 describe-load-balancers --query and print it to the screen
#https://awscli.amazonaws.com/v2/documentation/api/latest/reference/elbv2/describe-load-balancers.html
URL=$(aws elbv2 describe-load-balancers --load-balancer-arns  --query='')
echo $URL

SECRET_ID=$(aws secretsmanager list-secrets --filters Key=name,Values=${21} --query 'SecretList[*].ARN')

USERVALUE=$(aws secretsmanager get-secret-value --secret-id $SECRET_ID --output=json | jq '.SecretString' | sed 's/[\\n]//g' | sed 's/^"//g' | sed 's/"$//g' | jq '.user' | sed 's/"//g')
PASSVALUE=$(aws secretsmanager get-secret-value --secret-id $SECRET_ID --output=json | jq '.SecretString' | sed 's/[\\n]//g' | sed 's/^"//g' | sed 's/"$//g' | jq '.pass' | sed 's/"//g')

# Create RDS instances
# https://awscli.amazonaws.com/v2/documentation/api/latest/reference/rds/index.html
echo "******************************************************************************"
echo "Creating ${22} RDS instances..."
echo "******************************************************************************"
aws rds create-db-instance --db-instance-identifier --db-instance-class db.t3.micro --engine --master-username $USERVALUE --master-user-password $PASSVALUE --allocated-storage --db-name employee_database --tags="Key=assessment,Value=${7}"

# Add wait command for db-instance available
# https://awscli.amazonaws.com/v2/documentation/api/latest/reference/rds/wait/db-instance-available.html
echo "******************************************************************************"
echo "Waiting for RDS instance: ${22} to be created..."
echo "This might take around 5-15 minutes..."
echo "******************************************************************************"
aws rds wait db-instance-available --db-instance-identifier 
echo "******************************************************************************"
echo "RDS instance: ${22} created and in available state..."
echo "******************************************************************************"
# https://awscli.amazonaws.com/v2/documentation/api/latest/reference/rds/create-db-instance-read-replica.html
echo "******************************************************************************"
echo "Creating RDS instance: ${22}-read-replica..."
echo "******************************************************************************"
aws rds create-db-instance-read-replica --db-instance-identifier --source-db-instance-identifier --tags="Key=assessment,Value=${7}"

# https://awscli.amazonaws.com/v2/documentation/api/latest/reference/rds/wait/db-instance-available.html
echo "******************************************************************************"
echo "Waiting for RDS instance: ${22}-read-replica to be created..."
echo "This might take another 5-15 minutes..."
echo "Perhaps check out https://xkcd.com/303/ ..."
echo "******************************************************************************"
### !!! CREATE AN AWS RDS WAIT command to wait for the Read-Replica to be in service

# Fetching RDS address
# https://awscli.amazonaws.com/v2/documentation/api/latest/reference/rds/describe-db-instances.html
echo "******************************************************************************"
echo "Retrieving the RDS Endpoint Address and printing to the screen..."
echo "******************************************************************************"
RDS_Address=$(aws rds describe-db-instances --db-instance-identifier ${22} --query "DBInstances[0].Endpoint.Address")
echo $RDS_Address
echo "Retrieving the RDS Read Replica Endpoint Address and printing to the screen..."
RDS_RR_Address=$(aws rds describe-db-instances --db-instance-identifier ${22}-read-replica --query "DBInstances[0].Endpoint.Address")
echo $RDS_RR_Address

# end of outer fi - based on arguments.txt content
fi
