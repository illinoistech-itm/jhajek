# Module-06 Assessment

This assignment you will be creating an AWS managed Secret KV pair for your RDS database along with an RDS instance and a read-replica RDS instance.

You will need to add two additional variables in your text file named: `arguments.txt` in your Vagrant Box home directory. This is where you will pass the arguments as follows (order is **very** important and watch out for trailing spaces) and use the [AWS CLI V2 documentation](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/index.html "webpage for AWS CLI v2 documentation").

You will only be creating a secret KV pair, an RDS database and a read-replica for this assessment.

## Documentation Links


* AWS CLI documentation
  * [RDS](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/rds/index.html "webpage for RDS")
  * [RDS DB Instances Available](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/rds/wait/db-instance-available.html "webpage for RDS Wait DB Instance Available")
  * [Secrets Manager - Create Secrets](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/secretsmanager/create-secret.html "webpage for creating secrets")
  * [Secrets Manager Get Secrets](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/secretsmanager/get-secret-value.html#examples "webpage for Secrets Manager")
  * [RDS Delete DB Instance](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/rds/delete-db-instance.html "webpage for RDS delete DB Instance")

## Arguments to pass

1) image-id
1) instance-type
1) key-name
1) security-group-ids
1) count - of 3
1) user-data -- install-env.sh you will be provided 
1) Tag -- use the module name: `module6-tag`
1) Target Group (use your initials)
1) elb-name (use your initials)
1) Availability Zone 1
1) Availability Zone 2
1) Launch Template Name
1) ASG name
1) ASG min=2
1) ASG max=5
1) ASG desired=3
1) AWS Region for LaunchTemplate (use your default region)
1) EBS hard drive size in GB (15)
1) S3 bucket name one - use initials
1) S3 bucket name two - use initials
1) Secret Name
1) Database Name

## How to run your create script

You will need to run an initial script -- to create your secret. Fill out the values in the `maria.json` file.  Then execute `bash ./create-secrets.sh $(< ~/arguments.txt)` this only needs to be executed once -- once a secret is made no need to run it again -- though if you do there will be a warning but it can be ignored.

`bash ./create-env.sh $(< ~/arguments.txt)`

This command will read all of your arguments and pass them into the shell script in order.

## How to grade your create script

After the `create-env.sh` run completes you will need to run from the commandline the Python script to test and grade your create script.

`python3 ./create-env-test.py` 

This script will generate graded output and give you feedback on your deliverable. You are welcome to fix your script and try again in any areas of the grading that fail. Your submission to Coursera will be a `create-env-module-06-results.txt` file.

## How run your destroy script

In addition you are required to find the proper **delete/terminate** commands to tear down the cloud infrastructure you built. This helps you to better understand how the pieces connect and helps prevent you from leaving resources running and incurring extra charges!

`bash ./delete-env.sh`

## How to grade your destroy script

After the `delete-env.sh` run completes you will need to run from the commandline the Python script to test and grade your create script.

`python3 ./destroy-env-test.py`

This will run tests to make sure all resources from the assignment has been deleted. If any of the tests fail you will be given feedback and can attempt again. Your submission to Coursera will be a `destroy-env-module-06-results.txt` file.
