# Week-15 Mini-Project 2

## Objectives

* Deploy your infrastructure using Hashicorp Terraform
* Deploy and explain IAM profile instance attachments
* Deploy and configure a custom EC2 image
* Deploy and make use of SND and DynamoDB features
* Configure and explore Cloud Security using AWS Secrets management

## Outcomes

Building upon the previous labs accomplishments, at the conclusion of this Mini-Project (MP) you will have successfully created, deployed, and destroyed a cloud native three-tier application via the AWS CLI using positional parameters in a shell script. Our goals will include adding VPC subnetting for our database application, creating custom EC2 instances and, deploying a sample JavaScript Application.  We will further connect the application with S3 buckets, for storage of uploaded media. You will have deployed and interfaced with the concept of state in deploying Relational Database Services with Read-Replicas. Finally you will have concluded your cloud Native development by working with Auto-Scaling groups in conjunction with load-balancers.

## Assumptions

For this assignment you can make these assumptions

* Reuse your `install-env.sh` from mp1 into a folder named mp2
 *  Use the app.js provided in the jhajek sample code repo
* We will all be using `us-east-2` as our default region - update this if needed in your `aws configure`
* That the access keys are already created and not needed in this script
* You will use the security-group has been already created and all of the proper ports are open
  * You will in your create-env.sh script provide the creation of two more security groups for the database ingress and egress

## Deliverable

Create a folder named: `mp2` under your class folder in the provided private repo.  Try not to leave uneeded files, samples, or old code commented out in your assignments. Make it clean.

* The proper Terraform files needed to create the infrastructure
* Your `install-env.sh`
* Any additional policy files

### create-env.sh

This is shell script will take commandline input dynamically via positional parameters ($1 $2 $3 and so on) via a file named `arguments.txt`. For a refresh on positional parameters [see my text book](https://github.com/jhajek/Linux-text-book-part-1/releases/tag/2021-09-29 "Link to Linux Textbook") starting on page 179 PDF.

You can access positional parameters after `$9` by using `${10}`. You can hard code the user-data flag to be the value: `file://install-env.sh`

Run your script in this fashion:

```./create-env.sh $(<arguments.txt)```

### New create-env.sh requirements

In addition the previous mp1's requirements you will need to add or modify:

* Replace the `create-env.sh` and `destroy-env.sh` with a single terraform plan to create and destroy your infrastructure
  * Provided in the sample code repo -- make adjustments in the case of hard coded emails and bucket names
* Enable SNS subscription to a created topic for a user
* Create a DynamoDB table 
* Grant your user DynamoDB and SNS IAM permissions
* Update NPM package installs to support DynamoDB and SNS
* Remove the RDS implementations and use DynamoDB
  * Remove all RDS code from your app.js
* Update your destroy script accordingly
* Demonstrate the process of uploading and image
  * Render the /db URL
  * Render the /gallery URL
  * Render the /upload URL

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
1) sns topic name
1) dynamodb table name

These values we will dynamically query for

* subnet-id (1)
* subnet-id (2)
* vpc-id

### Links

* ~~[RDS](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/rds/index.html "webpage RDS CLI")~~
* [Auto-Scaling Groups](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/autoscaling/index.html "webpage auto-scaling groups")
* [AWS IAM](https://docs.aws.amazon.com/IAM/latest/UserGuide/introduction.html "webpage for AWS IAM")
* [S3](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/s3/index.html "webpage for S3 aws cli")
 * [Secrets Manager](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/secretsmanager/index.html "documentation for AWS seecrets manager")
* [SNS](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/sns/index.html "webpage for SNS aws cli")
* [DynamoDB](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/dynamodb/index.html "webpage for DynamoDB")

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

**Note** the database launches and destroys will begin to take upwards of 5-15 minutes, meaning that each deploy with waiters could get to be 20 mins. Plan accordingly. For those in the itmo 544-01 (live) section you will come to class and demonstrate your deploy from a completely destroyed application. You will be asked 2 or 3 questions about the functionality of your site, understand the code your were given and be prepared to answer how it works.

In addition you will demonstrate:

* Demonstrate the process of uploading and image
* Demonstrate your Terraform script by applying and destroying (after the below items are demonstrated)
* Show the SNS subscription message
* Render the /db URL
* Render the /gallery URL
* Render the /upload URL

If you are in the itmo-544 02 online section - you will need to record a video of yourself (camera on for verification purposes) demonstrating the live requirements listed above and submit a URL to that video along with your GitHub repo URL.

**Due: Wednesday December 6th 2:00 PM**
