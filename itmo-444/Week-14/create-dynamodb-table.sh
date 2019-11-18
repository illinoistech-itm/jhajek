#!/bin/bash

# https://docs.aws.amazon.com/cli/latest/reference/dynamodb/create-table.html

aws dynamodb create-table --table-name RecordsXYZ --attribute-definitions AttributeName=Receipt,AttributeType=S AttributeName=Email,AttributeType=S --key-schema AttributeName=Receipt,KeyType=HASH AttributeName=Email,KeyType=RANGE --provisioned-throughput ReadCapacityUnits=5,WriteCapacityUnits=5

aws dynamodb describe-table --table-name RecordsXYZ