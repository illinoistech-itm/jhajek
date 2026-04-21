# Mini-Project 2

This project will deploy the following 10 tasks and verify they have been created.

## Requirements

The tag to search for is: `module-11`  and `module-11-template`

1) Check that there is 1 AMI tagged: `module-11-template`
1) Check that there is 1 RDS Snapshot tagged:`module-11-template`
1) Check that there is 1 RDS Instance tagged:`module-11`
1) Check that there is 1 Database subnet group tagged: `module-11`
1) Check that there are 2 Security Groups tagged: `module-11`
1) Check the HTTP check returns an HTTP 200 
1) Check that there are 3 EC2 instances and they are tagged: `module-11`
1) Check that there are 2 secrets in the secrets manager and they are tagged: `module-11`
1) Check that there are 3 subnets and they are tagged: `module-11`
1) Check that there is one Auto Scaling Group and that it is tagged: `module-11`

### Requirements

Using your AWS credentials create terraform code to deploy the 10 requirements listed using this structure:

* main.tf
* provider.tf
* terraform.tfvars
* variables.tf

You will also create a Python app (or other language) using the AWS API via `boto3`. Write tests to prove all of the assumptions required. 

Write out the requirements in your tests and provide the required and actual numbers of elements. If a test fails, provide the numeric details as well as some hints to the user.

Give yourself 1 point for each test that passes. Print out a `grandTotal` score at the end the `grader.py` and use the provided sample code to write out your results.

## Deliverable

Submit the generated `module-11-results.txt` file to Canvas showing your grade and submit the URL to your source code on GitHub.
