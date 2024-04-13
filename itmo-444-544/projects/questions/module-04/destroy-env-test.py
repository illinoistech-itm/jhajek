import boto3
import json
import requests
import hashlib
import sys
import datetime
import os

# Assignment grand total
grandtotal = 0
totalPoints = 6
assessmentName = "module-4-destroy-assessment"

# Documentation Links
# https://boto3.amazonaws.com/v1/documentation/api/latest/reference/services/ec2.html
# https://boto3.amazonaws.com/v1/documentation/api/latest/reference/services/elbv2.html
# https://boto3.amazonaws.com/v1/documentation/api/latest/reference/services/autoscaling.html

clientec2 = boto3.client('ec2')
clientelbv2 = boto3.client('elbv2')
clientasg = boto3.client('autoscaling')

# https://boto3.amazonaws.com/v1/documentation/api/latest/reference/services/ec2/client/describe_instances.html
response = clientec2.describe_instances(

) # End of function

# https://boto3.amazonaws.com/v1/documentation/api/latest/reference/services/elbv2/client/describe_load_balancers.html
responseELB = clientelbv2.describe_load_balancers()

# https://boto3.amazonaws.com/v1/documentation/api/latest/reference/services/elbv2/client/describe_target_groups.html
responseTG = clientelbv2.describe_target_groups()

# https://boto3.amazonaws.com/v1/documentation/api/latest/reference/services/autoscaling/client/describe_auto_scaling_groups.html
responseasg = clientasg.describe_auto_scaling_groups()

# https://boto3.amazonaws.com/v1/documentation/api/latest/reference/services/autoscaling/client/describe_auto_scaling_instances.html
responseasgi = clientasg.describe_auto_scaling_instances()

# https://boto3.amazonaws.com/v1/documentation/api/latest/reference/services/ec2/client/describe_launch_templates.html
responselt = clientec2.describe_launch_templates()

print("Begin tests for destroy-env.sh module 4...")
destroyTestResults = []
##############################################################################
# Check to see if no Target Groups are present
##############################################################################
print('*' * 79)
print("Testing to make sure that there are no Target Groups present...")
checkOneTargetGroupPresent = False
if len(responseTG['TargetGroups']) > 0:
  print("Expecting 0 target groups, received " + str(len(responseTG['TargetGroups'])) + "...")
  print("Perhaps double check that your destroy-env.sh scripts ran correctly or that your create-env.sh ran without error...")
else:
  print("Expecting 0 target groups and received " + str(len(responseTG['TargetGroups'])) + " target groups...")
  grandtotal += 1

print('*' * 79)
print("\r")
##############################################################################
# Check to see no Load Balancers are present
##############################################################################
print('*' * 79)
print("Testing to make sure that 0 Load Balancers are present...")
checkOneLoadBalancerPresent = False
if len(responseELB['LoadBalancers']) > 0:
  print("Expecting 0 Load-Balancers, received " + str(len(responseELB['LoadBalancers'])) + "load-balancers...")
  print("Perhaps double check that your destroy-env.sh script ran correctly or that your create-env.sh ran without error...")
else:
  checkOneLoadBalancerPresent = True
  print("Expecting 0 load-balancers and received " + str(len(responseELB['LoadBalancers'])) + "load balancers...")
  grandtotal += 1

print('*' * 79)
print("\r")
##############################################################################
# Check to see if Autoscaling Group has been deleted
##############################################################################
print('*' * 79)
print("Testing to make sure that 0 Autoscaling Groups are present...")
healthy = 0
# Loop through response asgi  check N for instance healthy
if len(responseasgi['AutoScalingInstances']) == 0:
  print("Expecting 0 Autoscaling groups and received " + str(len(responseasgi['AutoScalingInstances'])) + " autoscaling groups...")
  grandtotal += 1
else:
  print("Expecting 0 Autoscaling groups and received " + str(len(responseasgi['AutoScalingInstances'])) + " autoscaling groups...")
  print("Something has happened in that your still have Autoscaling groups running. Perhaps take a look at your command: bash ./destroy-env.sh and its output...")

