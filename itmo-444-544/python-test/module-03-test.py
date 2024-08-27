# Module 03 Autograder
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
totalPoints = 10
assessmentName = "module-03-assessment"
correctNumberOfEC2Instances      = 3
correctNumberOfTargetGroups      = 1
correctNumberOfAutoScalingGroups = 1
correctNumberOfELBs              = 1
correctNumberOfEBS               = 3
correctNumberOfRDSInstances      = 1
correctNumberOfVpcs              = 2
correctNumberOfS3Buckets         = 2
correctNumberOfSGs               = 1
correctNumberOfInternetGateways  = 1
correctNumberOfRouteTables       = 1
correctNumberOfDHCPOptions       = 1
tag = "module-03"

# Function to print out current points progress
def currentPoints():
  print("Current Points: " + str(grandtotal) + " out of " + str(totalPoints) + ".")

# Documentation Links
# https://boto3.amazonaws.com/v1/documentation/api/latest/reference/services/ec2.html
# https://boto3.amazonaws.com/v1/documentation/api/latest/reference/services/elbv2.html
# https://boto3.amazonaws.com/v1/documentation/api/latest/reference/services/autoscaling.html
# https://boto3.amazonaws.com/v1/documentation/api/latest/reference/services/s3.html
# https://boto3.amazonaws.com/v1/documentation/api/latest/reference/services/rds.html

##############################################################################
# 10 tasks to cover
##############################################################################
# VPC tagged with module-03 +
# Security group tagged
# HTTP check works +
# three EC2 instances (tagged module-03) +
# Internet gateway tagged module-03
# Route table tagged module-03
# 3 subnets tagged module-03 
# DHCP options tagged module-03
# Count of S3 buckets is 2
# check to make sure 1 route table is attached to IG

clientec2 = boto3.client('ec2')
clientelbv2 = boto3.client('elbv2')
clientasg = boto3.client('autoscaling')
clients3 = boto3.client('s3')
clientrds = boto3.client('rds')

# https://boto3.amazonaws.com/v1/documentation/api/latest/reference/services/ec2/client/describe_vpcs.html

responseVPC = clientec2.describe_vpcs()

# https://boto3.amazonaws.com/v1/documentation/api/latest/reference/services/ec2/client/describe_subnets.html

responseSubnets = clientec2.describe_subnets(
    Filters=[
        {
            'Name': 'tag:Name',
            'Values': [
                'module-03',
            ]
        },
    ],
)

# https://boto3.amazonaws.com/v1/documentation/api/latest/reference/services/ec2/client/describe_route_tables.html

responseRouteTables = clientec2.describe_route_tables(
    Filters=[
        {
            'Name': 'tag:Name',
            'Values': [
            'module-03',
            ]
        },
    ],
)

# https://boto3.amazonaws.com/v1/documentation/api/latest/reference/services/ec2/client/describe_dhcp_options.html

responseDHCP = clientec2.describe_dhcp_options(
    Filters=[
        {
            'Name': 'tag:Name',
            'Values': [
            'module-03',
            ]
        },
    ],
)

# https://boto3.amazonaws.com/v1/documentation/api/latest/reference/services/ec2/client/describe_security_groups.html
responseSG = clientec2.describe_security_groups(
    Filters=[
        {
            'Name': 'tag:Name',
            'Values': [
                'module-03',
            ]
        },
    ],
)

# https://boto3.amazonaws.com/v1/documentation/api/latest/reference/services/ec2/client/describe_internet_gateways.html
responseIG = clientec2.describe_internet_gateways(
  Filters=[
        {
            'Name': 'tag:Name',
            'Values': [
                'module-03',
            ]
        },
    ],
)

# https://boto3.amazonaws.com/v1/documentation/api/latest/reference/services/ec2/client/describe_subnets.html
responseSubnets = clientec2.describe_subnets(
  Filters=[
        {
            'Name': 'tag:Name',
            'Values': [
                'module-03',
            ]
        },
    ],
)

# https://boto3.amazonaws.com/v1/documentation/api/latest/reference/services/ec2/client/describe_route_tables.html
responseRT = clientec2.describe_route_tables(
  Filters=[
        {
            'Name': 'tag:Name',
            'Values': [
                'module-03',
            ]
        },
    ],
)

