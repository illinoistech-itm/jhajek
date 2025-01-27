# Tooling Assignment Vault

## Objectives

* Explain the problem that automation tooling for Linux provides
* Identity Current orchestration and automation tools
* Explain the role of Hashicorp in the realm of automation tools
* Describe the process to automate the installation of Linux Operating Systems
* Explain the concept of secrets management in automation
* Identify a solution for deploying complete applications using automation tooling on Linux

## Outcomes

At the conclusion of this chapter you will have a basic understanding of how to use infrastructure automation and orchestration tools. You will be familiar and able to explain the concept of immutable infrastructure and will be able to use Linux commands for enabling cloud native development technologies.

### Tutorial Instructions

Issue a `git pull` command in the directory of your local copy of the `jhajek` sample code repos to get the sample code to complete this tutorial.

You will see two additional directories (For M1 macs and for x86/Intel Macs) under the `example-code` > `advanced-tooling-examples`

* `ubuntu_22045_m1_mac-vault-example`
* `ubuntu_22045_vanilla-vault-example`

You will find the tutorial instructions in Chapter 13.6 of the [Philosophy and Technology of Free and Opensource Software textbook](https://github.com/jhajek/Linux-text-book-part-1/releases/ "web page for download of Linux Textbook") -- free of charge (updates included).

You should use either the `jammy64` Vagrant Box as your Vault server or you can use the Vagrant box you built with Packer as part of the Packer Advanced Tutorial (recommended).

Once Vault is completed you will execute the Packer tutorial again using the the new example directories and demonstrate that you have created secrets in Vault and integrated and built a Virtual Machine and shared secrets via Packer.

## Deliverable

Using the template provided: `Readme.md`, create a direcrtory under the `itmt-430` directory named: `tooling-assignment-advanced-vault`, and add the two required screenshots, push to your private repo and  to the template and submit the URL to that document.
