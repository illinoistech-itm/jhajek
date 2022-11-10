# Week-11 Mini-Project 1

## Objectives

* Deploy and explain the IAM permission hierarchy for S3 bucket access
* Deploy and explain IAM profile instance attachments
* Configure and explain VPC subnetting in the AWS Cloud
* Deploy and configure a custom EC2 image
* Deploy and explain how to clone application code via Git
* Configure and explore Cloud Security using AWS Secrets management

## Outcomes

Building upon the previous labs accomplishments, at the conclusion of this Mini-Project (MP) you will have successfully created, deployed, and destroyed a cloud native three-tier application via the AWS CLI using positional parameters in a shell script. Our goals will include adding VPC subnetting for our database application, creating custom EC2 instances and, deploying a sample JavaScript Application.  We will further connect the application with S3 buckets, for storage of uploaded media. You will have deployed and interfaced with the concept of state in deploying Relational Database Services with Read-Replicas. Finally you will have concluded your cloud native development by working with Auto-Scaling groups in conjunction with load-balancers.

## Assumptions

For this assignment you can make these assumptions

* Start by copying your code from week-07 into a directory named: **mp1**
  * `create-env.sh`, `destroy-env.sh`, and `install-env.sh`
  * Along with the provided `app.js` and `index.html`
* We will all be using `us-east-2` as our default region - update this if needed in your `aws configure`
* That the access keys are already created and not needed in this script
* You will use the security-group has been already created and all of the proper ports are open
  * You will in your create-env.sh script provide the creation of two more security groups for the database ingress and egress
* Use AWS Secrets to retrieve username and password for the Maria SQL Database
  * When creating the RDS instance use the retrieved secrets values for `master-user-password` and `master username`

## Deliverable

Create a folder named: `mp2` under your class folder in the provided private repo.  Try not to leave uneeded files, samples, or old code commented out in your assignments. Make it clean.

* A script named: `create-env.sh`
  * In addition to the previous weeks requirements, you will need to deploy the following:
* A script named: `destroy-env.sh`
  * This script will terminate **all** infrastructure you have created and **must work**
* A script named: `install-env.sh`
  * We will clone our sample JavaScript application
  * Install dependencies
  * Run at infrastructure boot time

### create-env.sh

This is shell script will take commandline input dynamically via positional parameters ($1 $2 $3 and so on) via a file named `arguments.txt`. For a refresh on positional parameters [see my text book](https://github.com/jhajek/Linux-text-book-part-1/releases/tag/2021-09-29 "Link to Linux Textbook") starting on page 179 PDF.

You can access positional parameters after `$9` by using `${10}`. You can hard code the user-data flag to be the value: `file://install-env.sh`

Run your script in this fashion:

```./create-env.sh $(<arguments.txt)```

### Pre-reqs

* Create a custom profile only allowing read and write access to the raw bucket and read only access to the finished bucket
* Create your secrets in a file called `create-sec.sh`, run this before create-env.sh, pass the arguments.txt ignore all other values than secret ID

### New create-env.sh requirements

* Deploy a SQL schema to your RDS instances (will be provided)
  * In the index.html file, provide form fields for name, email, and phone number
* In the app.js, upon upload of a file, place a record into the database of the transaction - use a UUID for the ID field
* Implement the creation of a queue via SQS
  * Place a message on the queue stating the UUID (transaction ID)
* Create an additional `ec2 run-instances` command to launch an additional single ec2 instance to retrieve and modify our uploaded image
  * You will copy two files into the `/etc/systemd/system` diretory
  * `check-for-new-objects.timer`
  * `check-for-new-objects.service`
* The `.timer` file will execute the `.service` file every two minutes
  * The `.service` file will run a Python script to check for new messages on the SQS Queue

### Arguments.txt

This is where you will pass the arguments (space delimited) as follows (order is **very** important). **Note:** updated arguments.txt order 11/07

* image-id
* instance-type
* key-name
* security-group-ids
* count (3)
* availability-zone
* elb name
* target group name
* auto-scaling group name
* launch configuration name
* db instance identifier (database name)
* db instance identifier (for read-replica), append *-rpl*
* min-size = 2
* max-size = 5
* desired-capacity = 3
* Database engine (use mariadb)
* Database name ( use company )
* s3 raw bucket name (use initials and -raw)
* s3 finished bucket name (use initials and -fin)
* aws secret name
* iam-instance-profile
* sqs name

These values we will dynamically query for

* subnet-id (1)
* subnet-id (2)
* vpc-id
* ~~The additional security groups created for RDS ingress and egress~~

### How to filter for state running

`aws ec2 describe-instances --filters Name=instance-state-name,Values=running` and can be combined with Queries.  Filters filter your results, query is what you ask Amazon to select for you.

### Grading

I will grade your logic by running it with my account configuration information, no hard-coded values.

### install-env.sh

See provided template for installing expressJS dependencies

### destroy-env.sh

Using AWS CLI v2 filters filter the instance you created and destroy it.  A single running of `destroy-env.sh` will terminate all of the resources that your `install-env.sh` script launched.

[AWS Filters](https://docs.aws.amazon.com/cli/latest/userguide/cli-usage-filter.html "URL for AWS Filters")

## Final Deliverable

**Note** the database launches and destroys will begin to take upwards of 5-15 minutes, meaning that each deploy with waiters could get to be 5-20 mins. Plan accordingly.

Submit the URL to the mp1 folder to Blackboard. Your week-06 repo will contain all three shell scripts but not the **arguments.txt** file (add arguments.txt to your `.gitignore`)

Add two screenshots, one of the initial load-balancer site rendering. The other showing the content of the upload in the your raw bucket.  Add these screen captures to your GitHub Repo
