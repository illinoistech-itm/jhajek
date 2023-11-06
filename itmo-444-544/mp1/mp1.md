# Week-11 Mini-Project 1

## Objectives

* Deploy and explain the IAM permission hierarchy for S3 bucket access
* Deploy and explain IAM profile instance attachments
* Configure and explain VPC subnetting in the AWS Cloud
* Deploy and configure a custom EC2 image
* Deploy and explain how to clone application code via Git
* Configure and explore Cloud Security using AWS Secrets management

## Outcomes

Building upon the previous labs accomplishments, at the conclusion of this Mini-Project (MP) you will have successfully created, deployed, and destroyed a cloud native three-tier application via the AWS CLI using positional parameters in a shell script. Our goals will include adding VPC subnetting for our database application, creating custom EC2 instances and, deploying a sample JavaScript Application.  We will further connect the application with S3 buckets, for storage of uploaded media. You will have deployed and interfaced with the concept of state in deploying Relational Database Services with Read-Replicas. Finally you will have concluded your cloud Native development by working with Auto-Scaling groups in conjunction with load-balancers.

## Assumptions

For this assignment you can make these assumptions

* Start by copying your code from week-09 into a directory named: **mp1**
  * `create-env.sh`, `destroy-env.sh`, and `install-env.sh`
  * Along with the provided `app.js` and `index.html`
* We will all be using `us-east-2` as our default region - update this if needed in your `aws configure`
* That the access keys are already created and not needed in this script
* You will use the security-group has been already created and all of the proper ports are open
  * You will in your create-env.sh script provide the creation of two more security groups for the database ingress and egress
* Use AWS Secrets to retrieve username and password for the Maria SQL Database
  * When creating the RDS instance use the retrieved secrets values for `master-user-password` and `master username`

## Deliverable

Create a folder named: `mp1` under your class folder in the provided private repo.  Try not to leave uneeded files, samples, or old code commented out in your assignments. Make it clean.

* A script named: `create-env.sh`
  * In addition to the previous weeks requirements, you will need to deploy the following:
  * 1 RDS instance
    * size `db.t3.micro`
    * engine `mariadb`
    * ~~master-user-password `cluster168`~~
    * ~~master username `wizard`~~
    * --db-name `customers`
  * Create 1 RDS read-replica
  * One auto-scaling group
    * 1 launch configuration
    * Min 2, max 5, desired 3
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

### New create-env.sh requirements

* Create an AWS Secret Manager file
  * Use JSON template to enter your secrets for the mariadb.json file
* Add new npm installs for `uuid4`, `@aws-sdk/client-rds` and `mysql2/promise`
* Use the provided SQL file to create a database and a table via the install-env.sh script using *inline* MySQL commands (`mysql -e`)
* Create JavaScript code in `app.js` that uses the AWS JavaScript SDK to
  * Insert a record into your database using the data your have posted in your form
  * Create a `/gallery` route that will display that images from your S3 buckets in the `app.js`
* Create additional code using the JavaScript AWS SDK using these functions to retrieve the needed values
  * listObjects
  * insertRecords
  * getDBIdentifier
  * getSecrets


### arguments.txt

This is where you will pass the arguments (space delimited) as follows (order is **very** important). **Note:** updated arguments.txt order 11/07

1) image-id
1) instance-type
1) key-name
1) security-group-ids
1) count
1) user-data file name
1) availability-zone 1 (choose a)
1) elb name
1) target group name
1) availability-zone 2 (choose b)
1) auto-scaling group name
1) launch configuration name
1) db instance identifier (database name)
1) db instance identifier (for read-replica), append *-rpl* to the database name
1) min-size = 2
1) max-size = 5
1) desired-capacity = 3
1) iam-profile
1) s3-raw-bucket-name
1) s3-finished-bucket-name
1) aws secret name

These values we will dynamically query for

* subnet-id (1)
* subnet-id (2)
* vpc-id

### Links

* [RDS](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/rds/index.html "webpage RDS CLI")
* [Auto-Scaling Groups](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/autoscaling/index.html "webpage auto-scaling groups")
* [AWS IAM](https://docs.aws.amazon.com/IAM/latest/UserGuide/introduction.html "webpage for AWS IAM")
* [S3](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/s3/index.html "webpage for S3 aws cli")
 * [Secrets Manager](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/secretsmanager/index.html "documentation for AWS seecrets manager")

### IAM permissions

You will need to add new IAM permissions for your user (Secrets) and for your Role/IAM Profile (Secrets).

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
