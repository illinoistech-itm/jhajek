#!/bin/bash

#create secret
echo "Creating AWS secret..."

# Modify your maria.json 

# https://awscli.amazonaws.com/v2/documentation/api/latest/reference/secretsmanager/get-secret-value.html#examples
aws secretsmanager create-secret --name ${21} --secret-string file://maria.json

SECRET_ID=$(aws secretsmanager list-secrets --filters Key=name,Values=${21} --query 'SecretList[*].ARN')
USERVALUE=$(aws secretsmanager get-secret-value --secret-id $SECRET_ID --output=json | jq '.SecretString' | sed 's/[\\nt]//g' | sed 's/^"//g' | sed 's/"$//g' | jq '.username' | sed 's/"//g')
PASSVALUE=$(aws secretsmanager get-secret-value --secret-id $SECRET_ID --output=json | jq '.SecretString' | sed 's/[\\nt]//g' | sed 's/^"//g' | sed 's/"$//g' | jq '.password' | sed 's/"//g')

echo $USERVALUE
echo $PASSVALUE
