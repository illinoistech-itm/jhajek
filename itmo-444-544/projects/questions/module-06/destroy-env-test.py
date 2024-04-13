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
totalPoints = 1
assessmentName = "module-6-destroy-assessment"
correctNumberOfRDSInstances      = 0
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
print("Testing for the non-existence of RDS instances...")

if len(response['DBInstances']) == correctNumberOfRDSInstances:
  print("Way to go! No running RDS instances were found...")
  grandtotal +=1
else:
    print("Something happened, and you have: " + str(len(response['DBInstances'])) + " RDS instance(s) running.")
    print("Perhaps double check the AWS console and check the status of your RDS instances?")
    print("OR rerun the command: bash ./destroy-env.sh ...")

print('*' * 79)

##############################################################################
# Print out the grandtotal and the grade values to result.txt
##############################################################################
print('*' * 79)
print("Your result is: " + str(grandtotal) + " out of " + str(totalPoints) + " points. You can retry any items that need adjustment and retest.")

# Write results to a text file for import to the grade system
# https://www.geeksforgeeks.org/sha-in-python/
f = open('destroy-env-module-06-results.txt', 'w', encoding="utf-8")

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
print("You should now see a destroy-env-module-06-results.txt file has been generated.")
f.close
print('*' * 79)