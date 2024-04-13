import boto3
import json
import requests
import hashlib
import sys
import datetime
import os.path
import time
from tqdm import tqdm

# Assignment grand total
grandtotal = 0
totalPoints = 9
assessmentName = "module-final-create-assessment"
correctNumberOfEC2Instances      = 3
correctNumberOfTargetGroups      = 1
correctNumberOfAutoScalingGroups = 1
correctNumberOfELBs              = 1
correctNumberOfEBS               = 3
correctNumberOfDynamoInstances   = 1
tag = "module-final-tag"

# Documentation Links
# https://boto3.amazonaws.com/v1/documentation/api/latest/reference/services/ec2.html
# https://boto3.amazonaws.com/v1/documentation/api/latest/reference/services/elbv2.html
# https://boto3.amazonaws.com/v1/documentation/api/latest/reference/services/autoscaling.html
# https://boto3.amazonaws.com/v1/documentation/api/latest/reference/services/s3.html
# Documentation Links
# https://boto3.amazonaws.com/v1/documentation/api/latest/reference/services/dynamodb.html

clientec2 = boto3.client('ec2')
clientelbv2 = boto3.client('elbv2')
clientasg = boto3.client('autoscaling')
clients3 = boto3.client('s3')
clientdynamo = boto3.client('dynamodb')

# https://boto3.amazonaws.com/v1/documentation/api/latest/reference/services/ec2/client/describe_instances.html
responseEC2 = clientec2.describe_instances(
 Filters=[
     {
         'Name': 'instance-state-name',
         'Values':['running']
     }
],
) # End of function

# https://boto3.amazonaws.com/v1/documentation/api/latest/reference/services/s3/client/list_buckets.html
# Get a Dict of all bucket names
responseS3 = clients3.list_buckets()

# https://boto3.amazonaws.com/v1/documentation/api/latest/reference/services/elbv2/client/describe_load_balancers.html
responseELB = clientelbv2.describe_load_balancers()

# https://boto3.amazonaws.com/v1/documentation/api/latest/reference/services/elbv2/client/describe_target_groups.html
responseTG = clientelbv2.describe_target_groups()

# https://boto3.amazonaws.com/v1/documentation/api/latest/reference/services/autoscaling/client/describe_auto_scaling_groups.html
responseasg = clientasg.describe_auto_scaling_groups()

# https://boto3.amazonaws.com/v1/documentation/api/latest/reference/services/autoscaling/client/describe_auto_scaling_instances.html
responseasgi = clientasg.describe_auto_scaling_instances()

# https://boto3.amazonaws.com/v1/documentation/api/latest/reference/services/autoscaling/client/describe_auto_scaling_groups.html
responseasg = clientasg.describe_auto_scaling_groups()

# https://boto3.amazonaws.com/v1/documentation/api/latest/reference/services/ec2/client/describe_launch_templates.html
responselt = clientec2.describe_launch_templates()

# https://boto3.amazonaws.com/v1/documentation/api/latest/reference/services/dynamodb/client/list_tables.html
responselisttables = clientdynamo.list_tables()

# https://boto3.amazonaws.com/v1/documentation/api/latest/reference/services/dynamodb.html
responsedynamo = clientdynamo.describe_table(
  TableName = responselisttables['TableNames'][0]
)
# https://boto3.amazonaws.com/v1/documentation/api/latest/reference/services/dynamodb/client/list_tags_of_resource.html
responsetablearn = clientdynamo.list_tags_of_resource(
   ResourceArn = responsedynamo['Table']['TableArn']
)

##############################################################################
print('*' * 79)
print("Begin tests for create-env.sh Final Assessment...")
##############################################################################

##############################################################################
# Check Tag values to be 'module-final-tag'
##############################################################################
print('*' * 79)
print("Testing to make sure the running EC2 instances all have the tag of: " + tag + "...")
checkTagTypeMismatch = False

#+ " has a tag of: " + responseEC2['Reservations'][0]['Instances'][n]['Tags'][0]['Value'])

