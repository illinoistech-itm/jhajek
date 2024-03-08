#!/bin/bash

aws secretsmanager create-secret --name $AWS_SECRET_NAME --secret-string file://maria.json
SECRET_ID=$(aws secretsmanager list-secrets --filters Key=name,Values=$AWS_SECRET_NAME --query 'SecretList[*].ARN')
USERVALUE=$(aws secretsmanager get-secret-value --secret-id $SECRET_ID --output=json | jq '.SecretString' | sed 's/[\\]//g' | sed 's/^"//g' | sed 's/"$//g' | jq '.username' | sed 's/"//g')
PASSVALUE=$(aws secretsmanager get-secret-value --secret-id $SECRET_ID --output=json | jq '.SecretString' | sed 's/[\\]//g' | sed 's/^"//g' | sed 's/"$//g' | jq '.password' | sed 's/"//g')


aws rds wait db-instance-available \
--db-instance-identifier $MYDBINSTANCE  \
--no-cli-pager
echo "New DB instance creation: COMPLETED."

# Create DB instance replica
aws rds create-db-instance-read-replica \
--db-instance-identifier "$MYDBINSREPLICA-rpl" \
--source-db-instance-identifier $MYDBINSTANCE \
--no-cli-pager

echo "New DB instance replica creation: COMPLETED."

# Fetching RDS address
RDS_Address=$(aws rds describe-db-instances --db-instance-identifier $MYDBINSTANCE --query "DBInstances[0].Endpoint.Address")

# Never do this in reality -- and don't tell them your professor told you to do it
sudo mysql --user $USERVALUE --password=$PASSVALUE --host $RDS_Address < create.sql