# https://boto3.amazonaws.com/v1/documentation/api/latest/reference/services/ec2/client/describe_dhcp_options.html
responseDhcpOptions = clientec2.describe_dhcp_options(
  Filters=[
        {
            'Name': 'tag:Name',
            'Values': [
                'module-03',
            ]
        },
    ],
)

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

# https://boto3.amazonaws.com/v1/documentation/api/latest/reference/services/rds/client/describe_db_instances.html
responselistinstances = clientrds.describe_db_instances()

##############################################################################
print('*' * 79)
print("Begin tests for Module-03 Assessment...")
##############################################################################

##############################################################################
# Testing number of VPCs and if VPC is tagged correctly
##############################################################################
print('*' * 79)
print("Testing number of VPCs and to make sure the one just created is tagged: " + tag + "...")

if len(responseVPC['Vpcs']) == correctNumberOfVpcs and responseVPC['Vpcs'][1]['Tags'][0]['Value'] == tag:
  print("Well done! You have the correct number of VPCs: " + str(correctNumberOfVpcs) + "...")
  print("And your new VPC was tagged: " +  tag + "...")
  grandtotal += 1
  currentPoints()
else:
  print("You have an incorrect number of VPCs, you have: " + str(len(responseVPC['Vpcs'])) + "...")
  print("Perhaps double check that you issued the terraform destroy command from a previous lab...")
  print("Or you may have overlooked adding in the aws_vpc terraform function...")
  print("Double check your terraform.tfvars file to make sure you updated the tag-name to " + tag + "...") 
  currentPoints()

print('*' * 79)
print("\r")
##############################################################################
# Testing Tagging of new Security Group
##############################################################################
print('*' * 79)
print("Testing that the new security group has been created and tagged: " + tag + "...")

if len(responseSG['SecurityGroups']) == correctNumberOfSGs:
  print("Well done! You have the correct number of properly tagged security groups... ")
  print("And your new Security Groups are tagged: " +  tag + "...")
  grandtotal += 1
  currentPoints()
else:
  print("You have an incorrect number of Security Groups, you have: " + str(len(responseSG['SecurityGroups'])) + "...")
  print("Perhaps double check that you issued the terraform destroy command from a previous lab...")
  print("Or you may have overlooked adding in the aws_security_group terraform function...")
  print("Double check your terraform.tfvars file to make sure you updated the tag-name to " + tag + "...") 
  currentPoints()

print('*' * 79)
print("\r")
##############################################################################
# Check PublicDNS and HTTP return status to check if webserver was installed and working
##############################################################################
print('*' * 79)
print("Testing for the correct HTTP status (200) response from the webserver via the ELB URL...")

if len(responseELB['LoadBalancers']) != correctNumberOfELBs:
  print("In order to complete the HTTP check, you need an ELB running...")
  print("You have " + str(len(responseELB['LoadBalancers'])) + " loadbalancers...")
  print(str(correctNumberOfELBs) + " required...")
  print("You may want to check that you ran the terraform destroy command from previous sample code...")
  currentPoints()
else:
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
    currentPoints()
  else:
    print("Incorrect status code received. Perhaps go back and take a look at the --user-file value and the content of the install-env.sh script. Or check your security group to make sure the correct ports are open.")

print('*' * 79)
print("\r")
##############################################################################
# Check EC2 instances Tag values to be 'module-03' tag
##############################################################################
print('*' * 79)
print("Testing to make sure the running EC2 instances all have the tag of: " + tag + "...")
checkTagTypeMismatch = False

if len(responseasg['AutoScalingGroups']) != correctNumberOfAutoScalingGroups or len(responseEC2['Reservations']) != correctNumberOfEC2Instances:
  print ("You have " + str(len(responseasg['AutoScalingGroups'])) + " autoscaling groups, " + str(correctNumberOfAutoScalingGroups) + " required...")
  print ("You have " + str(len(responseEC2['Reservations'])) + " EC2 instances, " + str(correctNumberOfEC2Instances) + " required...")
  print("Double check the terraform.tfvars file to make sure you the tag-name value set properly...")
  print("Double check that you have executed the terraform destroy command from a previous exercise...")
  currentPoints()
  checkTagTypeMismatch == True
