# Module 03 Autograder
import boto3
import json
import requests
import hashlib
import sys
import datetime
import time
from tqdm import tqdm

# Create variables to check for correct numbers of elements
grandTotal = 0
totalPoints = 9
tag = "module-03"
correctNumberOfVpcs = 1
correctNumberOfSgs = 1
correctNumberOfEc2Instances = 3 # this is one that you need to add to the terraform - a count variable of 3
correctNumberOfIgs = 1
correctNumberOfRouteTables = 1
correctNumberOfSubnets = 3
correctNumberOfDhcpOptions = 1
CIDRBLOCK = "10.0.0.0/16"

# Function to print out current points progress
def currentPoints():
  print("Current Points: " + str(grandTotal) + " out of " + str(totalPoints) + ".")

# Documentation Links
# https://boto3.amazonaws.com/v1/documentation/api/latest/reference/services/ec2.html
# https://boto3.amazonaws.com/v1/documentation/api/latest/reference/services/elbv2.html
# https://boto3.amazonaws.com/v1/documentation/api/latest/reference/services/autoscaling.html
# https://boto3.amazonaws.com/v1/documentation/api/latest/reference/services/s3.html
# https://boto3.amazonaws.com/v1/documentation/api/latest/reference/services/rds.html

##############################################################################
# Nine tasks to cover
##############################################################################
# VPC tagged
# Security group tagged
# three EC2 instances tagged
# HTTP check works 
# Internet gateway tagged 
# Route table tagged
# 3 subnets tagged
# DHCP options tagged
# Check to make sure 1 route table is attached to IG

# Instantiate all AWS Libraries

clientEc2 = boto3.client('ec2')

# https://boto3.amazonaws.com/v1/documentation/api/latest/reference/services/ec2/client/describe_vpcs.html

responseVpcs = clientEc2.describe_vpcs(
    Filters=[
        {
            'Name': 'tag:Name',
            'Values': [
                tag,
            ]
        },
    ],
)

responseRouteTables = clientEc2.describe_route_tables(
    Filters=[
        {
            'Name': 'tag:Name',
            'Values': [
            tag,
            ]
        },
    ],
)

# https://boto3.amazonaws.com/v1/documentation/api/latest/reference/services/ec2/client/describe_dhcp_options.html

responseDHCP = clientEc2.describe_dhcp_options(
    Filters=[
        {
            'Name': 'tag:Name',
            'Values': [
            tag,
            ]
        },
    ],
)

# https://boto3.amazonaws.com/v1/documentation/api/latest/reference/services/ec2/client/describe_security_groups.html

responseSecurityGroups = clientEc2.describe_security_groups(
    Filters=[
        {
            'Name': 'tag:Name',
            'Values': [
                tag,
            ]
        },
    ],
)

# https://boto3.amazonaws.com/v1/documentation/api/latest/reference/services/ec2/client/describe_internet_gateways.html

responseIG = clientEc2.describe_internet_gateways(
  Filters=[
        {
            'Name': 'tag:Name',
            'Values': [
                tag,
            ]
        },
    ],
)

# https://boto3.amazonaws.com/v1/documentation/api/latest/reference/services/ec2/client/describe_route_tables.html
# https://boto3.amazonaws.com/v1/documentation/api/latest/reference/services/ec2/client/describe_subnets.html
responseSubnets = clientEc2.describe_subnets(
  Filters=[
        {
            'Name': 'tag:Name',
            'Values': [
                tag,
            ]
        },
    ],
)

# https://boto3.amazonaws.com/v1/documentation/api/latest/reference/services/ec2/client/describe_route_tables.html
responseRT = clientEc2.describe_route_tables(
  Filters=[
        {
            'Name': 'tag:Name',
            'Values': [
                tag,
            ]
        },
    ],
)

# https://boto3.amazonaws.com/v1/documentation/api/latest/reference/services/ec2/client/describe_dhcp_options.html
responseDhcpOptions = clientEc2.describe_dhcp_options(
  Filters=[
        {
            'Name': 'tag:Name',
            'Values': [
                tag,
            ]
        },
    ],
)

# https://boto3.amazonaws.com/v1/documentation/api/latest/reference/services/ec2/client/describe_instances.html

responseEc2 = clientEc2.describe_instances(
 Filters=[
        {
            'Name': 'tag:Name',
            'Values': [
                tag,
            ]
        },
    ],
)

# https://boto3.amazonaws.com/v1/documentation/api/latest/reference/services/elbv2/client/describe_load_balancers.html

