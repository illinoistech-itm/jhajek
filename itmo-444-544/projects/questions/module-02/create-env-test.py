import boto3
import json
import requests
import hashlib
import sys
import datetime
import time
from tqdm import tqdm

###############################################################################
# This file is used to assess the output of the create-env.sh file
# DO NOT MODIFY this file!!!!
# But you are welcome to inspect it
###############################################################################

# Assignment grand total
grandtotal = 0
totalPoints = 4
assessmentName = "module-2-assessment-create-script"
correctNumberOfEC2Instances = 3
tag = "module2-tag"

# Documentation Links
# https://boto3.amazonaws.com/v1/documentation/api/latest/reference/services/ec2.html

clientec2 = boto3.client('ec2')

# https://boto3.amazonaws.com/v1/documentation/api/latest/reference/services/ec2/client/describe_instances.html
response = clientec2.describe_instances(
 Filters=[
     {
         'Name': 'instance-state-name',
         'Values':['running']
     }
],
) # End of function

print("Begin tests for create-env.sh module 2...")

##############################################################################
# Check to make sure there are 3 instances of 'running' state
##############################################################################
print('*' * 79)
print("Testing for the correct number of EC2 instances launched and in the RUNNING state...")
try:
  if len(response['Reservations'][0]['Instances']) == 0:
    print("Beginning tests...")
except IndexError:  
  sys.exit("No EC2 instances in the RUNNING STATE - check that you ran your create-env.sh or wait 30-60 seconds more to make sure your instances are in the running state.")

if len(response['Reservations'][0]['Instances']) == correctNumberOfEC2Instances:
    print("Correct number of EC2 instances created, expecting " + str(correctNumberOfEC2Instances) + ", received " + str(len(response['Reservations'][0]['Instances'])) + ".")
    for n in range(0,len(response['Reservations'][0]['Instances'])):
      print("InstanceID of: " + response['Reservations'][0]['Instances'][n]['InstanceId'])
    grandtotal += 1
else:
    print("Incorrect Number of EC2 instances created, expecting " + str(correctNumberOfEC2Instances) + ", received " + str(len(response['Reservations'][0]['Instances'])) + ".")
    for n in range(0,len(response['Reservations'][0]['Instances'])):
      print("InstanceID of: " + response['Reservations'][0]['Instances'][n]['InstanceId'])

print('*' * 79)
print("\r")
##############################################################################
# Check Tag values to be 'module2-tag'
##############################################################################
print('*' * 79)
print("Testing to make sure the running EC2 instances all have the tag of " + tag + "...")
checkTagTypeMismatch = False
for n in range(0,len(response['Reservations'][0]['Instances'])):
  if response['Reservations'][0]['Instances'][n]['Tags'][0]['Value'] == tag:
    print("InstanceID of: " + response['Reservations'][0]['Instances'][n]['InstanceId'] + " has a tag of: " + response['Reservations'][0]['Instances'][n]['Tags'][0]['Value'])
  else:
     checkTagTypeMismatch = True
     print("Incorrect tag set for Ec2 Instance: " + response['Reservations'][0]['Instances'][n]['InstanceId'] + ". Tag of: " + str(response['Reservations'][0]['Instances'][n]['Tags'][0]['Value']) + " set...")

if checkTagTypeMismatch is False:
   print("Correct. All Ec2 Instances have the correct tag of " + tag + "...")
   grandtotal += 1
else:
   print("Incorrect. Some Ec2 Instances have the incorrect tag. Go back to your arguments.txt file and take a look at the value for $7.")

print('*' * 79)
print("\r")
##############################################################################
# Check to see if 3 instances are of type t2.micro
##############################################################################
print('*' * 79)
print("Testing to make sure the running EC2 instances are all of type t2.micro...")
checkInstanceTypeMismatch = False
for n in range(0,len(response['Reservations'][0]['Instances'])):
  if response['Reservations'][0]['Instances'][n]['InstanceType'] == "t2.micro":
    print("InstanceID of: " + response['Reservations'][0]['Instances'][n]['InstanceId'] + " and of InstanceType: " + response['Reservations'][0]['Instances'][n]['InstanceType'])
  else:
     checkInstanceTypeMismatch = True
     print("Incorrect Ec2 Instance Type of " + str(response['Reservations'][0]['Instances'][n]['InstanceType']) + " set.")

if checkInstanceTypeMismatch is False:
   print("Correct Ec2 Instance Type launched for all EC2 instances.")
   grandtotal += 1
else:
   print("Incorrect Ec2 Instance Types launched. Perhaps go back and take a look at the value in the arguments.txt $1 and $2.")

print('*' * 79)
print("\r")
##############################################################################
# Check PublicDNS and HTTP return status to check if webserver was installed and working
##############################################################################
print('*' * 79)
print("Testing for the correct HTTP status (200) response from the webserver on the EC2 instances...")
# https://pypi.org/project/tqdm/
for i in tqdm(range(30)):
  time.sleep(1)

checkHttpReturnStatusMismatch = False
for n in range(0,len(response['Reservations'][0]['Instances'])):
  print("http://" + response['Reservations'][0]['Instances'][n]['PublicDnsName'])
  try:
    res=requests.get("http://" + response['Reservations'][0]['Instances'][n]['PublicDnsName'], timeout=(3.05, 27))
    if res.status_code == 200:
      print("Successful request of the index.html file from " + str(response['Reservations'][0]['Instances'][n]['PublicDnsName']))
    else:
      checkHttpReturnStatusMismatch = True
      print("Incorrect http response code: " + str(res.status_code) + "from " + str(response['Reservations'][0]['Instances'][n]['PublicDnsName']))
  except requests.exceptions.ConnectionError as errc:
    print ("Error Connecting:",errc)
    checkHttpReturnStatusMismatch = True
    print("No response code returned - not able to connect: " + str(res.status_code) + "from " + str(response['Reservations'][0]['Instances'][n]['PublicDnsName'])) 
    sys.exit("Perhaps wait 1-2 minutes to let the install-env.sh server to finish installing the Nginx server and get the service ready to except external connections? Rerun this test script.")

if checkHttpReturnStatusMismatch == False:
   print("Correct HTTP status code of 200, received for all 3 EC2 instances.")
   grandtotal += 1
else:
   print("Incorrect status code received. Perhaps go back and take a look at the --user-file value and the content of the install-env.sh script. Or check your security group to make sure the correct ports are open.")

print('*' * 79)
print("\r")
##############################################################################
# Print out the grandtotal and the grade values to result.txt
##############################################################################
print('*' * 79)
print("Your result is: " + str(grandtotal) + " out of " + str(totalPoints) + " points. You can retry any items that need adjustment and retest.")

# Write results to a text file for import to the grade system
# https://www.geeksforgeeks.org/sha-in-python/
f = open('create-env-module-02-results.txt', 'w', encoding="utf-8")

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
print("You should now see a create-env-module-02-results.txt file has been generated.")
f.close
print('*' * 79)
