# Module 05 Autograder
import boto3
import json
import requests
import hashlib
import sys
import datetime
import time
from tqdm import tqdm

# Create variables to check for correct numbers of elements


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
# Eleven tasks to cover
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
# 1 Load Balancer tagged
# 1 autoscaling group tagged
# 1 launch template tagged

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

# https://boto3.amazonaws.com/v1/documentation/api/latest/reference/services/elbv2/client/describe_load_balancers.html

# https://boto3.amazonaws.com/v1/documentation/api/latest/reference/services/elbv2/client/describe_target_groups.html

# https://boto3.amazonaws.com/v1/documentation/api/latest/reference/services/autoscaling/client/describe_auto_scaling_groups.html

print("\r")
##############################################################################
# Testing Tagging of new Security Group
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

print('*' * 79)
print("\r")
##############################################################################
# Check EC2 instances Tag values to be 'module-03' tag
##############################################################################
print('*' * 79)
print("Testing to make sure the running EC2 instances all have the tag of: " + tag + "...")

print('*' * 79)
print("\r")
##############################################################################
# Check to see if Internet Gateway Created and Tagged
##############################################################################
print('*' * 79)
print("Testing to see if newly created and tagged Internet Gateway created... ")

print('*' * 79)
print("\r")
##############################################################################
# Check to see if Route Table Created and Tagged
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
# Check to see if DHCP Options created and Tagged
##############################################################################
print('*' * 79)
print("Testing to see if the DHCP Options were set and properly tagged with " + tag + "...")

print('*' * 79)
print("\r")
##############################################################################
# Check to see Route Table Attached has the correct VPC CIDR Block and Gateway
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

print('*' * 79)
print("\r")
