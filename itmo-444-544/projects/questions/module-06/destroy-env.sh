#!/bin/bash

# You have two RDS instances to delete -- also there is a read-replica that is attached to an RDS

# https://awscli.amazonaws.com/v2/documentation/api/latest/reference/rds/describe-db-instances.html
# Collect all database instance names into an array
echo "********************************************************************"
echo "Collecting RDs instance IDs into an array..."
MYDBINSTANCE=$(aws rds describe-db-instances --query "" )

if [ "$MYDBINSTANCE" == "" ]
then
  echo "There are no RDS Instances running to delete..."
else
    MYDBINSTANCE_ARRAY=($MYDBINSTANCE)
    echo $MYDBINSTANCE

    for i in "${MYDBINSTANCE_ARRAY[@]}"
    do
    echo "********************************************************************"
    echo "Found RDS Instance-ID: $i and deleting..."
    echo "********************************************************************"
    aws rds delete-db-instance --db-instance-identifier $i --skip-final-snapshot --delete-automated-backups --no-cli-pager
    echo "********************************************************************"
    echo "Waiting for instance-id: $i to finish deleting..."
    echo "********************************************************************"
    aws rds wait db-instance-deleted --db-instance-identifier $i --no-cli-pager
    echo "********************************************************************"
    echo "Deleted RDS instance-id: $i..."
    echo "********************************************************************"
    done
echo "Module-06 deletion finished..."
# End of main if
fi
