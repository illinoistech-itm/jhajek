# Tutorial Explanation for Deployment of a Three Tier Applicaton With Secrets

This tutorial will go over step by step the deployment and automation of a three tier application including secrets

## Objectives

* Explain and discuss the common problems in creating a three-tier app
* Explain the structures provided by Packer to help automate the creation of a three-tier app
* Explain the methods used to pass secrets
* Explain the user installation process concerning cloud-init (all cloud computing uses this)

## Outcomes

At the conclusion of the review of this working end-to-end sample, you will have been exposed to the common problems when moving an application from a manual deployment to an automated deployment. You will have engaged with methods to pass secret and see their pros and cons, and finally you will have understood cloud-init and its permissions structure.

### Parts of the App

For this example you will find a working prototype three-tier application that has:

* A simple EJS webapp
* Nginx load-balancer
* TLS cert (selfsigned)
* MariaDB database
  * With a populated table
* Secrets passed in via Packer's environment_vars command

You will find the sample infrastrucutre code in the jhajek repo. You will find the sample application code, nginx configs, and SQL files in the team00 repo.  The team00 repo I made public so that you could inspect the code. Note, there are values that need to be changed, you can't take it wholesale and expect it to work. Also it is templated so there won't be any secrets embedded--resist the temptation, I will show you how it works in the course of this tutorial.

## Summary and Conclusion

This sprint is a long one, but important as we are beginning to create an actual working cloud native application. Continue to make use of the principles we are learning in the DevOps handbook and keep working at this--soon you will see the fruits of your labors.
