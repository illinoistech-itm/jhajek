#!/bin/bash
##############################################################################
# Final assessment ITMO-444
# This file is perfectly done -- no need to modify it - focus on the
# create-env.sh
##############################################################################
ltconfigfile="./config.json"

echo "Beginning destroy script for Final Assessment ITMO-444..."

echo "Finding Launch template configuration file: $ltconfigfile..."
if [ -a $ltconfigfile ]
then
  echo "Deleting Launch template configuration file: $ltconfigfile..."
  rm $ltconfigfile
  echo "Deleted Launch template configuration file: $ltconfigfile..."
else
  echo "Launch template configuration file: $ltconfigfile doesn't exist, moving on..."
# end of config.json delete
fi

# Collect Instance IDs
INSTANCEIDS=$(aws ec2 describe-instances --output=text --query 'Reservations[*].Instances[*].InstanceId' --filter "Name=instance-state-name,Values=running")

echo 'Finding autoscaling groups...'
ASGNAMES=$(aws autoscaling describe-auto-scaling-groups --query "AutoScalingGroups[*].AutoScalingGroupName" --output text)
if [ "$ASGNAMES" != "" ]
  then
    echo "Found AutoScalingGroups: $ASGNAMES..."
    for ASGNAME in $ASGNAMES; do
      echo "Processing Auto Scaling Group: $ASGNAME"

      aws autoscaling update-auto-scaling-group \
        --auto-scaling-group-name $ASGNAME \
        --min-size 0

      aws autoscaling update-auto-scaling-group \
      --auto-scaling-group-name $ASGNAME \
      --desired-capacity 0
  
     if [ "$INSTANCEIDS" != "" ]
       then
         # Trying a trick here to use the ec2 terminate-instance waiter to let the autoscaling group wind down the instances
         echo "Waiting for all instances to be terminated..."
         aws ec2 wait instance-terminated --instance-ids $INSTANCEIDS
         echo "All instances terminated..."
    else
      echo "No instances to wait for termination..."
      # end of internal if to check number of instances
    fi
     
    done
else
  echo "No AutoScalingGroups Detected. Perhaps check if your create-env.sh script ran properly?"
# End of ASG discovery and delete phase
fi

echo "Finding TARGETARN..."
# https://awscli.amazonaws.com/v2/documentation/api/2.0.34/reference/elbv2/describe-target-groups.html
TARGETARN=$(aws elbv2 describe-target-groups --query "TargetGroups[*].TargetGroupArn")
if [ "$TARGETARN" != "" ]
  then
    echo "Found TargetARN: $TARGETARN..."
  else
    echo "Could not find any TargetARN. Perhaps check if the create-env.sh ran properly?"
# End of TargetARN discovery
fi

if [ "$INSTANCEIDS" != "" ]
  then
    echo "\$INSTANCEIDS to be deregistered with the target group..."
    # https://awscli.amazonaws.com/v2/documentation/api/2.0.34/reference/elbv2/register-targets.html
    # Assignes the value of $EC2IDS and places each element (seperated by a space) into an array element
    INSTANCEIDSARRAY=($INSTANCEIDS)
    for INSTANCEID in ${INSTANCEIDSARRAY[@]};
      do
      echo "Deregistering target $INSTANCEID..."
      aws elbv2 deregister-targets --target-group-arn $TARGETARN --targets Id=$INSTANCEID
      echo "Waiting for target $INSTANCEID to be deregistered..."
      aws elbv2 wait target-deregistered --target-group-arn $TARGETARN --targets Id=$INSTANCEID
      done
  else
    echo 'There are no running or pending values in $INSTANCEIDS to wait for...'
fi 

echo "Looking up ELB ARN..."
# https://awscli.amazonaws.com/v2/documentation/api/2.0.34/reference/elbv2/describe-load-balancers.html
ELBARN=$(aws elbv2 describe-load-balancers --query='LoadBalancers[*].LoadBalancerArn')
echo $ELBARN

# Collect ListenerARN
# https://awscli.amazonaws.com/v2/documentation/api/2.0.34/reference/elbv2/describe-listeners.html
 # Assignes the value of $EC2IDS and places each element (seperated by a space) into an array element
    ELBARNSARRAY=($ELBARN)
    for ELB in ${ELBARNSARRAY[@]};
      do
        echo "Deleting Listener..."
        LISTENERARN=$(aws elbv2 describe-listeners --load-balancer-arn $ELB --query='Listeners[*].ListenerArn')
        aws elbv2 delete-listener --listener-arn $LISTENERARN
        echo "Listener deleted..."
      done


if [ "$TARGETARN" = "" ];
  then  
  echo "No Target Groups to delete..."
