# Module 09 Autograder
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
assessmentName = "module-09-assessment"
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
tag = "module-09"

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
# Check that there is 1 VPC tagged
# Check that there is 1 Security Group tagged
# Check the HTTP check returns an HTTP 200 
# Check that there are 3 EC2 instances and they are tagged
# Check that there is 1 Internet gateway and it is tagged
# Check that there are 3 subnets and they are tagged
# Check that there is 1 Route table per tagged subnet
# Check that there is 1 DHCP options created and tagged
# Check that there is one Auto Scaling Group and that it is tagged
# Check to make sure 1 route table is attached to your IG

clientec2 = boto3.client('ec2')
clientelbv2 = boto3.client('elbv2')
clientasg = boto3.client('autoscaling')
clients3 = boto3.client('s3')
clientrds = boto3.client('rds')

# https://boto3.amazonaws.com/v1/documentation/api/latest/reference/services/ec2/client/describe_vpcs.html
# https://boto3.amazonaws.com/v1/documentation/api/latest/reference/services/ec2/client/describe_subnets.html
# https://boto3.amazonaws.com/v1/documentation/api/latest/reference/services/ec2/client/describe_route_tables.html
# https://boto3.amazonaws.com/v1/documentation/api/latest/reference/services/ec2/client/describe_dhcp_options.html
# https://boto3.amazonaws.com/v1/documentation/api/latest/reference/services/ec2/client/describe_security_groups.html
# https://boto3.amazonaws.com/v1/documentation/api/latest/reference/services/ec2/client/describe_internet_gateways.html
# https://boto3.amazonaws.com/v1/documentation/api/latest/reference/services/ec2/client/describe_subnets.html
# https://boto3.amazonaws.com/v1/documentation/api/latest/reference/services/ec2/client/describe_route_tables.html
# https://boto3.amazonaws.com/v1/documentation/api/latest/reference/services/ec2/client/describe_dhcp_options.html
# https://boto3.amazonaws.com/v1/documentation/api/latest/reference/services/ec2/client/describe_instances.html
# https://boto3.amazonaws.com/v1/documentation/api/latest/reference/services/s3/client/list_buckets.html
# https://boto3.amazonaws.com/v1/documentation/api/latest/reference/services/elbv2/client/describe_load_balancers.html
# https://boto3.amazonaws.com/v1/documentation/api/latest/reference/services/elbv2/client/describe_target_groups.html
# https://boto3.amazonaws.com/v1/documentation/api/latest/reference/services/autoscaling/client/describe_auto_scaling_groups.html
# https://boto3.amazonaws.com/v1/documentation/api/latest/reference/services/autoscaling/client/describe_auto_scaling_instances.html
# https://boto3.amazonaws.com/v1/documentation/api/latest/reference/services/autoscaling/client/describe_auto_scaling_groups.html
# https://boto3.amazonaws.com/v1/documentation/api/latest/reference/services/ec2/client/describe_launch_templates.html
# https://boto3.amazonaws.com/v1/documentation/api/latest/reference/services/rds/client/describe_db_instances.html

responseELB = clientelbv2.describe_load_balancers()

##############################################################################
print('*' * 79)
print("Begin tests for Module-09 Assessment...")
##############################################################################

##############################################################################
# Check that there is 1 VPC tagged
##############################################################################
print('*' * 79)
print("Testing number of VPCs and to make sure the one just created is tagged: " + tag + "...")

print('*' * 79)
print("\r")
##############################################################################
# Check that there is 1 Security Group tagged
##############################################################################
print('*' * 79)
print("Testing that the new security group has been created and tagged: " + tag + "...")

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
# Check that there are 3 EC2 instances and they are tagged
##############################################################################
print('*' * 79)
print("Testing to make sure the running EC2 instances all have the tag of: " + tag + "...")


print('*' * 79)
print("\r")
##############################################################################
# Check that there is 1 Internet gateway and it is tagged
##############################################################################
print('*' * 79)
print("Testing to see if newly created and tagged Internet Gateway created... ")

print('*' * 79)
print("\r")
##############################################################################
# Check that there are 3 subnets and they are tagged
##############################################################################
print('*' * 79)
print("Testing to see if the Route Table was created and Tagged... ")

print('*' * 79)
print("\r")
##############################################################################
# Check to see 3 newly tagged subnets created
##############################################################################
print('*' * 79)
print("Testing to see if there are three subnets and they are tagged properly with " + tag + "...")

print('*' * 79)
print("\r")
##############################################################################
# Check that there is 1 Route table per tagged subnet
##############################################################################
print('*' * 79)
print("Testing to see if the DHCP Options were set and properly tagged with " + tag + "...")


print('*' * 79)
print("\r")
##############################################################################
# Check that there is 1 DHCP options created and tagged
##############################################################################
print('*' * 79)
print("Testing to see if the correct number of S3 buckets is present... ")

print('*' * 79)
print("\r")
##############################################################################
# Check to make sure 1 route table is attached to your IG
##############################################################################
print('*' * 79)
print("Testing to see if the properly tagged Route Table are attached to the properly tagged Internet Gateway...")

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
f = open('module-09-results.txt', 'w', encoding="utf-8")

# Gather sha256 of module-name and grandtotal
# https://stackoverflow.com/questions/70498432/how-to-hash-a-string-in-python
# Create datetime timestamp
dt='{:%Y%m%d%H%M%S}'.format(datetime.datetime.now())
resultToHash=(assessmentName + str(grandtotal/totalPoints) + dt)
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
print("You should now see a module-09-results.txt file has been generated on your CLI.")
print("Submit this to Coursera as your deliverable...")
f.close
print('*' * 79)
print("\r")
