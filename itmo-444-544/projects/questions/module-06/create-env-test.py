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
totalPoints = 3
assessmentName = "module-6-create-assessment"
correctNumberOfRDSInstances      = 2
tag = "module6-tag"

# Documentation Links
# https://boto3.amazonaws.com/v1/documentation/api/latest/reference/services/rds/client/describe_db_instances.html
# https://boto3.amazonaws.com/v1/documentation/api/latest/reference/services/rds/client/create_db_instance.html

clientrds = boto3.client('rds')

# https://boto3.amazonaws.com/v1/documentation/api/latest/reference/services/rds/client/describe_db_instances.html
response = clientrds.describe_db_instances()

print("Beginning tests for Module-06...")

##############################################################################
# Check to make sure 2 RDS instances are running and available
##############################################################################
print('*' * 79)
print("Testing for the existence of 2 RDS instances...")

if len(response['DBInstances']) == correctNumberOfRDSInstances:
  print("Way to go 2 RDS instances were required, and you have two launched...")
  grandtotal +=1
  for n in range(0,len(response['DBInstances'])):
    print("DBInstance Identifier: " + response['DBInstances'][n]['DBInstanceIdentifier'])

else:
  print("Something happened and you only have, " + str(len(response['DBInstances'])) + " RDS instances. Perhaps double check the AWS console and check the status of your RDS instances?")

print('*' * 79)
##############################################################################
# Check to make sure 2 RDS instances are running mysql engine
##############################################################################
print('*' * 79)
print("Testing the database engine type of each RDS instance...")
engineCorrect = False

if len(response['DBInstances']) == correctNumberOfRDSInstances:
  for n in range(0,len(response['DBInstances'])):
    print("DBInstance Identifier: " + response['DBInstances'][n]['DBInstanceIdentifier'])
    if response['DBInstances'][n]['Engine'] == "mysql":
      engineCorrect = True
      print("Your RDS Instance is running: " + str(response['DBInstances'][n]['Engine']))
    else:
      engineCorrect = False
      print("Something happened and the RDs database engine is not mysql. Check your create-env.sh for the --engine option...")
else:
  print("Something happened and you only have, " + str(len(response['DBInstances'])) + " RDS instances. Perhaps double check the AWS console and check the status of your RDS instances?")

if engineCorrect:
  grandtotal +=1

print('*' * 79)
##############################################################################
# Check to make sure 2 RDS instances are tagged with the correct module tag: module6-tag
##############################################################################
print('*' * 79)
print("Testing the tag values of each of the RDS instances to match the correct module tag name...")
tagCorrect = False

if len(response['DBInstances']) == correctNumberOfRDSInstances:
  for n in range(0,len(response['DBInstances'])):
    print("DBInstance Identifier: " + response['DBInstances'][n]['DBInstanceIdentifier'])
    if response['DBInstances'][n]['TagList'][0]['Value'] == "module6-tag":
      print("Your RDS Instance is tagged: " + str(response['DBInstances'][n]['TagList'][0]['Value']))
      tagCorrect = True
    else:
      tagCorrect = False
      print("Your tag value is: " + str(response['DBInstances'][n]['TagList'][0]['Value']))
      print("Something happened and your tags are incorrect, perhaps go back and look at ${7} in the arguments.txt file...")
else:
  print("Something happened and you only have, " + str(len(response['DBInstances'])) + " RDS instances. Perhaps double check the AWS console and check the status of your RDS instances?")

if tagCorrect:
  grandtotal +=1

print('*' * 79)
##############################################################################
# Print out the grandtotal and the grade values to result.txt
##############################################################################
print('*' * 79)
print("Your result is: " + str(grandtotal) + " out of " + str(totalPoints) + " points. You can retry any items that need adjustment and retest.")

# Write results to a text file for import to the grade system
# https://www.geeksforgeeks.org/sha-in-python/
f = open('create-env-module-06-results.txt', 'w', encoding="utf-8")

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
print("You should now see a create-env-module-06-results.txt file has been generated.")
f.close
print('*' * 79)
