# Mini-Project 1

This project will deploy the following 10 tasks and verify they have been created.

## Requirements

The tag to search for is: `module-09`

1) Check that there is 1 VPC tagged
1) Check that there is 1 Security Group tagged
1) Check the HTTP check returns an HTTP 200 
1) Check that there are 3 EC2 instances and they are tagged
1) Check that there is 1 Internet gateway and it is tagged
1) Check that there are 3 subnets and they are tagged
1) Check that there is 1 Route table per tagged subnet
1) Check that there is 1 DHCP options created and tagged
1) Check that there is one Auto Scaling Group and that it is tagged
1) Check to make sure 1 route table is attached to your IG

### Requirements

Using your AWS credentials create terraform code to deploy the 10 requirements listed using this structure:

* main.tf
* provider.tf
* terraform.tfvars
* variables.tf

You will also create a Python app (or other language) using the AWS API via `boto3`. Write tests to prove all of the assumptions required. Give yourself 1 point for each test that passes. Print out a `grandTotal` score at the end the `grader.py` and use the provided sample code to write out your results.

## Deliverable

Submit the generated `module-09-results.txt` file to Canvas showing your grade and submit the URL to your source code on GitHub.
