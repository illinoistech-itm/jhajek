#!/bin/bash

aws secretsmanager create-secret --name $AWS_SECRET_NAME --secret-string file://maria.json
SECRET_ID=$(aws secretsmanager list-secrets --filters Key=name,Values=$AWS_SECRET_NAME --query 'SecretList[*].ARN')
USERVALUE=$(aws secretsmanager get-secret-value --secret-id $SECRET_ID --output=json | jq '.SecretString' | tr -s , ' ' | tr -s ['"'] ' ' | awk {'print $6'} |  tr -d '\\')
PASSVALUE=$(aws secretsmanager get-secret-value --secret-id $SECRET_ID --output=json | jq '.SecretString' | tr -s } ' ' | tr -s ['"'] ' ' | awk {'print $12'} | tr -d '\\')


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
RDS_Address=$(aws rds describe-db-instances --db-instance-identifier $MYDBINSTANCE --query "DBInstances[*].Endpoint.Address")

sudo mysql --user $USERVALUE --password=$PASSVALUE --host $RDS_Address < create.sql

