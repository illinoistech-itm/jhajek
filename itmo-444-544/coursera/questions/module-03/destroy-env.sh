#!/bin/bash
##############################################################################
# Module-03
# This assignment requires you to destroy the Cloud assets you created
# Remember to set you default output to text in the aws config command
##############################################################################

echo "Beginning destroy script for module-03 assessment..."

# Collect Instance IDs
# https://stackoverflow.com/questions/31744316/aws-cli-filter-or-logic
INSTANCEIDS=$(aws ec2 describe-instances --output=text --query 'Reservations[*].Instances[*].InstanceId' --filter "Name=instance-state-name,Values=running,pending")
echo "List of INSTANCEIDS to deregister..."
if [ "$INSTANCEIDS" == "" ];
  then
  echo "There are no INSTANCEIDS to echo..."
else
  echo $INSTANCEIDS
fi 

echo "Finding TARGETARN..."
# https://awscli.amazonaws.com/v2/documentation/api/2.0.34/reference/elbv2/describe-target-groups.html
TARGETARN=
echo $TARGETARN

if [ "$INSTANCEIDS" != "" ]
  then
    echo '$INSTANCEIDS to be deregistered with the target group...'
    # https://awscli.amazonaws.com/v2/documentation/api/2.0.34/reference/elbv2/register-targets.html
    # Assignes the value of $EC2IDS and places each element (seperated by a space) into an array element
    INSTANCEIDSARRAY=($INSTANCEIDS)
    for INSTANCEID in ${INSTANCEIDSARRAY[@]};
      do
      echo "Deregistering target $INSTANCEID..."
      aws elbv2 deregister-targets 
      echo "Waiting for target $INSTANCEID to be deregistered..."
      aws elbv2 wait target-deregistered
      done
  else
    echo 'There are no running or pending values in $INSTANCEIDS to wait for...'
fi 

#https://awscli.amazonaws.com/v2/documentation/api/latest/reference/ec2/wait/instance-running.html
echo "Now terminating the detached INSTANCEIDS..."
if [ "$INSTANCEIDS" != "" ]
  then
    aws ec2 terminate-instances
    echo "Waiting for all instances report state as TERMINATED..."
    aws ec2 wait instance-terminated
    echo "Finished destroying instances..."
  else
    echo 'There are no running values in $INSTANCEIDS to be terminated...'
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
  echo "Issuing Command to delete Load Balancer.."
  # https://awscli.amazonaws.com/v2/documentation/api/2.0.34/reference/elbv2/delete-load-balancer.html
  aws elbv2 delete-load-balancer 
  echo "Load Balancer delete command has been issued..."

  echo "Waiting for ELB to be deleted..."
  # https://awscli.amazonaws.com/v2/documentation/api/2.0.34/reference/elbv2/wait/load-balancers-deleted.html#examples
  aws elbv2 wait load-balancers-deleted
fi