if tag in str(responseasg['AutoScalingGroups'][0]['Tags']):
  print("AutoScalingGroup: " + str(responseasg['AutoScalingGroups'][0]['AutoScalingGroupName'] + "..."))
  for n in range(0,len(responseEC2['Reservations'][0]['Instances'])):
      print("Containing InstanceID of: " + responseEC2['Reservations'][0]['Instances'][n]['InstanceId']) 
  
  print("Contains the tag: " + tag + "...")
else:
  checkTagTypeMismatch = True

if checkTagTypeMismatch == False:
  print("Correct. All Ec2 Instances have the correct tag of: " + tag + "...")
  grandtotal += 1
else:
  print("AutoScalingGroup: " + str(responseasg['AutoScalingGroups'][0]['AutoScalingGroupName'] + "...") + "contains the tag: " + tag)
  print("Go back to your arguments.txt file and take a look at the value for module-tag in terraform.tfvars...")
  
print('*' * 79)
print("\r")
##############################################################################
# Check to see if 3 instances are of type t2.micro
##############################################################################
print('*' * 79)
print("Testing to make sure the running EC2 instances are all of type t2.micro...")
checkInstanceTypeMismatch = False
for n in range(0,len(responseEC2['Reservations'][0]['Instances'])):
  if responseEC2['Reservations'][0]['Instances'][n]['InstanceType'] == "t2.micro":
    print("InstanceID of: " + responseEC2['Reservations'][0]['Instances'][n]['InstanceId'] + " and of InstanceType: " + responseEC2['Reservations'][0]['Instances'][n]['InstanceType'])
  else:
    checkInstanceTypeMatch = True
    print("Incorrect Ec2 Instance Type of " + str(responseEC2['Reservations'][0]['Instances'][n]['InstanceType']) + " set.")

if checkInstanceTypeMismatch == False:
  print("Correct Ec2 Instance Type launched for all 3 EC2 instances.")
  grandtotal += 1
else:
  print("Incorrect Ec2 Instance Types launched. Perhaps go back and take a look at the value in the arguments.txt $1 and $2.")

print('*' * 79)
print("\r")
##############################################################################
# Check PublicDNS and HTTP return status to check if webserver was installed and working
##############################################################################
print('*' * 79)
print("Testing for the correct HTTP status (200) response from the webserver via the ELB URL...")
# https://pypi.org/project/tqdm/
for i in tqdm(range(30)):
  time.sleep(1)


checkHttpReturnStatusMismatch = False
print("http://" + responseELB['LoadBalancers'][0]['DNSName'])
try:
  res=requests.get("http://" + responseELB['LoadBalancers'][0]['DNSName'])
  if res.status_code == 200:
    print("Successful request of the index.html file from " + str(responseELB['LoadBalancers'][0]['DNSName']))
  else:
    checkHttpReturnStatusMismatch = True
    print("Incorrect http response code: " + str(res.status_code) + "from " + str(responseELB['LoadBalancers'][0]['DNSName']))
except requests.exceptions.ConnectionError as errc:
  print ("Error Connecting:",errc)
  checkHttpReturnStatusMismatch = True
  print("No response code returned - not able to connect: " + str(res.status_code) + "from " + str(responseELB['LoadBalancers'][0]['DNSName'])) 
  sys.exit("Perhaps wait 1-2 minutes to let the install-env.sh server to finish installing the Nginx server and get the service ready to except external connections? Rerun this test script.")

if checkHttpReturnStatusMismatch == False:
   print("Correct HTTP status code of 200, received for the Elastic Load Balancer URL...")
   grandtotal += 1
else:
   print("Incorrect status code received. Perhaps go back and take a look at the --user-file value and the content of the install-env.sh script. Or check your security group to make sure the correct ports are open.")

print('*' * 79)
print("\r")
##############################################################################
# Check to see if Target Group is present
##############################################################################
print('*' * 79)
print("Testing to make sure that 1 Target Group is present...")
checkOneTargetGroupPresent = False
if len(responseTG['TargetGroups']) > 1:
  print("Expecting 1 target group, received " + str(len(responseTG['TargetGroups'])) + "...")
  print("Perhaps double check that your destroy-env.sh scripts from previous assessments ran correctly or that your create-env.sh ran without error...")
