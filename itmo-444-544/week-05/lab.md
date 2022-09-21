# Week-05 Lab

## Objectives

* Demonstrate the creation of a managed shell script for the deployment of cloud resources
* Demonstrate the termination of cloud resources in an automated fashion
* Demonstrate the use of positional parameters for dynamic variable creation in a shell script

## Steps to take

From the AWS Cli on your Vagrant Box

* Pass all variables via the commandline and access them via positional parameters
  * Create and add a new key-pair
  * Create a security group and open remote ports
  * Create an EC2 instance that installs Nginx webserver
* Create a script that will terminate all your launched resources

## Deliverables

Create a folder named: `week-05` under your class folder in the provided private repo. In the folder there will be three shell scripts:

* `create-env.sh`
  * This script will create an EC2 instance that installs an Apache Web Server on launch
  * A second shell script named: `install-env.sh` will install the Apache 2 webserver
* `destroy-env.sh`
  * This script will terminate all infrastructure you have created
* I will test this script by using my own account information

Submit the URL to the week-05 folder to Blackboard
