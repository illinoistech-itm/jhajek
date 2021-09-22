# Week-03 Lab

## Objectives

* Learn how to create personal Amazon Web Services account
* Learn how to use Identity and Access Management to create a non-root user

## Steps to take

From the AWS Cli:

* Create and add a new key-pair
* Create a security group and open remote ports
* Create an EC2 instance that installs Apache2 webserver
* Create a script that will terminate all your launched resources

## Deliverables

Create a folder named: week-03 under your class folder in the provided private repo. In the folder there will be three shell scripts:

* create-env.sh
  * This script will create an EC2 instance that installs an Apache Web Server on launch
  * A second shell script named: install-env.sh will install the Apache 2 webserver
* destroy-env.sh
  * This script will terminate all infrastructure you have created

Submit the URL to the week-03 folder to Blackboard
