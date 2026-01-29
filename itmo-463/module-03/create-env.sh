#!/bin/bash

echo "Beginning to run AWS EC2 create instances command..."
aws ec2 run-instances --image-id ${1} --instance-type ${2} --key-name ${3} --security-group-ids ${4} --count=${5} --user-data file://${6}