else:
  checkOneTargetGroupPresent = True
  print("Expecting 1 target group and received 1 target group: ")
  print(str(responseTG['TargetGroups'][0]['TargetGroupArn']))
  grandtotal += 1

print('*' * 79)
print("\r")
##############################################################################
# Check to see Load Balancer is attached to Target Group
##############################################################################
print('*' * 79)
print("Testing to make sure that 1 Load Balancer is attached to the Target Group...")
checkOneTargetGroupPresent = False
if len(responseTG['TargetGroups'][0]['LoadBalancerArns']) == 0:
  print("Expecting 1 LoadBalancerArn attached to target group, received " + str(len(responseTG['TargetGroups'][0]['LoadBalancerArns'])) + "...")
  print("Perhaps double check that your destroy-env.sh scripts from previous assessments ran correctly or that your create-endv.sh ran without error to attach your target-group to your ELB...")
else:
  checkOneTargetGroupPresent = True
  print("Expecting 1 target group and received 1 load balancer arn attached to Target Group: ")
  print(str(responseTG['TargetGroups'][0]['LoadBalancerArns']))
  grandtotal += 1

print('*' * 79)
print("\r")
##############################################################################
# Check to make sure there is 1 AutoScalingGroup to make sure there are three
# healthy instances attached
##############################################################################
print('*' * 79)
healthy = 0
print("Testing to make sure there is 1 Autoscaling Group created and desired state is 3 instances...")
# Loop through response asgi  check N for instance healthy
if len(responseasgi['AutoScalingInstances']) == 3:
  for n in range(0,len(responseasgi['AutoScalingInstances'])):
    if responseasgi['AutoScalingInstances'][n]['HealthStatus'] == 'HEALTHY':
      print("Instance ID " + str(responseasgi['AutoScalingInstances'][n]['InstanceId']) + "with a target group health status of: " + str(responseasgi['AutoScalingInstances'][n]['HealthStatus']))
      healthy += 1
    else:
      print("Instance ID " + str(responseasgi['AutoScalingInstances'][n]['InstanceId']) + "with a target group health status of: " + str(responseasgi['AutoScalingInstances'][n]['HealthStatus']))
      print("Your instances are attached to the Autoscaling group, but not in the healthy status. Perhaps check if your Security Group has the correct open ports and or you have installed a webserver and it is running via the install-env.sh script...")
else:
  print("Expecting " + str(correctNumberOfEC2Instances) + " and received " + str(len(responseasgi['AutoScalingInstances'])) + " instances attached to the autoscaling group..." )
  print("Perhaps check your Autoscaling Group min,max, and desired numbers in your arguments.txt...")

if healthy == 3:
  grandtotal += 1

print('*' * 79)
print("\r")
##############################################################################
# Check to make sure the is one Launch Template created
##############################################################################
print('*' * 79)
print("Testing to make sure one launch template only has been created...")
if len(responselt['LaunchTemplates']) == 1:
  print("Expecting 1 LaunchTemplate and received 1 LaunchTemplate named: " + str(responselt['LaunchTemplates'][0]['LaunchTemplateName']))
  grandtotal +=1
else:
  print("Expecting 1 LaunchTemplate and 1 Autoscaling Group and received " + str(len(responselt['LaunchTemplates'])) + " launch templates...")
  print("Perhaps check to make any/all previously created Autoscaling groups were properly deleted by the command: bash ./destroy-env.sh command...")

print('*' * 79)
print("\r")

##############################################################################
# Check to see two Elastic Block Stores exist attached to each EC2 instance
##############################################################################
print('*' * 79)
print("Testing to make sure two Block Stores are attached to each Ec2 instance...")
count = 0

try:
  if len(responseEC2['Reservations'][0]['Instances']) == 0:
    print("Beginning tests...")
