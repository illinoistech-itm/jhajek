#!/bin/bash

#create secret
echo "creating secret..."

# Add maria.json to your .gitignore file on your host system, push this to GitHub
# Modify your maria-template.json not on the local system but on your Vagrant Box after you have
# issued a git pull - rename the maria-template.json to maria.json and add a username and password
aws secretsmanager create-secret --name ${20} --secret-string file://maria.json

# This is a shell script to scrape the username and password out of the secret string that is returned
# This is pretty awful, but that is due to every variable is BASH being text only
# This script works only if there are two values - username and password in the .json file
# You would adjust the AWK print filed (note that value has nothing to do with the positional parameters)
USERVALUE=$(aws secretsmanager get-secret-value --secret-id ${20} --output=json | jq '.SecretString' | tr -s , ' ' | tr -s ['"'] ' ' | awk {'print $6'} |  tr -d '\\')

PASSVALUE=$(aws secretsmanager get-secret-value --secret-id ${20} --output=json | jq '.SecretString' | tr -s } ' ' | tr -s ['"'] ' ' | awk {'print $12'} | tr -d '\\')

#create database
echo "creating database"
aws rds create-db-instance --db-instance-identifier ${11} --db-instance-class db.t3.micro --engine ${16} --master-username $USERVALUE --master-user-password $PASSVALUE --allocated-storage 20 --backup-retention-period 0

# Note how in the wait command we can just use $11 instead of having to query for the db-instance-identifier
aws rds wait db-instance-available --db-instance-identifier ${11}

#create s3 bucket
echo "creating s3 buckets"
aws s3api create-bucket --bucket ${18} --region us-east-1
aws s3api create-bucket --bucket ${19} --region us-east-1

aws s3api wait bucket-exists --bucket ${18}
aws s3api wait bucket-exists --bucket ${19}
echo "s3 buckets made"

# use to build custom ec2 image
# This will go into your create-launch-configuration but I am showing a stub here 
# You will use ${21} in my sample video I hard coded the ARN - but you can use ${21} as you will pass in the name of the IAM
# profile you created previously
aws ec2 run-instances --image-id $1 --instance-type $2 --key-name $3 --security-group-ids $4 --iam-instance-profile ${21} --user-data file://install-env.sh