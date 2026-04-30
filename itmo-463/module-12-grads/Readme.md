# Mini-Project 3

This project will deploy the following 10 tasks and verify they have been created.

## Requirements

Using the AWS Terraform Provider, you are to remove all RDS components, subnets, and snapshots from your code and replace with a DynamoDB.  Use the provided `create.sql` as your template for creating the DynamoDB and use the `put item` command to insert one record.

The tag to search for is: `module-12`, unless noted. You can reuse tests from previous assignments. Copy your `grader.py` from the previous assignment and adjust the grader tasks to be these 10 tasks.

1) Check that there is 1 AMI tagged: `module-11-template`
1) Check that there is 1 DynamoDB Table tagged `module-12`
1) Check that there is 1 item (record) present in the DynamoDB table
1) Check that there are 0 RDS Snapshots
1) Check that there are 0 RDS subnets
1) Check that there are 2 Security Groups tagged: `module-12`
1) Check the HTTP check returns an HTTP 200 
1) Check that there are 3 EC2 instances and they are tagged: `module-12`
1) Check that there are 3 subnets and they are tagged: `module-12`
1) Check that there is one Auto Scaling Group and that it is tagged: `module-12`

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

Submit the generated `module-12-results.txt` file to Canvas showing your grade and submit the URL to your source code on GitHub. Due on the day of the final exam period. In person section students will demonstrate live in class and answer questions related to your code. Online students will record using Panopto a demonstration of their code, a brief explanation, and a live grading of their code.
