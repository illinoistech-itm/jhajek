#!/bin/bash

IDS=$(aws ec2 describe-instances --query Reservations[*].Instances[*].InstanceId)
aws ec2 terminate-instances $IDS