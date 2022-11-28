# Final Project (MP2) ITMO 544

## Objectives

* Configure and explain VPC subnetting in the AWS Cloud
* Deploy and configure a custom EC2 image
* Deploy and explain how to clone application code via Git
* Configure and explore Cloud Security using AWS Secrets management
* Configure SNS service to send notifications via text or email
* Explore and demonstrate the use of the AWS JavaScript SDK and interact with Cloud Services from the application level

## Outcomes

At the conclusion of this Mini-Project (MP) you will have successfully created, deployed, and destroyed a cloud native three-tier application via the AWS CLI using positional parameters in a shell script. You will have deployed a sample JavaScript Application and attached Cloud Native services to the application. Finally you will have concluded your cloud native development by working with Auto-Scaling groups in conjunction with load-balancers.

## Assumptions

For this assignment you can make these assumptions

* Start by copying your code from **mp1** into a directory named: **mp2**
  * `create-env.sh`, `destroy-env.sh`, and `install-env.sh`
  * Along with the provided `app.js` and `index.html`
  * Adjust line 25 in `install-env.sh`
* That the access keys are already created and not needed in this script
* You will use the security-group has been already created and all of the proper ports are open
* On your Vagrant Box make sure to install mysql-client (not the full mysql server) so you can connect to your database and import the create.sql
* Make sure your IAM profile has RDS access and Secrets Access
* Make sure your Security Group has MySQL port access

## Deliverable

Create a folder named: `mp2` under your class folder in the provided private repo.  Try not to leave uneeded files, samples, or old code commented out in your assignments. Make it clean.

* A script named: `create-env.sh`
  * In addition to the previous weeks requirements, you will need to deploy the following:
* A script named: `destroy-env.sh`
  * This script will terminate **all** infrastructure you have created and **must work**
* A script named: `install-env.sh`
  * We will clone our sample JavaScript application
  * Install dependencies
  * Install at infrastructure boot time

### install-env.sh

* Install mysql2 via NPM
  * [Usage](https://www.npmjs.com/package/mysql2 "webpage npm2 usage")
  
### create-env.sh

Run your script in this fashion:

```./create-env.sh $(<arguments.txt)```

Once the database has been created and is in a running state (waiters) use the command: `sudo mysql --user $USERNAME --pass $PASSWORD --host (place the retrieved Mariadb main URL here) < create.sql`  

Retrieve the Database URL via Query

### app.js

This file -- in addition to the `mp1` requirements. will make some modifications to the finished structure. This code you will dynamically detect the name of the S3 bucket. JavaScript has a `.startsWith()` function that can be used to find your `raw-` prefix

1. Starting at Line 47 - the `/gallery` function you need to loop through the content of your raw bucket and using HTML display all the images in the bucket. Do this with the AWS JavaScript SDK and the `res.write()` to print to the screen
2. Update line 57 to not have a hardcoded URL but the full URL of the item just posted.
3. Starting line 69 create code to register the users phone (SMS) or email and receive a message with the S3 URL of the Photo
4. after SNS sent - insert database record
5. create a /db route which will select * all the records in your database and print to the screen
6. in /upload function - line 47, List Secrets, get the name of the secret, get the username and password
7. Make a mysql2 connection to the database, retrieve the connection URLs from JavaScript AWS SDK

### index.html

1. Create the additional required Form fields listed in the comment

### Disclaimer

I know we are cutting a lot of Security corners - I want you to be aware of them as we go.

### Pre-reqs

* Assume that you will be continuing from MP1
* Make a small adjustment in the naming of your S3 buckets, start with the term `raw-` then your initials

### New create-env.sh requirements

* You will need to add SNS permission to your IAM profile Role attached to your EC2 instances before you start
* You will need to create an SNS topic in your `create-env.sh`. [Documentation is here](https://docs.aws.amazon.com/cli/latest/userguide/cli-services-sns.html "webpage for AWS SNS cliv2").

### Arguments.txt

This is where you will pass the arguments (space delimited) as follows (order is **very** important)

1. image-id
1. instance-type
1. key-name
1. security-group-ids
1. count (3)
1. availability-zone
1. elb name
1. target group name
1. auto-scaling group name
1. launch configuration name
1. db instance identifier (database name)
1. db instance identifier (for read-replica), append *-rpl*
1. min-size = 2
1. max-size = 5
1. desired-capacity = 3
1. Database engine (use mariadb)
1. Database name ( use company -- needs to match the value give the the CREATE DATABASE in create.sql )
1. s3 raw bucket name (raw-your initials)
1. s3 finished bucket name (fin-your initials)
1. aws secret name
1. iam-instance-profile
1. SNS topic name

These values we will dynamically query for

* subnet-id (1)
* subnet-id (2)
* vpc-id

### How to filter for state running

`aws ec2 describe-instances --filters Name=instance-state-name,Values=running` and can be combined with Queries. Filters are when you filter your results, A Query is what you ask Amazon to select for you.

### Grading

I will grade your logic by running it with my account configuration information, no hard-coded values.

### install-env.sh

See provided template for installing expressJS dependencies

### destroy-env.sh

Using AWS CLI v2 filters filter the instance you created and destroy it.  A single running of `destroy-env.sh` will terminate all of the resources that your `install-env.sh` script launched.

[AWS Filters](https://docs.aws.amazon.com/cli/latest/userguide/cli-usage-filter.html "URL for AWS Filters")

## Final Deliverable

**Note** the database launches and destroys will begin to take upwards of 5-15 minutes, meaning that each deploy with waiters could get to be 5-20 mins. Plan accordingly.

Submit the URL to the mp1 folder to Blackboard. Your `mp2` repo will contain all three shell scripts but not the **arguments.txt** file (add arguments.txt to your `.gitignore`)
