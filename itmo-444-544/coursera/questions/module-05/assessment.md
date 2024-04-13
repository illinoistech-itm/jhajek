# Module-05 Assessment

This assignment will build on the contents of your module-05 assessment. Using that code we will add two additional items. We will add Elastic Block Storage to each EC2 instance as part of our launch template. We will create two S3 buckets and put these objects into said buckets (images will be provided).

You will need to add three additional variables in your text file named: `arguments.txt` in your Vagrant Box home directory. This is where you will pass the arguments (space delimited) as follows (order is **very** important and watch out for trailing spaces) and use the [AWS CLI V2 documentation](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/index.html "webpage for AWS CLI v2 documentation").

## Documentation Links

* [https://aws.amazon.com/elasticloadbalancing/​](https://aws.amazon.com/elasticloadbalancing/​ "webpage for AWS ELB")
* [https://aws.amazon.com/mp/networking/load-balancers/](https://aws.amazon.com/mp/networking/load-balancers/ "Webpage for load-balancers")
* AWS CLI documentation
  * [elbv2](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/elbv2/index.html "webpage for elbv2")
  * [Create Target Group](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/elbv2/create-target-group.html "webpage for creating target groups")
  * [Deregister Targets](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/elbv2/deregister-targets.html "web page for deregistering targets")
  * [Delete Target Groups](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/elbv2/delete-target-group.html "webpage for delete target groups")
  * [Create Autoscaling Groups](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/autoscaling/create-auto-scaling-group.html "webpage for creating autoscaling groups")
  * [Create Launch Templates](https://awscli.amazonaws.com/v2/documentation/api/2.0.33/reference/ec2/create-launch-template.html "webpage for creating launch templates")
  * [S3api commands](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/s3api/index.html "webpage for s3api commands")
  * [S3 commands](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/s3/index.html "webpage for S3 commands")
  * [ EBS launch template examples](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/ec2/create-launch-template.html#examples "webpage to EBS launch template EBS examples")

## Arguments to pass

1) image-id
1) instance-type
1) key-name
1) security-group-ids
1) count - of 3
1) user-data -- install-env.sh you will be provided 
1) Tag -- use the module name: `module5-tag`
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

## How to run your create script

`bash ./create-env.sh $(< ~/arguments.txt)`

This command will read all of your arguments and pass them into the shell script in order.

## How to grade your create script

After the `create-env.sh` run completes you will need to run from the commandline the Python script to test and grade your create script.

`python3 ./create-env-test.py` 

This script will generate graded output and give you feedback on your deliverable. You are welcome to fix your script and try again in any areas of the grading that fail. Your submission to Coursera will be a `create-env-module-05-results.txt` file.

## How run your destroy script

In addition you are required to find the proper **delete/terminate** commands to tear down the cloud infrastructure you built. This helps you to better understand how the pieces connect and helps prevent you from leaving resources running and incurring extra charges!

`bash ./delete-env.sh`

## How to grade your destroy script

After the `delete-env.sh` run completes you will need to run from the commandline the Python script to test and grade your create script.

`python3 ./destroy-env-test.py`

This will run tests to make sure all resources from the assignment has been deleted. If any of the tests fail you will be given feedback and can attempt again. Your submission to Coursera will be a `destroy-env-module-05-results.txt` file.
