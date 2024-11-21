# Module 08

## Objectives

* Demonstrate the process to install AWS JavaScript SDK packages
* Demonstrate the concept of deploying a working cloud native application
* Demonstrate the IAM concepts needed for integrating cloud services for an application
* Demonstrate the termination of cloud resources in an automated fashion

## Links to Use

* [AWS JavaScript SDK Reference](https://docs.aws.amazon.com/AWSJavaScriptSDK/v3/latest/ "AWS JavaScript SDK Reference")
* [AWS JavaScript SDK Installation](https://docs.aws.amazon.com/sdk-for-javascript/v3/developer-guide/getting-started.html "AWS JavaScript SDK Installation")
* [NodeJS](https://nodejs.org/en "NodeJS")
* [Installing Node JS on Ubuntu](https://github.com/nodesource/distributions#using-ubuntu-nodejs-20 "Installing Node JS on Ubuntu")
* [PM2](https://pm2.keymetrics.io/ "PM2 service manager for JavaScript applications")
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
# ${13} module-08
# ${14} asg name
# ${15} launch-template name
# ${16} asg min
# ${17} asg max
# ${18} asg desired
# ${19} RDS Database Instance Identifier (no punctuation) --db-instance-identifier
# ${20} IAM Instance Profile Name
# ${21} S3 Bucket Raw
# ${22} S3 Bucket Finished
```

## Assumptions

Assume all the requirements from module-07 to be completed and this module's requirements will add on to module-07. You will need to have IAM permissions for Secrets Manager, RDS, and S3.

## Part 1

Add to your `install-env.sh` logic needed to:

* Remove the Nginx install code
* Install `Node.js` and all its pre-reqs
* Install via `npm` all AWS JavaScript SDK packages required
* Install via `npm` all application dependencies
* Clone your private repo and using the PM2 process manager start the app.js application
  * Making use of an Nginx reverse proxy (code provided)

Make use of this code block after your RDS instance launches and after the waiter is complete.

```bash
aws rds modify-db-instance \
    --db-instance-identifier ${19} \
    --manage-master-user-password
```

## Part 2

Using the [Python Boto3 AWS SDK](https://boto3.amazonaws.com/v1/documentation/api/latest/index.html "Python Boto3 AWS SDK") you will write an autograder script for this project. One for the `create-env.sh` named: `create-env-grader.py`, and one for the `destroy-env.py` named: `destroy-env-grader.py`. Print out information per item below to the screen and keep a grandtotal to print out your score out of 5.

For the `create-env-grader.py`:

* Check for the existence of one RDS instance~~s~~ and one RDS Snapshot
* Check for the existence of the **module-08** tag for the database instance
* Check for the existence of two S3 buckets
* Check for the existence of 2 images named: `vegeta.jpg` and `knuth.jpg` 
* Check for the ELB to return an HTTP 200 upon request

For the `destroy-env-grader.py`:

* Check for the existence of zero Launch Templates
* Check for the existence of zero S3 buckets
* Check for the existence of zero ELBs
* Check for the existence of zero EC2 instances
* Check for the existence of zero RDS instances

## Deliverables

Create a folder named: `module-08` under your class folder in the provided private repo. Provide the following files:

* `create-env.sh`
* `destroy-env.sh`
* `install-env.sh`
* `create-env-test.py`
* `destroy-env-test.py`
  * I will test this script by using my own account information

Submit the URL to the `module-08` folder to Canvas.