else:
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
    currentPoints()
  else:
    print("AutoScalingGroup: " + str(responseasg['AutoScalingGroups'][0]['AutoScalingGroupName'] + "...") + "contains the tag: " + tag)
    print("Go back to your terraform.tfvars file and take a look at the value for module-tag...")
    currentPoints()

print('*' * 79)
print("\r")
##############################################################################
# Check to see if Internet Gateway Created and Tagged
##############################################################################
print('*' * 79)
print("Testing to see if newly created and tagged Internet Gateway created... ")
if len(responseIG['InternetGateways']) != correctNumberOfInternetGateways:
  print(str(correctNumberOfInternetGateways) + " Internet Gateway tagged with " + tag + " required...")
  print(str(len(responseIG['InternetGateways'])) + " Internet Gateway tagged with " + tag + " found." )
  print("Double check the terraform.tfvars file to make sure you have the aws_internet_gateway function...")
  print("Double check that you have executed the terraform destroy command from a previous exercise...")
  currentPoints()
else:
  print("Internet Gateway ID: " + str(responseIG['InternetGateways'][0]['InternetGatewayId']))
  print(str(correctNumberOfInternetGateways) + " Internet Gateway tagged with " + tag + " required...")
  print(str(len(responseIG['InternetGateways'])) + " Internet Gateway tagged with " + tag + " found." )
  grandtotal += 1
  currentPoints()

print('*' * 79)
print("\r")
##############################################################################
# Check to see if Route Table Created and Tagged
##############################################################################
print('*' * 79)
print("Testing to see if the Route Table was created and Tagged... ")
if len(responseRouteTables['RouteTables']) != correctNumberOfRouteTables:
  print(str(correctNumberOfRouteTables) + " Route Tables tagged with " + tag + " required...")
  print(str(len(responseRouteTables['RouteTables'])) + " Route Tables tagged with " + tag + " found." )
  print("Double check the terraform.tfvars file to make sure you have the aws_route_table function...")
  print("Double check that you have executed the terraform destroy command from a previous exercise...")
  currentPoints()
else:
  print("Route Table ID: " + str(responseRouteTables['RouteTables'][0]['RouteTableId']))
  print(str(correctNumberOfRouteTables) + " Route Tables tagged with " + tag + " required...")
  print(str(len(responseRouteTables['RouteTables'])) + " Route Tables tagged with " + tag + " found." )
  grandtotal += 1
  currentPoints()

print('*' * 79)
print("\r")
##############################################################################
# Check to see 3 newly tagged subnets created
##############################################################################
print('*' * 79)
print("Testing to see if there are three subnets and they are tagged properly with " + tag + "...")
if len(responseSubnets['Subnets']) == 0:
  print(str(len(responseSubnets['Subnets'])) + " Subnets with tag: " + tag + " present...")
  print("Double check your main.tf subnet creation code, aws_subnets...")
  print("Double check that you have run the terraform destroy command to remove")
  print("entities from previous exercises...")
  currentPoints()
else:
  for n in range(0,len(responseSubnets['Subnets'])):
    print("Subnet ID: " + str(responseSubnets['Subnets'][n]['SubnetId']) + " found with tag of " + tag + "...")

  grandtotal += 1
  currentPoints()
print('*' * 79)
print("\r")
##############################################################################
# Check to see if DHCP Options created and Tagged
##############################################################################
print('*' * 79)
print("Testing to see if the DHCP Options were set and properly tagged with " + tag + "...")

if len(responseDHCP['DhcpOptions']) != correctNumberOfDHCPOptions:
  print(str(responseDHCP['DhcpOptions']) + " DHCP Option tagged with " + tag + " required...")
  print(str(len(responseDHCP['DhcpOptions'])) + " DHCP Option tagged with " + tag + " found." )
  print("Double check the terraform.tfvars file to make sure you have the aws_route_table function...")
  print("Double check that you have executed the terraform destroy command from a previous exercise...")
  currentPoints()
else:
  print("DHCP Options ID: " + responseDHCP['DhcpOptions'][0]['DhcpOptionsId'])
  print(str(len(responseDHCP['DhcpOptions'])) + " DHCP Options tagged with " + tag + " required...")
  print(str(len(responseDHCP['DhcpOptions'])) + " DHCP Options tagged with " + tag + " found." )
  grandtotal += 1
  currentPoints()
