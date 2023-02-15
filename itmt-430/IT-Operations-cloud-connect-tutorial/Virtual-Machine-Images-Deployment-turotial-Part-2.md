# Virtual Machine Images Deployment Turotial Part 2

This tutorial assumes you have completed the [IT Operations cloud connect tutorial](https://github.com/illinoistech-itm/jhajek/blob/master/itmt-430/IT-Operations-cloud-connect-tutorial/Readme.md "webpage for IT Operations Cloud Connect Tutorial").

## Overview

At the conclusion of this tutorial, you will have deployed 2 virtual machine instances from your Proxmox image templates using [terraform](https://terraform.io "webpage for terraform").

## Setup

The only setup needed is to copy the private key created in the previous tutorial into the directory where the `main.tf` file is located: `terraform` > `proxmox-jammy-ubuntu-front-back-template` > `main.tf`. This also assumes that you have copied the `terraform` directory from the `jhajek` sample code repo noted in the Packer-Tooling-Assignment.

## Terraform Structure and Nomenclature

Taken from [Terraform About page](https://developer.hashicorp.com/terraform/intro "webpage for Terraform about page"):

### What is Terraform?
Terraform is an infrastructure as code tool that lets you build, change, and version cloud and on-prem resources safely and efficiently.

> HashiCorp Terraform is an infrastructure as code tool that lets you define both cloud and on-prem resources in human-readable configuration files that you can version, reuse, and share. 

> You can then use a consistent workflow to provision and manage all of your infrastructure throughout its lifecycle. Terraform can manage low-level components like compute, storage, and networking resources, as well as high-level components like DNS entries and SaaS features.

### How does Terraform work?

> Terraform creates and manages resources on cloud platforms and other services through their application programming interfaces (APIs). Providers enable Terraform to work with virtually any platform or service with an accessible API.

### Core Terraform Concepts

The core Terraform workflow consists of three stages:

* Write: 
  * You define resources, which may be across multiple cloud providers and services.
  * For example, you might create a configuration to deploy an application on virtual machines in a Virtual Private Cloud (VPC) network with security groups and a load balancer.
* Plan: 
  * Terraform creates an execution plan describing the infrastructure it will create, update, or destroy based on the existing infrastructure and your configuration.
* Apply: 
  * On approval, Terraform performs the proposed operations in the correct order, respecting any resource dependencies. 
  * For example, if you update the properties of a VPC and change the number of virtual machines in that VPC, Terraform will recreate the VPC before scaling the virtual machines.

You can see our example here: [Terraform Plan](https://github.com/illinoistech-itm/jhajek/blob/master/itmt-430/example-code/proxmox-cloud-production-templates/terraform/proxmox-jammy-ubuntu-front-back-template/main.tf "webpage for Terraform plan").

## Terraform Example

Now let us take a look at the structure of our example Terraform plans.  The plan is setup to create X number of virtual machine instances. The programing and structure will remind you of Packer. In fact, Hashicorp has intentionally made them vastly similar.

There are four files to consider:

* `main.tf`
  * This is the main plan file -- similar in function to a Packer build template *.pkr.hcl
* `provider.tf`
  * This is similar to the `init block` in the packer build template, that tells Terraform which version and any provider plugins to download
  * In this case we will be downloading the Proxmox Provider in addition to the a random number generator plugin
* `template-terraform.tfvars`
  * This file is where you will place secrets and variables to customize configuration. The file will need to be renamed from `template-terraform.tfvars` to `terraform.tfvars` on the buildserver
  * `terraform.tfvars` is part of the .gitignore, so as not to pass secrets via version control.
  * You will enter the Cloud Credentials the IT/Ops person received here
* `variables.tf`
  * Every varialbe that exists in the terraform.tfvars file needs to exist here, this file is for assigning default values and allowing for a commandline runtime override of variables set in `terraform.tfvars`