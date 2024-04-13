# Summative Assessment ITMO-544 

Objectives: In this assessment you will be converting your Module 5, 6, and 7 assessments into a single combined Terraform HCL code base. You will be converting from using an RDS instance to a DynamoDB table instance in the sample code provided. Using the `main.tf` and the `terraform.tfvars` files you will fill in all the blank values.  If you are in the region outside of `us-east-2` you will need to modify that value in the `provider.tf` file. Terraform makes use of a `Plan` file and doesn't have discrete create and destroy scripts, but uses the `apply/destroy` commands to execute both functions.

## Setup 

You will need to provide values for all of these variables in the `terraform.tfvars` file. Use your initials as a prefix.

* imageid                
* instance-type          
* key-name               
* vpc_security_group_ids 
* cnt                   
* install-env-file       
* elb-name               
* tg-name                
* asg-name               
* lt-name                
* module-tag  (module-final-tag)
* xxx-raw-s3 (xxx = your initials)
* xxx-finished-s3 (xxx = your initials)
* dynamodb-table-name    

## How to run your create script

* `terraform init`
* `terraform validate`
* `terraform apply`

These commands will read all of your arguments and request AWS to build the required architecture

## How to test your create script

After the `terraform apply` run completes you will need to execute: `bash ./upload-images-to-s3.sh $(< ~/arguments.txt)` to upload images to your S3 bucket. Run from the commandline the Python script to test your work.

`python3 ./terraform-create-env-test.py` 

This script will generate output and give you feedback on your deliverable. You are welcome to fix your script and try again in any areas of the grading that fail.

## How run your destroy script

In addition you are required to find the proper **delete/terminate** commands to tear down the cloud infrastructure you built. This helps you to better understand how the pieces connect and helps prevent you from leaving resources running and incurring extra charges!

`terraform destroy`

## How to test your destroy script

After the `terraform destroy` run completes you will need to run from the commandline the Python script to test and grade your create script.

`python3 ./terraform-destroy-env-test.py`

This will run tests to make sure all resources from the assignment has been deleted. If any of the tests fail you will be given feedback and can attempt again.

## Deliverable: 

You will create a zip folder and submit to Coursera containing:

* `main.tf`
* `provider.tf`
* `terraform.tfvars`
* `variables.tf`
