import boto3
import json
import requests
import hashlib
import sys
import datetime

# Assignment grand total
grandtotal = 0
totalPoints = 3
assessmentName = "module-3-destroy-assessment"

# Documentation Links
# https://boto3.amazonaws.com/v1/documentation/api/latest/reference/services/ec2.html

clientec2 = boto3.client('ec2')
clientelbv2 = boto3.client('elbv2')

# https://boto3.amazonaws.com/v1/documentation/api/latest/reference/services/ec2/client/describe_instances.html
response = clientec2.describe_instances(

) # End of function

# https://boto3.amazonaws.com/v1/documentation/api/latest/reference/services/elbv2/client/describe_load_balancers.html
responseELB = clientelbv2.describe_load_balancers()

# https://boto3.amazonaws.com/v1/documentation/api/latest/reference/services/elbv2/client/describe_target_groups.html
responseTG = clientelbv2.describe_target_groups()

print("Begin tests for destroy-env.sh module 3...")
destroyTestResults = []
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
f = open('destroy-env-module-03-results.txt', 'w', encoding="utf-8")

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
print("You should now see a destroy-env-module-03-results.txt file has been generated.")
f.close
print('*' * 79)