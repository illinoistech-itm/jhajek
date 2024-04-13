# Module-02 Assessment

This assignment requires you to launch 3 EC2 instances from the commandline of type t2.micro using the keypair and securitygroup ID you created in a file named: `create-env.sh`.
 
You will need to define these variables in a text file named: `arguments.txt` in your Vagrant Box home directory. This is where you will pass the arguments (space delimited) as follows (order is **very** important and watch out for trailing spaces) and use the [AWS CLI V2 documentation](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/index.html "webpage for AWS CLI v2 documentation").

## Arguments to pass

1) image-id
1) instance-type
1) key-name
1) security-group-ids
1) count - of 3
1) user-data -- install-env.sh you will be provided 
1) Tag -- use the module name, ie `module2-tag`

## How to run your create script

`bash ./create-env.sh $(< ~/arguments.txt)`

This command will read all of your arguments and pass them into the shell script in order.

## How to grade your create script

After the `create-env.sh` run completes you will need to run from the commandline the Python script to test and grade your create script.

`python3 ./create-env-test.py` 

This script will generate graded output and give you feedback on your deliverable. You are welcome to fix your script and try again in any areas of the grading that fail. Your submission to Coursera will be a `create-env-module-02-results.txt` file.

## How run your destroy script

In addition you are required to find the proper **delete/terminate** commands to tear down the cloud infrastructure you built. This helps you to better understand how the pieces connect and helps prevent you from leaving resources running and incurring extra charges!

`bash ./delete-env.sh`

## How to grade your destroy script

After the `delete-env.sh` run completes you will need to run from the commandline the Python script to test and grade your create script.

`python3 ./destroy-env-test.py`

This will run tests to make sure all resources from the assignment has been deleted. If any of the tests fail you will be given feedback and can attempt again. Your submission to Coursera will be a `destroy-env-module-02-results.txt` file.
