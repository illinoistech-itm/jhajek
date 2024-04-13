#!/bin/bash

##############################################################################
# Module 06
# You will be creating an AWS secret, and RDS instance and a Read-Replica in 
# this module
# Append "-read-replica" to the ${22} to create the read-replica name
##############################################################################
# 1 image-id
# 2 instance-type
# 3 key-name
# 4 security-group-ids
# 5 count - of 3
# 6 user-data -- install-env.sh you will be provided 
# 7 Tag -- use the module name: `module6-tag`
# 8 Target Group (use your initials)
# 9 elb-name (use your initials)
# 10 Availability Zone 1
# 11 Availability Zone 2
# 12 Launch Template Name
# 13 ASG name
# 14 ASG min=2
# 15 ASG max=5
# 16 ASG desired=3
# 17 AWS Region for LaunchTemplate (use your default region)
# 18 EBS hard drive size in GB (15)
# 19 S3 bucket name one - use initials
# 20 S3 bucket name two - use initials
# 21 Secret Name
# 22 Database Name

SECRET_ID=$(aws secretsmanager list-secrets --filters Key=name,Values=${21} --query 'SecretList[*].ARN')

if [ $# = 0 ]
    then
    echo "You don't have enough variables in your arugments.txt, perhaps you forgot to run: bash ./create-secrets.sh \$(< ~/arguments.txt)"
    exit 1
elif [ "$SECRET_ID" == "" ]
    then
     echo "You haven't created the secret your named in \$\{21\}..." 
     echo "Check to see if you ran the command: bash ./create-secrets.sh \$(< ~/arguments.txt)"
else

    USERVALUE=$(aws secretsmanager get-secret-value --secret-id $SECRET_ID --output=json | jq '.SecretString' | sed 's/[\\n]//g' | sed 's/^"//g' | sed 's/"$//g' | jq '.user' | sed 's/"//g')
    PASSVALUE=$(aws secretsmanager get-secret-value --secret-id $SECRET_ID --output=json | jq '.SecretString' | sed 's/[\\n]//g' | sed 's/^"//g' | sed 's/"$//g' | jq '.pass' | sed 's/"//g')

    # Create RDS instances
    # https://awscli.amazonaws.com/v2/documentation/api/latest/reference/rds/index.html
    echo "******************************************************************************"
    echo "Creating RDS instance..."
    echo "******************************************************************************"
    aws rds create-db-instance --db-instance-identifier  --db-instance-class db.t3.micro --engine --master-username $USERVALUE --master-user-password $PASSVALUE --allocated-storage 20 --db-name employee_database --tags="Key=assessment,Value=${7}"
    # Add wait command for db-instance available
    # https://awscli.amazonaws.com/v2/documentation/api/latest/reference/rds/wait/db-instance-available.html
    echo "******************************************************************************"
    echo "Waiting for RDS instance: to be created..."
    echo "This might take around 5-15 minutes..."
    echo "******************************************************************************"
    aws rds wait db-instance-available --db-instance-identifier
    echo "******************************************************************************"
    echo "RDS instance created and in the available state..."
    echo "******************************************************************************"
    # https://awscli.amazonaws.com/v2/documentation/api/latest/reference/rds/create-db-instance-read-replica.html
    echo "******************************************************************************"
    echo "Creating RDS read-replica instance..."
    echo "******************************************************************************"
    # Append "-read-replica" to the ${22} to create the read-replica name
    aws rds create-db-instance-read-replica --db-instance-identifier  --source-db-instance-identifier --tags="Key=assessment,Value=${7}"

    # https://awscli.amazonaws.com/v2/documentation/api/latest/reference/rds/wait/db-instance-available.html
    echo "******************************************************************************"
    echo "Waiting for RDS read-replica instance to be created..."
    echo "This might take another 5-15 minutes..."
    echo "Perhaps check out https://xkcd.com/303/ ..."
    echo "******************************************************************************"
    aws rds wait db-instance-available --db-instance-identifier 

    # Fetching RDS address
    # https://awscli.amazonaws.com/v2/documentation/api/latest/reference/rds/describe-db-instances.html
    echo "******************************************************************************"
    echo "Retrieving the RDS Endpoint Address and printing to the screen..."
    RDS_Address=$(aws rds describe-db-instances --db-instance-identifier --query "")
    echo $RDS_Address
    echo "Retrieving the RDS Read Replica Endpoint Address and printing to the screen..."
    RDS_RR_Address=$(aws rds describe-db-instances --db-instance-identifier  --query "")
    echo $RDS_RR_Address
# End of main if
fi
