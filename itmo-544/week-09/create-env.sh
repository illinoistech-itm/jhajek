#!/bin/bash

aws ec2 run-instances --image-id $1 --instance-type $2 --count $3 --subnet-id $4 --key-name $5 --security-group-ids $6 --user-data $7