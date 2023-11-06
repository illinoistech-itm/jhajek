#!/bin/bash

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
