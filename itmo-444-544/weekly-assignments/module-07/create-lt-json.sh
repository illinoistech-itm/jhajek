#!/bin/bash

ltconfigfile="./config.json"

if [ -a $ltconfigfile ]
then
  echo "You have already created the launch-tempalte-data file ./config.json..."
  exit 1
elif [ $# = 0 ]
  then
  echo "You don't have enough variables in your arugments.txt, perhaps you forgot to run: bash ./create-lt-json.sh \$(< ~/arguments.txt)"
  exit 1
else
echo 'Creating lauch template data file ./config.json...'

echo "Finding and storing the subnet IDs for defined in arguments.txt Availability Zone 1 and 2..."
SUBNET2A=$(aws ec2 describe-subnets --output=text --query='Subnets[*].SubnetId' --filter "Name=availability-zone,Values=${10}")
SUBNET2B=$(aws ec2 describe-subnets --output=text --query='Subnets[*].SubnetId' --filter "Name=availability-zone,Values=${11}")
echo $SUBNET2A
echo $SUBNET2B

# Create Launch Template
# Now under EC2 not auto-scaling groups
# https://awscli.amazonaws.com/v2/documentation/api/latest/reference/ec2/create-launch-template.html
# Need to convert the user-data file to a base64 string
# https://en.wikipedia.org/wiki/Base64
# https://stackoverflow.com/questions/38578528/base64-encoding-new-line
# base64 will line wrap after 76 characters -- causing the aws ec2 create-launch-template to break
# the -w 0 options will stop the line break from happening in the base64 output

BASECONVERT=$(base64 -w 0 < ${6})

# This is the JSON object that is passed to the create template in a more readable form
# We will save it to a variable here named JSON
# Then write it out to a file -- and then attach it to the --launch-template-data option
# Otherwise we are running into issues with the dynamic bash variables
# Add BlockDeviceMappings for adding additional EBS store to each EC2 instance
# Add IAM profile to EC2 instances to allow S3 communication
# https://awscli.amazonaws.com/v2/documentation/api/latest/reference/ec2/create-launch-template.html#examples

JSON="{
    \"NetworkInterfaces\": [
        {
            \"DeviceIndex\": 0,
            \"AssociatePublicIpAddress\": true,
            \"Groups\": [
                \"${4}\"
            ],
            \"SubnetId\": \"$SUBNET2A\",
            \"DeleteOnTermination\": true
        }
    ],
    \"ImageId\": \"${1}\",
    \"IamInstanceProfile\" : {
      \"Name\": \"${20}\"
    }, 
    \"InstanceType\": \"${2}\",
    \"KeyName\": \"${3}\",
    \"UserData\": \"$BASECONVERT\",
    \"Placement\": {
        \"AvailabilityZone\": \"${10}\"
    }
}"

#,\"TagSpecifications\":[{\"ResourceType\":\"instance\",\"Tags\":[{\"Key\":\"module\",\"Value\": \"${7}\" }]}]
# Redirecting the content of our JSON to a file
echo $JSON > ./config.json

# End of main IF
fi