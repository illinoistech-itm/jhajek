#!/bin/bash
##############################################################################
# Module-04
# This assignment requires you to destroy the Cloud assets you created
# Remember to set you default output to text in the aws config command
##############################################################################
ltconfigfile="./config.json"

echo "Beginning destroy script for module-04 assessment..."

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

echo 'Finding autoscaling group names...'
ASGNAMES=
if [ "$ASGNAMES" != "" ]
  then
    echo "Found AutoScalingGroups: $ASGNAMES..."
    for ASGNAME in $ASGNAMES; do
      echo "Processing Auto Scaling Group: $ASGNAME"

      aws autoscaling update-auto-scaling-group \
        --auto-scaling-group-name $ASGNAME \
        --min-size 

      aws autoscaling update-auto-scaling-group \
      --auto-scaling-group-name $ASGNAME \
      --desired-capacity 
  
     if [ "$INSTANCEIDS" != "" ]
       then
         # Trying a trick here to use the ec2 terminate-instance waiter to let the autoscaling group wind down the instances
         echo "Waiting for all instances to be terminated..."
         aws ec2 wait instance-terminated 
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
TARGETARN=
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
ELBARN=
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
