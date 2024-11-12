# Module 07

## Objectives

* Demonstrate the process of restoring an RDS instance from a snapshot
* Demonstrate the concept of deploying S3 buckets
* Demonstrate the IAM concepts needed for integrating cloud services for an application
* Demonstrate the termination of cloud resources in an automated fashion

## Links to Use

* [AWS CLI Reference](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/index.html "webpage aws cli sdk")
* [RDS](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/rds/index.html "RDS cli page")
* [Manage RDS Secrets with Secrets Manager](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/rds-secrets-manager.html#rds-secrets-manager-limitations "Manage RDS secrets with Secrets Manager")
* [Secrets Manager](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/secretsmanager/index.html "Secrets Manager cli page")
* [Python Boto3 AWS SDK](https://boto3.amazonaws.com/v1/documentation/api/latest/index.html "Python Boto3 AWS SDK")
* [AWS S3](https://aws.amazon.com/pm/serv-s3/?trk=fc204d25-9fcb-4256-8efb-9ff782ed1674&sc_channel=ps&s_kwcid=AL!4422!10!71468483144972!71469005976933&ef_id=8f4a25d3b1c210860c0542e0e288fd56:G:s&msclkid=8f4a25d3b1c210860c0542e0e288fd56 "Web page for AWS S3")
* [What is AWS S3](https://docs.aws.amazon.com/AmazonS3/latest/userguide/Welcome.html "webpage, what is AWS S3?")
* [AWS RDS Common Tasks - backup and restore](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_CommonTasks.BackupRestore.html "Webpage - AWS Common Tasks - backup and restore")
* [AWS CLI v2 RDS Restore from Snapshot](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/rds/restore-db-instance-from-db-snapshot.html "Webpage AWS RDS CLIv2 Restore from snapshot")
* [AWS EC2 Instance Profiles](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_use_switch-role-ec2_instance-profiles.html "webpage AWS EC2 Instance Profile")
* [IAM Role explained](https://devopscube.com/aws-iam-role-instance-profile/ "webpage IAM role explained")

## Manual Pre-reqs

* Launch a single EC2 instance
  * Use the same AMI we have been using all semester
  * No `user-data`
  * After SSHing to the instance, generate an `ed25519` keypair
  * Place the public key content of that keypair into your GitHub private repo as a [Deploy Key](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/managing-deploy-keys "webpage deploy key") 
  * Check your connection on the EC2 instance CLI with the command: `ssh git@github.com`
  * From the CLI of your own Vagrant Box, create a [custom AMI Image](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/ec2/create-image.html "webpage create custom AMI")
  * Copy newly generated AMI ID and replace previous AMI ID in your arguments.txt
* Create a single RDS instance using the parameters from previously assigned modules
  * On the EC2 instance still resident, install the package `mysql-client`
  * On the EC2 instance still resident clone the repository where you have the sample `create.sql` file
  * From the CLI execute the `mysql` command to execute the `create.sql` file from the directory it is located in
    * `mysql -h url-for-the-rds-instance -u the content of $19 -p < create.sql`
    * When prompted retrieve secrets password from Secrets Manager
  * Connect again and check that the tables have been created
  * From the CLI on your vagrant box, use the AWS CLI v2 to [create and RDS Snapshot](https://awscli.amazonaws.com/v2/documentation/api/2.0.34/reference/rds/create-db-snapshot.html "webpage to create an RDS snapshot") 
* Upon successful creation and availability of the custom AMI and snapshot, terminate the EC2 instance the image came from.

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
# ${13} module-07
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

Assume all the requirements from module-06 to be completed and this module's requirements will add on to module-06 and complete the pre-req section in this document. You will need to add additional IAM permissions for Secrets Manager, RDS, and S3.

## Part 1

Add to your `create-env.sh` logic needed to deploy 2 S3 buckets. Logic to add an instance profile to your launch template. Logic to launch an RDS instance from your existing snapshot.

## Part 2

Modify your `destroy-env.sh` to detach and destroy all resources launched during the `create-env.sh` process. Watch the waiter logic. Note that destroying a database takes 5-15 minutes. Plan accordingly. Though it will take extra time, make use of waiters for the RDS instances.

## Part 3

Modify your `install-env.sh` to clone your private repo and move the contents of `module-07` into the default `nginx` directory for serving webpages.

## Part 3

Using the [Python Boto3 AWS SDK](https://boto3.amazonaws.com/v1/documentation/api/latest/index.html "Python Boto3 AWS SDK") you will write an autograder script for this project. One for the `create-env.sh` named: `create-env-grader.py`, and one for the `destroy-env.py` named: `destroy-env-grader.py`. Print out information per item below to the screen and keep a grandtotal to print out your score out of 5.

For the `create-env-grader.py`:

* Check for the existence of one RDS instances
* Check for the existence of the **module-07** tag for the database instance~~s~~
* Check for the existence of one Secret in your Secrets Manager
* Check for the existence of two S3 buckets
* Check for the ELB to return an HTTP 200 upon request

For the `destroy-env-grader.py`:

* Check for the existence of zero Launch Templates
* Check for the existence of zero S3 buckets
* Check for the existence of zero ELBs
* Check for the existence of zero EC2 instances
* Check for the existence of zero RDS instances

## Deliverables

Create a folder named: `module-07` under your class folder in the provided private repo. Provide the following files:

* `create-env.sh`
* `destroy-env.sh`
* `install-env.sh`
* `create-env-test.py`
* `destroy-env-test.py`
  * I will test this script by using my own account information

Submit the URL to the `module-07` folder to Canvas.