# https://boto3.amazonaws.com/v1/documentation/api/latest/reference/services/elbv2/client/describe_target_groups.html

# https://boto3.amazonaws.com/v1/documentation/api/latest/reference/services/autoscaling/client/describe_auto_scaling_groups.html

print("\r")
##############################################################################
# Testing number of VPCs and that they have the correct tag
##############################################################################
print('*' * 79)
print("Testing the correct number of VPCs and that they are tagged: " + tag + "...")

if len(responseVpcs['Vpcs']) == correctNumberOfVpcs and responseVpcs['Vpcs'][0]['Tags'][0]['Value'] == tag:
  print("Well done! You have the correct number of VPCs: " + str(correctNumberOfVpcs) + " ...")
  print("And your VPC was tagged: " + tag + "...")
  grandTotal += 1
  currentPoints()
else:
  print("You have an incorrect number of VPCs, you have: " + str(len(responseVpcs['Vpcs'])) + "...")
  print("Perhaps double check that you have run the terraform apply command...")
  print("Double check your terraform.tfvars and the tag variable is set correctly to the value " + tag + "...")
  currentPoints()

print('*' * 79)
print("\r")
##############################################################################
# Testing the number of Security Groups and that they have the correct tag...
##############################################################################
print('*' * 79)
print("Testing the number of Security Groups and that they are tagged: " + tag + "...")

if len(responseSecurityGroups['SecurityGroups']) == correctNumberOfSgs and responseSecurityGroups['SecurityGroups'][0]['Tags'][0]['Value'] == tag:
  print("Well done! You have the correct number of Security Groups: " + str(correctNumberOfSgs) + " ...")
  print("And your Security Groups was tagged: " + tag + "...")
  grandTotal += 1
  currentPoints()
else:
  print("You have an incorrect number of Security Groups, you have: " + str(len(responseSecurityGroups['SecurityGroups'])) + "...")
  print("Perhaps double check that you have run the terraform apply command...")
  print("Double check your terraform.tfvars and the tag variable is set correctly to the value " + tag + "...")
  currentPoints()

print('*' * 79)
print("\r")
##############################################################################
# Testing for three Ec2 instances that are tagged...
##############################################################################
print('*' * 79)
print("Testing three EC2 instances that all have the tag of: " + tag + "...")

if len(responseEc2['Reservations'][0]['Instances']) == correctNumberOfEc2Instances:
  print("Well done! You have the correct number of Ec2 Instances: " + str(correctNumberOfEc2Instances) + " ...")
  print("And your Ec2 Instances were tagged: " + tag + "...")
  grandTotal += 1
  currentPoints()
else:
  print("You have an incorrect number of Ec2 Instances, you have: " + str(len(responseEc2['Reservations'][0]['Instances'])) + "...")
  print("Perhaps double check that you have run the terraform apply command...")
  print("Double check your terraform.tfvars and the tag variable is set correctly to the value " + tag + "...")
  currentPoints()

print('*' * 79)
print("\r")
##############################################################################
# Testing to see if EC2 instances response with an HTTP 200 (OK)
##############################################################################
print('*' * 79)
print("Testing to see if EC2 instances response with an HTTP 200 (OK)...")

if len(responseEc2['Reservations'][0]['Instances']) >= 1:
  print("There are 1 or more EC2 instances present...")
  print("Continuing with HTTP 200 (OK) check...")
  # take 30 seconds to print out a little progress bar...
  # https://pypi.org/project/tqdm
  for i in tqdm(range(30)):
    time.sleep(1)

  checkHttpReturnStatusMismatch = False
  print("Testing: http://" + responseEc2['Reservations'][0]['Instances'][0]['NetworkInterfaces'][0]['Association']['PublicDnsName'] + "...")
  try:
    res=requests.get("http://" + responseEc2['Reservations'][0]['Instances'][0]['NetworkInterfaces'][0]['Association']['PublicDnsName'])
    if res.status_code == 200:
      print("Successful request of the index.html file from: " + "http://" + responseEc2['Reservations'][0]['Instances'][0]['NetworkInterfaces'][0]['Association']['PublicDnsName'])
    else:
      checkHttpReturnStatusMismatch = True
      print("Incorrect http response code: " + str(res.status_code) + " from: " + "http://" + responseEc2['Reservations'][0]['Instances'][0]['NetworkInterfaces'][0]['Association']['PublicDnsName'])
  except requests.exceptions.ConnectionError as errc:
    print("Error connecting:",errc)
    checkHttpReturnStatusMismatch = True
    print("No response code returned... not able to connect to: http://" + responseEc2['Reservations'][0]['Instances'][0]['NetworkInterfaces'][0]['Association']['PublicDnsName'])
    sys.exit("Perhaps wait a minute or two for all your AWS resources to deploy...")

  if checkHttpReturnStatusMismatch == False:
    print("Correct status code returned...")
    grandTotal += 1
    currentPoints()
  else:
    print("Incorrect status code received...")
    print("Perhaps double check the content of the --user-file in your main.tf file...")

