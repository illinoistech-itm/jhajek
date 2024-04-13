# Module-03 Assessment

This assignment requires you to launch 3 EC2 instances from the commandline of type t2.micro using the keypair and securitygroup ID you created in a file named: `create-env.sh`. In addition those instances will be attached to a `target group` and then via a `listener` to an `Elastic Load Balancer`. 
 
You will need to define these variables in a text file named: `arguments.txt` in your Vagrant Box home directory. This is where you will pass the arguments (space delimited) as follows (order is **very** important and watch out for trailing spaces) and use the [AWS CLI V2 documentation](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/index.html "webpage for AWS CLI v2 documentation").

## Documentation Links

* [https://aws.amazon.com/elasticloadbalancing/​](https://aws.amazon.com/elasticloadbalancing/​ "webpage for AWS ELB")
* [https://aws.amazon.com/mp/networking/load-balancers/](https://aws.amazon.com/mp/networking/load-balancers/ "Webpage for load-balancers")
* AWS CLI documentation
  * [elbv2](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/elbv2/index.html "webpage for elbv2")
  * [Create Target Group](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/elbv2/create-target-group.html "webpage for creating target groups")
  * [Deregister Targets](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/elbv2/deregister-targets.html "web page for deregistering targets")
  * [Delete Target Groups](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/elbv2/delete-target-group.html "webpage for delete target groups")

## Arguments to pass

1) image-id
1) instance-type
1) key-name
1) security-group-ids
1) count - of 3
1) user-data -- install-env.sh you will be provided 
1) Tag -- use the module name: `module3-tag`
1) Target Group (use your initials)
1) elb-name (use your initials)
1) Availability Zone 1
1) Availability Zone 2

## How to run your create script

`bash ./create-env.sh $(< ~/arguments.txt)`

This command will read all of your arguments and pass them into the shell script in order.

## How to grade your create script

After the `create-env.sh` run completes you will need to run from the commandline the Python script to test and grade your create script.

`python3 ./create-env-test.py` 

This script will generate graded output and give you feedback on your deliverable. You are welcome to fix your script and try again in any areas of the grading that fail. Your submission to Coursera will be a `create-env-module-03-results.txt` file.

## How run your destroy script

In addition you are required to find the proper **delete/terminate** commands to tear down the cloud infrastructure you built. This helps you to better understand how the pieces connect and helps prevent you from leaving resources running and incurring extra charges!

`bash ./delete-env.sh`

## How to grade your destroy script

After the `delete-env.sh` run completes you will need to run from the commandline the Python script to test and grade your create script.

`python3 ./destroy-env-test.py`

This will run tests to make sure all resources from the assignment has been deleted. If any of the tests fail you will be given feedback and can attempt again. Your submission to Coursera will be a `destroy-env-module-03-results.txt` file.
