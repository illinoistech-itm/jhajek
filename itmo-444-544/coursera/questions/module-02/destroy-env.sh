#!/bin/bash
##############################################################################
# Module Practice Assessment
# This assignment requires you to destroy the Cloud assets you created
# Remember to set you default output to text in the aws config command
##############################################################################

echo "Beginning destroy script for module-02..."

# Collect Instance IDs
INSTANCEIDS=

echo $INSTANCEIDS

# https://awscli.amazonaws.com/v2/documentation/api/latest/reference/ec2/wait/instance-terminated.html
# https://awscli.amazonaws.com/v2/documentation/api/latest/reference/ec2/terminate-instances.html

if [ "$INSTANCEIDS" != "" ]
  then
    aws ec2 terminate-instances
    echo "Waiting for all instances report state as TERMINATED..."
    aws ec2 wait instance-terminated
    echo "Finished destroying instances..."
  else
    echo 'There are no running values in $INSTANCEIDS to be terminated...'
fi 
