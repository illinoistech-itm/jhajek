#!/bin/bash
##############################################################################
# Module-02 Assessement
# This assignment requires you to launch 3 EC2 instances from the commandline
# Of type t2.micro using the keypair and securitygroup ID you created 
# 
# You will need to define these variables in a text file named: arguments.txt
# Located in your Vagrant Box home directory
# 1 image-id
# 2 instance-type
# 3 key-name
# 4 security-group-ids
# 5 count
# 6 user-data install-env.sh is provided for you 
# 7 Tag (use the name: module2-tag)
##############################################################################

# initial if statement to make sure that you pass the commandline variables via
# the arguments.txt file
# Fill in the blanks below
if [ $# = 0 ]
then
  echo 'You do not have enough variable in your arugments.txt, perhaps you forgot to run: bash ./create-env.sh $(< ~/arguments.txt)'
  exit 1
else
echo "Beginning to launch $5 EC2 instances..."
# https://awscli.amazonaws.com/v2/documentation/api/latest/reference/ec2/run-instances.html
aws ec2 run-instances 

#https://awscli.amazonaws.com/v2/documentation/api/latest/reference/ec2/wait/instance-running.html
echo "Waiting until instances are in RUNNING state..."

# Collect your running instance IDS
# https://stackoverflow.com/questions/31744316/aws-cli-filter-or-logic
INSTANCEIDS=

echo $INSTANCEIDS

# Check to make sure the value is not blank and then wait for Instances to be in the
# running state
if [ "$INSTANCEIDS" != "" ]
  then
    aws ec2 wait instance-running 
    echo "Finished launching instances..."
  else
    echo 'There are no running or pending values in $INSTANCEIDS to wait for...'
fi 

# end of outer fi - based on arguments.txt content
fi