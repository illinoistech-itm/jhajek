#!/bin/bash

# https://awscli.amazonaws.com/v2/documentation/api/latest/reference/ec2/run-instances.html
echo ${4}
aws ec2 run-instances --image-id ${1} --instance-type ${2}  --key-name ${3} --security-group-ids ${4} --count ${5} --user-data file://${6}