else:
  print("There are less than 1 EC2 instance present, cannot perform HTTP 200 (OK) check...")
  currentPoints()

print('*' * 79)
print("\r")
##############################################################################
# Check to see if Internet Gateway created and tagged
##############################################################################
print('*' * 79)
print("Testing to see if the Internet Gateway was created and Tagged: " + tag + "... ")

if len(responseIG['InternetGateways']) != correctNumberOfIgs:
  print(str(correctNumberOfIgs) + " Internet Gateway tagged with " + tag + " required...")
  print(str(len(responseIG['InternetGateways'])) + " Internet Gateway tagged with " + tag + " found." )
  print("Double check the terraform.tfvars file to make sure you have the aws_internet_gateway function...")
  print("Double check that you have executed the terraform destroy command from a previous exercise...")
  currentPoints()
else:
  print("Internet Gateway ID: " + str(responseIG['InternetGateways'][0]['InternetGatewayId']))
  print(str(correctNumberOfIgs) + " Internet Gateway tagged with " + tag + " required...")
  print(str(len(responseIG['InternetGateways'])) + " Internet Gateway tagged with " + tag + " found." )
  grandTotal += 1
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
  grandTotal += 1
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

  grandTotal += 1
  currentPoints()

print('*' * 79)
print("\r")
##############################################################################
# Check to see if DHCP Options created and Tagged
##############################################################################
print('*' * 79)
print("Testing to see if the DHCP Options were set and properly tagged with " + tag + "...")

if len(responseDHCP['DhcpOptions']) != correctNumberOfDhcpOptions:
  print(str(responseDHCP['DhcpOptions']) + " DHCP Option tagged with " + tag + " required...")
  print(str(len(responseDHCP['DhcpOptions'])) + " DHCP Option tagged with " + tag + " found." )
  print("Double check the terraform.tfvars file to make sure you have the aws_route_table function...")
  print("Double check that you have executed the terraform destroy command from a previous exercise...")
  currentPoints()
else:
  print("DHCP Options ID: " + responseDHCP['DhcpOptions'][0]['DhcpOptionsId'])
  print(str(len(responseDHCP['DhcpOptions'])) + " DHCP Options tagged with " + tag + " required...")
  print(str(len(responseDHCP['DhcpOptions'])) + " DHCP Options tagged with " + tag + " found." )
  grandTotal += 1
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
    if responseRT['RouteTables'][0]['Routes'][0]['DestinationCidrBlock'] == CIDRBLOCK and responseRT['RouteTables'][0]['Routes'][1]['DestinationCidrBlock'] == "0.0.0.0/0" and responseRT['RouteTables'][0]['Routes'][1]['GatewayId'] == responseIG['InternetGateways'][0]['InternetGatewayId']:
      print("Your Route Tables Gateways match the required values and tag: " + tag + "...")
      print("Destination CIDR Block: " + str(responseRT['RouteTables'][0]['Routes'][0]['DestinationCidrBlock']) + " | Destination Gateway: " + str(responseRT['RouteTables'][0]['Routes'][0]['GatewayId']))
      print("Destination CIDR Block: " + str(responseRT['RouteTables'][0]['Routes'][1]['DestinationCidrBlock']) + " | Destination Gateway: " + str(responseRT['RouteTables'][0]['Routes'][1]['GatewayId']))
      print("Internet Gateway tagged with " + tag + ": " + str(responseIG['InternetGateways'][0]['InternetGatewayId']))
      grandTotal += 1
      currentPoints()
  else:
    print("Double check the terraform.tfvars file to make sure you have the VPC cidr block set to 172.32.0.0/16...")
    print("Double check the terraform.tfvars file to make sure you have created Route Tables and attached an INternet Gateway to your Route Table..")
    print("Double check that you have executed the terraform destroy command from a previous exercise...")
    currentPoints()    

print('*' * 79)
print("\r")
##############################################################################
# Print out the grandtotal
##############################################################################
print('*' * 79)
print("Your result is: " + str(grandTotal) + " out of " + str(totalPoints) + " points.")
print("You can retry any items that need adjustment and retest...")

print('*' * 79)
print("\r")
