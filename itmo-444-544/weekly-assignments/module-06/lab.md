# Module 06

## Objectives

* Demonstrate the process of creating secrets and the process of how to manage them
* Explain the purpose and use of RDS instances
* Demonstrate the to launch RDS instances
* Demonstrate the termination of cloud resources in an automated fashion

## Links to Use

* [AWS CLI Reference](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/index.html "webpage aws cli sdk")
* [RDS](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/rds/index.html "RDS cli page")
* [Manage RDS Secrets with Secrets Manager](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/rds-secrets-manager.html#rds-secrets-manager-limitations "Manage RDS secrets with Secrets Manager")
* [Secrets Manager](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/secretsmanager/index.html "Secrets Manager cli page")
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
# ${13} module-06
# ${14} asg name
# ${15} launch-template name
# ${16} asg min
# ${17} asg max
# ${18} asg desired
# ${19} RDS Database Instance Identifier (no punctuation) --db-instance-identifier
```

## Assumptions

Assume all the requirements from module-05 to be completed and this module's requirements will add on to module-05. You will need to add additional IAM permissions for Secrets Manager and RDS.

## Part 1

Add to your `create-env.sh` a commands to create a [proper RDS instance](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_CreateDBInstance.html "RDS how to create with passwords managed page"), along with a `db-subnet-group`. Use the `--manage-master-user-password` option to allow the AWS Secrets Manager to handle your password. ~~Add a read-replica to this option.~~ Use `--db-instance-identifier` for `${19}` and use `db.t3.micro` as the free-tier db instance type. Tag your database with the module tag. Though it will take extra time, make use of waiters for the RDS instances.

## Part 2

Modify your `destroy-env.sh` to detach and destroy all resources launched during the `create-env.sh` process. Watch the waiter logic. Note that destroying a database takes 5-15 minutes. Plan accordingly. Though it will take extra time, make use of waiters for the RDS instances.

## Part 3

Using the [Python Boto3 AWS SDK](https://boto3.amazonaws.com/v1/documentation/api/latest/index.html "Python Boto3 AWS SDK") you will write an autograder script for this project. One for the `create-env.sh` named: `create-env-grader.py`, and one for the `destroy-env.py` named: `destroy-env-grader.py`. Print out information per item below to the screen and keep a grandtotal to print out your score out of 5.

For the `create-env-grader.py`:

* Check for the existence of ~~two~~ one RDS instances
* Check for the existence of the **module-06** tag for the database instance~~s~~
* Check for the existence of one Secret in your Secrets Manager
* Check for the existence of three EC2 instances tagged: **module-06**
* Check for the ELB to return an HTTP 200 upon request

For the `destroy-env-grader.py`:

* Check for the existence of zero Launch Templates
* Check for the existence of zero Autoscaling Groups
* Check for the existence of zero ELBs
* Check for the existence of zero EC2 instances
* Check for the existence of zero RDS instances

## Deliverables

Create a folder named: `module-06` under your class folder in the provided private repo. Provide the following files:

* `create-env.sh`
* `destroy-env.sh`
* `create-env-test.py`
* `destroy-env-test.py`
  * I will test this script by using my own account information

Submit the URL to the `module-06` folder to Canvas.
