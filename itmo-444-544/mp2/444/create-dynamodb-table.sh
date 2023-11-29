#!/bin/bash

# https://awscli.amazonaws.com/v2/documentation/api/latest/reference/dynamodb/create-table.html

# Table name now has to be uniqu
# Attribute definitions are only needed for the Hash-Key and Range Key - this is a NoSQL so there is no schema

# -- sql schema
#ID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
#RecordNumber VARCHAR(64), -- This is the UUID
#CustomerName VARCHAR(64),
#Email VARCHAR(64),
#Phone VARCHAR(64),
#Stat INT(1) DEFAULT 0, -- Job status, not done is 0, done is 1
#RAWS3URL VARCHAR(200), -- set the returned S3URL here
#FINSIHEDS3URL VARCHAR(200)

IDENTITY=$(aws sts get-caller-identity --output json --query='Arn')
echo "Identity: $IDENTITY"

aws dynamodb create-table \
    --table-name ${23} \
    --attribute-definitions AttributeName=Email,AttributeType=S AttributeName=RecordNumber,AttributeType=S \
    --key-schema AttributeName=Email,KeyType=HASH AttributeName=RecordNumber,KeyType=RANGE \
    --provisioned-throughput ReadCapacityUnits=5,WriteCapacityUnits=5 \
    --tags Key=Owner,Value=$IDENTITY

# DynamoDB WAIT Commands
# https://awscli.amazonaws.com/v2/documentation/api/latest/reference/dynamodb/wait/index.html
aws dynamodb wait table-exists --table-name ${23}

# Put Item for DynomoDB -- like an SQL INSERT command
# https://awscli.amazonaws.com/v2/documentation/api/latest/reference/dynamodb/put-item.html
# The test record we are inserting here is defined in an external file: item.json

aws dynamodb put-item \
    --table-name ${23} \
    --item file://item.json \
    --return-consumed-capacity TOTAL \
    --return-item-collection-metrics SIZE

# Query your DynamoDB table for records
# https://awscli.amazonaws.com/v2/documentation/api/latest/reference/dynamodb/query.html
aws dynamodb query \
    --table-name ${23} \
    --key-condition-expression "Email = :v1" \
    --expression-attribute-values file://expression-attributes.json \
    --return-consumed-capacity  ALL_PROJECTED_ATTRIBUTES \
    --output=json