except IndexError:  
  sys.exit("No EC2 instances in the RUNNING STATE - check that you ran your create-env.sh or wait 30-60 seconds more to make sure your instances are in the running state.")

for n in range(0,len(responseEC2['Reservations'][0]['Instances'])):
  print("Checking number of EBS attached to InstanceID of: " + responseEC2['Reservations'][0]['Instances'][n]['InstanceId'])
  if len(responseEC2['Reservations'][0]['Instances'][n]['BlockDeviceMappings']) == correctNumberOfEBS:
    print("Correct number of EBS instances attached to InstanceID: " + str(responseEC2['Reservations'][0]['Instances'][n]['InstanceId']))
    for j in range(0,len(responseEC2['Reservations'][0]['Instances'][n]['BlockDeviceMappings'])):
      print("EBS Device name: " + str(responseEC2['Reservations'][0]['Instances'][n]['BlockDeviceMappings'][j]['DeviceName']))
      print("Volume-ID of: " + str(responseEC2['Reservations'][0]['Instances'][n]['BlockDeviceMappings'][j]['Ebs']['VolumeId']))
      count+=1
  else:
    print("Incorrect Number of Elastic Block Stores created per instance, expecting " + str(correctNumberOfEBS) + ", received " + str(len(responseEC2['Reservations'][0]['Instances'][n]['BlockDeviceMappings'])) + " instances...")

if count == 9:
  grandtotal+=1

print('*' * 79)
print("\r")
##############################################################################
# Check to make sure there is 1 DynamoDB Table Present
##############################################################################
print('*' * 79)
print("Testing for the existence of 1 DynamoDB table...")

if len(responselisttables['TableNames']) == correctNumberOfDynamoInstances:
  print("Way to go! 1 DynamoDB instance was required, and you have 1 created...")
  grandtotal +=1
  for n in range(0,len(responselisttables['TableNames'])):
    print("DynamoDB Table Identifier: " + str(responselisttables['TableNames']))

else:
  print("Something happened and you only have, " + str(len(responselisttables['TableNames'])) + "DynamoDB instance...")
  print("Perhaps double check the AWS console and check the status of your DynamoDB Table instances?")

print('*' * 79)
##############################################################################
# Check to make sure DynamoDB instances are tagged with the correct module tag: module-final-tag
##############################################################################
print('*' * 79)
print("Testing the tag values of the DynamoDB instances to match the correct module tag name...")
tagCorrect = False

if len(responselisttables['TableNames']) == correctNumberOfDynamoInstances:
  for n in range(0,len(responselisttables['TableNames'])):
    print("DynamoDB Identifier: " + str(responselisttables['TableNames']))
    if responsetablearn['Tags'][0]['Value'] == tag:
      print("Your DyanmoDB Instance is tagged: " + str(responsetablearn['Tags'][0]['Value']))
      tagCorrect = True
    else:
      tagCorrect = False
      print("Your tag value is: " + str(responsetablearn['Tags'][0]['Value']))
      print("Something happened and your tags are incorrect, perhaps go back and look at the terraform.tfvars...")
else:
  print("Something happened and you only have, " + str(len(responselisttables['TableNames'])) + " DynamoDB instances. Perhaps double check the AWS console and check the status of your DynamoDB instances?")

if tagCorrect:
  grandtotal +=1

print('*' * 79)
##############################################################################
# Print out the grandtotal and the grade values to result.txt
##############################################################################
print('*' * 79)
print("Your result is: " + str(grandtotal) + " out of " + str(totalPoints) + " points.")
print("You can retry any items that need adjustment and retest...")

# Write results to a text file for import to the grade system
# https://www.geeksforgeeks.org/sha-in-python/
f = open('create-env-module-final-results.txt', 'w', encoding="utf-8")

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
#print("Writing assessment grade to text file.")
#json.dump(resultsdict,f)
#print("Write successful! Ready to submit your Assessment.")
#print("You should now see a create-env-module-final-results.txt file has been generated.")
#f.close
print('*' * 79)