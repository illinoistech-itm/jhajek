# Module 05

This module you will create declarative code to deploy cloud infrastructure.

## Objectives

* Implement cloud native principals
* Explore the declarative programming methodology
* Create templated code
* Engage Cloud Native API usage

## Outcomes

At the conclusion of this lab, you will have implemented cloud native APIs and engaged with Cloud Native principals. You will have deployed templated cloud native infrastructure and able to self-assess your deployment.

### References

* [Terraform AWS Provider](https://registry.terraform.io/providers/hashicorp/aws/latest/docs "Terraform AWS Provider")
* [Terraform - how to assign variables values](https://developer.hashicorp.com/terraform/language/values/variables#sensitive-values-in-variables "Terraform - how to assign variables values")
* [Terraform - how to reference variable values](https://developer.hashicorp.com/terraform/language/values/variables#reference-variable-values "Terraform - how to reference variable values")
* [Python Boto3 AWS SDK Documentation](https://boto3.amazonaws.com/v1/documentation/api/latest/index.html "Python Boto3 AWS SDK Documentation")

## Requirements - Part I

All required files to create should be created in a directory named: `module-05` under your `itmo-463` or `itmo-563` directory and pushed to GitHub.  Then pull your code into your Ubuntu or Almalinux Vagrant box.

Using your Ubuntu Server Vagrant Box with Terraform installed and your AWS tokens configured, you will create 5 files.

* `main.tf`
* `provider.tf`
* `terraform.tfvars`
* `variables.tf`
* `install-env.sh`
  * This should include code to install and start the `nginx` service

In the `variables.tf` file you will declare these variables of type string:

* instance-type 
* key-name 
* security-group-ids
* count 
* user-data
* tags

In the `terraform.tfvars` assign a value for these variables:

* `instance-type` = t3-micro 
* `key-name`  = name of your keypair
* `security-group` = id of your created security group
* ~~count~~ `instance_account` = 3
* `user-data` = path to the file `install-env.sh`
* `tags` = 'module-05'

Use a `filter` to dynamically query for the Image AMI

## Requirements - Part II

Using the AWS Python Boto3 library, create two python program named: `grader-create.py` and `grader-destroy.py`. Other language SDKs are acceptable -- modify accordingly.

Each file will require these Python imports: 

```bash
# Dependencies to install
sudo apt install vim git python3-dev python3-pip python3-setuptools build-essential python3-boto python3-bs4 python3-tqdm python3-requests python3-mysql.connector
```

* import json
* import requests
* import sys
* import datetime
* import time
* from tqdm import tqdm

### The grader-create.py Requirements

In the Python code using the EC2 library for Python that will check 4 items and grade accordingly.  Where possible use variables in place of hardcoded values.

* instance count = 3
* instance type = t3.micro 
* tag includes = module-05
* Security group is allowing http traffic to your instance

Create if statements that check these values and print out the results: for example (this is pseudo code)...

```python

if len(query.aws.number.of.instances) == X
   print "This module requires a count of X instances, you have Y instances"
   grandTotal += 1
else
   print "This module requires a count of X instances, you have Y instances, there is a mis-match.  Perhaps go back and check the value of the count variable in your terraform.tfvars"
```

```python
# This is a sample that I will give you for the security group http check
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
```

At the conclusion of the grade script, print out the grand total for the student.

### The grader-destroy.py Requirements

This is to be execute after a `terraform destroy` command. 

Create a Python program that will check that there are currently no `running` instances.

At the conclusion of the grade script, print out the grand total for the student.

## Deliverable

Push all required files to your GitHub repo in the directory indicated.  Submit the URL to that directory to Canvas.
