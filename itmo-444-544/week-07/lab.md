# Week-07 Lab

## Objectives

* Create and Implement logic to create and destroy a cloud-native three tier web-application
* Deploy and demonstrate the concept of auto-scaling groups in relation to load-balancing
* Integrate and discuss the nature of AWS RDS
* Discuss the nature of Cloud Native state and demonstrate the concept using RDS Read-Replicas
* Implement AWS query filters

## Outcomes

At the conclusion of this Lab you will have successfully created and destroyed a cloud native three-tier application via the AWS CLI using positional parameters in a shell script. You will have deployed and interfaced with the concept of state in deploying Relational Database Services with Read-Replicas. Finally you will have concluded your cloud native development by working with Auto-Scaling groups in conjunction with load-balancers.

## Assumptions

For this assignment you can make these assumptions

* Start by copying your code from week-06 into your week-07 directory
  * `create-env.sh`, `destroy-env.sh`, and `install-env.sh`
* We will all be using `us-east-2` as our default region - update this if needed in your `aws configure`
* That the access keys are already created and not needed in this script
* That the security-group has been already created and all of the proper ports are open

## Deliverable

Create a folder named: week-07 under your class folder in the provided private repo. In the folder there will be three shell scripts. There will be modifications from your week-06 code, more features to add and some to remove. Try no to leave old code commented out in your week-07 folder.

* A script named: `create-env.sh`
  * In addition to the previous weeks requirements, you will need to deploy the following:
  * 1 RDS instance
    * size `db.t3.micro`
    * engine `mariadb`
    * master-user-password `cluster168`
    * master username `wizard`
    * --db-name `customers`
  * Create 1 RDS read-replica
  * One auto-scaling group
    * 1 launch configuration
    * Min 2, max 5, desired 3
* A script named: `destroy-env.sh`
  * This script will terminate **all** infrastructure you have created and **must work**.

### create-env.sh

This is shell script will take commandline input dynamically via positional parameters ($1 $2 $3 and so on) via a file named `arguments.txt`. For a refresh on positional parameters [see my text book](https://github.com/jhajek/Linux-text-book-part-1/releases/tag/2021-09-29 "Link to Linux Textbook") starting on page 179 PDF.

You can access positional parameters after `$9` by using `${10}`. You can hard code the user-data flag to be the value: `file://install-env.sh`

Run your script in this fashion:

```./create-env.sh $(<arguments.txt)```

### arguments.txt

This is where you will pass the arguments (space delimited) as follows (order is **very** important)

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

These values we will dynamically query for

* subnet-id (1)
* subnet-id (2)
* vpc-id

### How to filter for state running

`aws ec2 describe-instances --filters Name=instance-state-name,Values=running` and can be combined with Queries.  Filters filter your results, query is what you ask Amazon to select for you.

### Grading

I will grade your logic by running it with my account configuration information, no hard-coded values.

### install-env.sh

This will contain the same content as last week's assignment:

### destroy-env.sh

Using AWS CLI v2 filters filter the instance you created and destroy it.  A single running of `destroy-env.sh` will terminate all of the resources that your `install-env.sh` script launched.

[AWS Filters](https://docs.aws.amazon.com/cli/latest/userguide/cli-usage-filter.html "URL for AWS Filters")

## Final Deliverable

**Note** the database launches and destroys will begin to take upwards of 5-15 minutes, meaning that each deploy with waiters could get to be 5-20 mins. Plan accordingly.

Submit the URL to the week-07 folder to Blackboard. Your week-06 repo will contain all three shell scripts but not the **arguments.txt** file (add arguments.txt to your `.gitignore`)