print('*' * 79)
print("\r")
##############################################################################
# Check to see if two S3 buckets are present
##############################################################################
print('*' * 79)
print("Testing to see if the correct number of S3 buckets is present... ")
if len(responseS3['Buckets']) == correctNumberOfS3Buckets:
  print("Correct number of S3 buckets present: " + str(correctNumberOfS3Buckets))
  for n in range(0,len(responseS3['Buckets'])):
    print("Bucket Name: " + responseS3['Buckets'][n]['Name'])
  grandtotal += 1
  currentPoints()
else:
  print("Incorrect number of S3 buckets detected: " + str(len(responseS3['Buckets'])))
  print("Check your main.tf file to see if you have logic for the Raw and Finished Buckets...")
  for n in range(0,len(responseS3['Buckets'])):
    print("Bucket Name: " + responseS3['Buckets'][n]['Name'])
  currentPoints()
print('*' * 79)
print("\r")
##############################################################################
# Check to see Route Table Attached has the correct VPC CIDR Block and Gateway
##############################################################################
print('*' * 79)
print("Testing to see if the properly tagged Route Table are attached to the properly tagged Internet Gateway...")
routeTableLengthIsCorrect = False

if len(responseRT['RouteTables']) != correctNumberOfRouteTables:
  print(str(len(responseRT['RouteTables'])) + " Route Table tagged with " + tag + " required...")
  print(str(len(responseRT['RouteTables'])) + " Route Table tagged with " + tag + " found." )
  print("Double check the terraform.tfvars file to make sure you have the aws_internet_gateway function...")
  print("Double check that you have executed the terraform destroy command from a previous exercise...")
  currentPoints()
else:
  if len(responseRT['RouteTables']) == correctNumberOfRouteTables:
    print("Route Table ID: " + str(responseRouteTables['RouteTables'][0]['RouteTableId']))
    print(str(correctNumberOfRouteTables) + " Route Tables tagged with " + tag + " required...")
    print(str(len(responseRouteTables['RouteTables'])) + " Route Tables tagged with " + tag + " found." )
    if responseRT['RouteTables'][0]['Routes'][0]['DestinationCidrBlock'] == "172.32.0.0/16" and responseRT['RouteTables'][0]['Routes'][1]['DestinationCidrBlock'] == "0.0.0.0/0" and responseRT['RouteTables'][0]['Routes'][1]['GatewayId'] == responseIG['InternetGateways'][0]['InternetGatewayId']:
      print("Your Route Tables Gateways match the required values and tag: " + tag + "...")
      print("Destination CIDR Block: " + str(responseRT['RouteTables'][0]['Routes'][0]['DestinationCidrBlock']) + " | Destination Gateway: " + str(responseRT['RouteTables'][0]['Routes'][0]['GatewayId']))
      print("Destination CIDR Block: " + str(responseRT['RouteTables'][0]['Routes'][1]['DestinationCidrBlock']) + " | Destination Gateway: " + str(responseRT['RouteTables'][0]['Routes'][1]['GatewayId']))
      print("Internet Gateway tagged with " + tag + ": " + str(responseIG['InternetGateways'][0]['InternetGatewayId']))
      grandtotal += 1
      currentPoints()
  else:
    print("Double check the terraform.tfvars file to make sure you have the VPC cidr block set to 172.32.0.0/16...")
    print("Double check the terraform.tfvars file to make sure you have created Route Tables and attached an INternet Gateway to your Route Table..")
    print("Double check that you have executed the terraform destroy command from a previous exercise...")
    currentPoints()    

print('*' * 79)
print("\r")
##############################################################################
# Print out the grandtotal and the grade values to result.txt
##############################################################################
print('*' * 79)
print("Your result is: " + str(grandtotal) + " out of " + str(totalPoints) + " points.")
print("You can retry any items that need adjustment and retest...")

# Write results to a text file for import to the grade system
# https://www.geeksforgeeks.org/sha-in-python/
f = open('module-03-results.txt', 'w', encoding="utf-8")

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

listToHash=[assessmentName,grandtotal,dt,h.hexdigest()]
print("Writing assessment grade to text file...")
json.dump(resultsdict,f)
print("Write successful! Ready to submit your Assessment.")
print("You should now see a module-03-results.txt file has been generated on your CLI.")
print("Submit this to Coursera as your deliverable...")
f.close
print('*' * 79)
print("\r")
