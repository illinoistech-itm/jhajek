# MP1 (Week-09) Lab

## Objectives

* Create and deploy elastic infrastructure components on the AWS Cloud
  * Including EC2, EBS, RDS, ELB, and Target Groups
* Understand and demonstrate the security implications and enable the proper IAM permissions to use these resources
* Understand and demonstrate the use of the Linux Commandline and AWS CLI tools for launching infrastructure
* Understand and demonstrate the requirements for building a three-tier application
* Understand and demonstrate the use of the AWS CLI tools for terminating/destroying all resources dynamically with a single command -- using queries and filters

## Outcomes

At the conclusion of this Lab you will have successfully and securely deployed a three-tier elastic application via cloud native methods.   You will have demonstrated the use of queries and filters for dynamically querying instance information for use in deployment and termination/destruction of said cloud resources.

## Assumptions

For this assignment you can make these assumptions

* The I we are all using us-east-2 as our default region
* That the access keys are already created and not needed in this script
* That the security-group has been already created and all of the proper ports are open
* That the proper IAM minimal user permissions are set in for your IAM user

## Deliverable

Create a folder named: **mp1** under your class folder in the provided private repo. In the folder there will be three shell scripts:

* A script named: `create-env.sh`
  * This script will deploy, configure, and create all the AWS infrastructure our three-tier application needs
* A script named: `install-app.sh`
  * This script will install all the application components and format EBS volumes
* A script named: `destroy-env.sh`
  * This script will terminate all infrastructure you have created

### create-env.sh

This is shell script will take commandline input dynamically via positional parameters ($1 $2 $3 and so on) via a file named `arguments.txt`.  For a refresh on positional parameters [see my text book](https://github.com/jhajek/Linux-text-book-part-1/releases/tag/2021-09-29 "Link to Linux Textbook") starting on page 179 PDF.

```./create-env.sh $(<arguments.txt)```

```bash
# Hint on how to cycle through 2 arrays in one forloop in Bash
#https://stackoverflow.com/questions/17403498/iterate-over-two-arrays-simultaneously-in-bash

for i in "${!array[@]}"; do
    printf "%s is in %s\n" "${array[i]}" "${array2[i]}"
done

```

### arguments.txt

This is where you will pass the arguments (space delimited) as follows (order is **very** important)

* image-id
* instance-type
* count
* key-name
* user-data
* Target-group name (use tg as a prefix )
* Load-balancer name (us elb and your initial as a prefix)
* DB instance identifier
* DB instance class - choose db.t2.micro (free tier)
* DB Engine (choose mariadb)
* DB Master username
* DB Master user password
* DB allocated-storage (choose 20)

I will grade your logic by running it with my account configuration information, no hard-coded values.

### install-env.sh

This will contain the shell script to install the nginx webserver and the zfs-utils to format the EBS volumes

### destroy-env.sh

Using AWS CLI v2 filters filter the instance you created and destroy it.  A single running of `destroy-env.sh` will terminate all of the resources that your `install-env.sh` script launched.

[AWS Filters](https://docs.aws.amazon.com/cli/latest/userguide/cli-usage-filter.html "URL for AWS Filters")

## Final Deliverable

Submit the URL to your mp1 folder on Blackboard.  Your mp1 repo will contain all three shell scripts but not the **arguments.txt** file.

I will grade your logic by running it with my account configuration information, no hard-coded values. **destroy-env.sh** must work!