else
  echo "Deleting target group $TARGETARN..."
  # Assignes the value of $EC2IDS and places each element (seperated by a space) into an array element
  TARGETARNSARRAY=($TARGETARN)
    for TGARN in ${TARGETARNSARRAY[@]};
      do
        # https://awscli.amazonaws.com/v2/documentation/api/2.0.34/reference/elbv2/delete-target-group.html
        aws elbv2 delete-target-group --target-group-arn $TGARN
      done
fi

if [ "$ELBARN" = "" ];
  then
  echo "No ELBs to delete..."
else
  echo "Issuing Command to delete Load Balancer..."
  # https://awscli.amazonaws.com/v2/documentation/api/2.0.34/reference/elbv2/delete-load-balancer.html
  aws elbv2 delete-load-balancer --load-balancer-arn $ELBARN
  echo "Load Balancer delete command has been issued..."

  echo "Waiting for ELB: $ELBARN to be deleted..."
  # https://awscli.amazonaws.com/v2/documentation/api/2.0.34/reference/elbv2/wait/load-balancers-deleted.html#examples
  aws elbv2 wait load-balancers-deleted --load-balancer-arns $ELBARN
  echo "ELB: $ELBARN deleted..." 
fi

echo 'Finding autoscaling groups for deletion...'
# https://awscli.amazonaws.com/v2/documentation/api/latest/reference/autoscaling/delete-auto-scaling-group.html
ASGNAMES=$(aws autoscaling describe-auto-scaling-groups --query "AutoScalingGroups[*].AutoScalingGroupName")
if [ "$ASGNAMES" = "" ];
then
  echo "No Autoscaling Groups found..."
else
  echo "Autoscaling Groups: $ASGNAMES found..."
  ASGNAMESARRAY=($ASGNAMES)
    for ASGNAME in ${ASGNAMESARRAY[@]};
      do
      echo "Deleting $ASGNAME..."
      aws autoscaling delete-auto-scaling-group --auto-scaling-group-name $ASGNAME
      echo "Deleted $ASGNAME..."
      done
# End of if for checking on ASGs
fi

echo 'Finding lauch-templates...'
LAUNCHTEMPLATEIDS=$(aws ec2 describe-launch-templates --query 'LaunchTemplates[].LaunchTemplateName' --output text)

if [ "$LAUNCHTEMPLATEIDS" != "" ]
  then
    echo "Found launch-tempate: $LAUNCHTEMPLATEIDS..."
    for LAUNCHTEMPLATEID in $LAUNCHTEMPLATEIDS; do
      echo "Deleting launch-template: $LAUNCHTEMPID"
      aws ec2 delete-launch-template --launch-template-name "$LAUNCHTEMPLATEID"
    done
else
   echo "No launch-templates found. Perhpas you forget to run the create-env.sh script?"
# end of if for launchtemplateids
fi 

# Query for bucket names, delete objects then buckets
MYS3BUCKETS=$(aws s3api list-buckets --query "Buckets[*].Name")
MYS3BUCKETS_ARRAY=($MYS3BUCKETS)

#check for if list of buckets is non-zero (populated)
if [ -n "$MYS3BUCKETS" ]
  then 
    echo "Looping through array of buckets to create array of objects..."
    for j in "${MYS3BUCKETS_ARRAY[@]}"
    do
    MYKEYS=$(aws s3api list-objects-v2 --bucket $j --query 'Contents[*].Key')
    MYKEYS_ARRAY=($MYKEYS)
    echo "End of looping through array of buckets..."

    echo "Looping through array of objects to delete them..."
      for k in "${MYKEYS_ARRAY[@]}"
      do
      echo "Deleting object $k in bucket $j..."
      aws s3api delete-object --bucket $j --key $k
      aws s3api wait object-not-exists --bucket $j --key $k
      echo "Deleted object $k in bucket $j..."
      done
    done

    for l in "${MYS3BUCKETS_ARRAY[@]}"
    do
    echo "Deleting bucket $l..."
    aws s3api delete-bucket --bucket $l --region us-east-1
    aws s3api wait bucket-not-exists --bucket $l
    echo "Deleted bucket $l..."
    done
  else  
    echo "There seems to be no buckets present -- did you run create-env.sh?"
# end of s3 deletion block
fi 

# https://awscli.amazonaws.com/v2/documentation/api/latest/reference/rds/describe-db-instances.html
# Collect all database instance names into an array
echo "********************************************************************"
echo "Collecting RDs instance IDs into an array..."
MYDBINSTANCE=$(aws rds describe-db-instances --query "DBInstances[*].DBInstanceIdentifier" )

if [ "$MYDBINSTANCE" == "" ]
then
  echo "There are no RDS Instances running to delete..."
else
    MYDBINSTANCE_ARRAY=($MYDBINSTANCE)
    echo "Collected RDs instance IDs into an array..."
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
echo "Final Assessment ITMO-444 resource deletion finished..."
# End of main if
fi