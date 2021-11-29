#!/bin/bash

# Reuse all the code from mp1 - remove the RDS content, no need for that in this project

# Use the AWS CLI to Create a S3 Bucket

# Create DynamoDB Table
# I am giving you the table creation script for DynamoDB

aws dynamodb create-table --table-name ${10} \
    --attribute-definitions AttributeName=RecordNumber,AttributeType=S AttributeName=Email,AttributeType=S \
    --key-schema AttributeName=Email,KeyType=HASH AttributeName=RecordNumber,KeyType=RANGE --provisioned-throughput ReadCapacityUnits=5,WriteCapacityUnits=5 \
    --stream-specification StreamEnabled=TRUE,StreamViewType=NEW_AND_OLD_IMAGES

# Create SNS topic (to subscribe the users phone number to)
# Use the AWS CLI to create the SNS

# Install ELB and EC2 instances here -- remember to add waiters and provide and --iam-instance-profile so that your EC2 instances have permission to access SNS, S3, and DynamoDB
# Sample
#  --iam-instance-profile Name=$8

