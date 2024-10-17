# Module 05

## Objectives

* Demonstrate the process to evolve our target-group based infrastructure to use Autoscaling Groups
* Demonstrate the process of launching a cloud native three-tier web application
* Demonstrate the termination of cloud resources in an automated fashion

## Links to Use

* [AWS CLI Reference](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/index.html "webpage aws cli sdk")
* [Autoscaling Groups](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/autoscaling/index.html "autoscaling groups")
* [Launch Templates](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/ec2/create-launch-template.html "Create Launch Templates")
* [Python Boto3 AWS SDK](https://boto3.amazonaws.com/v1/documentation/api/latest/index.html "Python Boto3 AWS SDK")

## Arguments.txt

```bash
# ${1} ami-085f9c64a9b75eed5
# ${2} t2.micro
# ${3} itmo-544-2024
# ${4} sg-0c7709a929dbfbb4d
# ${5} 3
# ${6} install-env.sh
# ${7} us-east-2a
# ${8} jrh-elb
# ${9} jrh-tg
# ${10} us-east-2a
# ${11} us-east-2b
# ${12} us-east-2c
# ${13} module-05
# ${14} asg name
# ${15} launch-template name
# ${16} asg min
# ${17} asg max
# ${18} asg desired
```

## Part 1

Modify your `create-env.sh` to deprecate attaching Ec2 instances manually and instead use a launch template and your autoscaling group min/max to launch the required amount.

## Part 2

Modify your `destroy-env.sh` to detach and destroy all resources launched during the `create-env.sh` process. Watch the waiter logic.

## Part 3

Using the [Python Boto3 AWS SDK](https://boto3.amazonaws.com/v1/documentation/api/latest/index.html "Python Boto3 AWS SDK") you will write an autograder script for this project. One for the `create-env.sh` named: `create-env-grader.py`, and one for the `destroy-env.py` named: `destroy-env-grader.py`. Print out information per item below to the screen and keep a grandtotal to print out your score out of 5.

For the `create-env-grader.py`:

* Check for the existence of one Launch Template
* Check for the existence of one Autoscaling Group
* Check for the existence of one ELB
* Check for the existence of three EC2 instances tagged: **module-05**
* ~~Check for the existence of the EC2 instances being tagged: **module-05**~~
* Check for the ELB to return an HTTP 200 upon request

For the `destroy-env-grader.py`:

* Check for the existence of zero Launch Templates
* Check for the existence of zero Autoscaling Groups
* Check for the existence of zero ELBs
* Check for the existence of zero EC2 instances
* Check for the existence of zero Target Groups

## Deliverables

Create a folder named: `module-05` under your class folder in the provided private repo. Provide the following files:

* `create-env.sh`
* `destroy-env.sh`
* `create-env-test.py`
* `destroy-env-test.py`
  * I will test this script by using my own account information

Submit the URL to the `module-05` folder to Canvas.