print('*' * 79)
print("\r")
##############################################################################
# Check to make that the instances launched are all in a non-running state
# instance-state-name - The state of the instance ( pending | running | shutting-down | terminated | stopping | stopped
##############################################################################
print('*' * 79)
print("Testing for the correct number of EC2 instances being terminated and not in a RUNNING state...")
try:
  if len(response['Reservations'][0]['Instances']) == 0:
    print("Beginning tests...")
except IndexError:  
  sys.exit("No EC2 instances are listed or available - did you mean to run this destroy test? ")
  
for n in range(0,len(response['Reservations'][0]['Instances'])):
  if response['Reservations'][0]['Instances'][n]['State']['Name'] not in ['pending','shutting-down','terminated','stopping','stopped']:
    print("EC2 instance " + str(response['Reservations'][0]['Instances'][n]['InstanceId']) + ", has an incorrect state of: " + str(response['Reservations'][0]['Instances'][n]['State']['Name']) + ".")
    print("Make sure in your destroy-env.sh your are passing the proper Instance IDs to the aws ec2 terminate-instances command")
    destroyTestResults.append(False)
  else:
    print("EC2 instance " + str(response['Reservations'][0]['Instances'][n]['InstanceId']) + ", has a correct state of: " + str(response['Reservations'][0]['Instances'][n]['State']['Name']) + ".")
    destroyTestResults.append(True)

print('*' * 79)
print("\r")
##############################################################################
# Check to see if Launch Template deleted
##############################################################################
print('*' * 79)
print("Testing to see if there are no Launch Templates present...")

if len(responselt['LaunchTemplates']) == 0:
  print("Expecting 0 Launch Templates and received " + str(len(responselt['LaunchTemplates'])))
  grandtotal +=1
else:
  print("Expecting 0 Launch Templates and received " + str(len(responselt['LaunchTemplates'])) + " launch templates...")
  print("Perhaps check to make any/all previously created Autoscaling groups were properly deleted by the command: bash ./destroy-env.sh command...")

print('*' * 79)
print("\r")
##############################################################################
# Check to see config.json has been deleted
##############################################################################
print('*' * 79)
print("Checking to see if the config.json file has been deleted...")

if os.path.exists('./config.json'):
  print("The ./config.json file still exists, perhaps check your command: bash ./destroy-env.sh and make sure that the file is being deleted...")
else:
  print("The ./config.json file does not exist and has been deleted...")
  grandtotal += 1

print('*' * 79)
print("\r")
##############################################################################
# Print out the grandtotal and the grade values to result.txt
##############################################################################
print('*' * 79)
if False in destroyTestResults:
  print("Your result is: " + str(grandtotal) + " out of " + str(totalPoints) + " points. You can retry any items that need adjustment and retest.")
else:
  grandtotal += 1
  print("Your result is: " + str(grandtotal) + " out of " + str(totalPoints) + " points. You can retry any items that need adjustment and retest.")  
  

# Write results to a text file for import to the grade system
# https://www.geeksforgeeks.org/sha-in-python/
f = open('destroy-env-module-04-results.txt', 'w', encoding="utf-8")

# Gather sha256 of module-name and grandtotal
# https://stackoverflow.com/questions/70498432/how-to-hash-a-string-in-python
# Create datetime timestamp
dt='{:%Y%m%d%H%M%S}'.format(datetime.datetime.now())
resultToHash=(assessmentName + str(grandtotal) + dt)
h = hashlib.new('sha256')
h.update(resultToHash.encode())

resultsdict = {
  'Name': assessmentName,
  'gtotal' : grandtotal/totalPoints,
  'datetime': dt,
  'sha': h.hexdigest() 
}

#listToHash=[assessmentName,grandtotal,dt,h.hexdigest()]
print("Writing assessment grade to text file.")
json.dump(resultsdict,f)
print("Write successful! Ready to submit your Assessment.")
print("You should now see a destroy-env-module-04-results.txt file has been generated.")
f.close
print('*' * 79)