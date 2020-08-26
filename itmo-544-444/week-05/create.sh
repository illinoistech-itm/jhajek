#!/bin/bash

# shell script to create AWS resources

aws ec2 run-instances --image-id ami-51537029 --count 1 --instance-type t2.micro --key-name x44-sp2 --security-groups inclass2018 --user-data file://create-env.sh
