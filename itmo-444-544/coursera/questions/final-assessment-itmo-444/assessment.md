# Summative Assessment ITMO-444 

Objectives: In this assessment you will be combing assessments 05, 06, and 07 into a single create-env.sh and destroy-env.sh. This will involve creating S3 Buckets, Elastic Block Stores, Secrets, and Two MySQL instances (one set as a Read Replica) into a single shell script. You will fill in the blank, missing, or requested values in the `create-env.sh` that satisfies all the conditions set and that are tested for in `create-env-test.py`. The `destroy-env.sh` is already filled out and has no need to edit -- use this to *clear* things out if something breaks on your first deploy.

 # Summative Assessment ITMO-444 

Objectives: In this assessment you will be converting your Module 4, 5, and 6 assessments into a single combined AWS CLI bash script. All the individual functions required by assessment 4, 5, and 6 will be graded against here.

## Setup 

You will need to provide values for all of these variables in the `arguments.txt` file. Use your initials as a prefix.

1) image-id
1) instance-type
1) key-name
1) security-group-ids
1) count - of 3
1) user-data -- install-env.sh you will be provided 
1) Tag -- use the module name: `module-final-tag`
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

## How to test your create script

You will need to execute: `bash ./create-lt-json $(< ~/arguments.txt)` to create the launch template json file. The you will execute the command: `bash ./create-env.sh $(< ~/arguments.txt)`. Run from the commandline the Python script to test your work.

`python3 ./create-env-test.py` 

This script will generate output and give you feedback on your deliverable. You are welcome to fix your script and try again in any areas of the grading that fail.

## How run your destroy script

In addition you are required to find the proper **delete/terminate** commands to tear down the cloud infrastructure you built. This helps you to better understand how the pieces connect and helps prevent you from leaving resources running and incurring extra charges!

`bash ./destroy-env.sh`

## How to test your destroy script

After the `terraform destroy` run completes you will need to run from the commandline the Python script to test and grade your create script.

`python3 ./destroy-env-test.py`

This will run tests to make sure all resources from the assignment has been deleted. If any of the tests fail you will be given feedback and can attempt again.

## Deliverable: 

You will create a zip folder and submit to Coursera containing:

* `create-env.sh`
* `create-lt-json`
* `destroy-env.sh`
