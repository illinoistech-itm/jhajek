# Tooling Assignment Vault

## Objectives

* Explain the problem that automation tooling for Linux solves
* Describe the problem of secrets management in automation deployment
* Demonstrate how Vault can be deployed on a network

## Outcomes

At the conclusion of this chapter you will have a basic understanding of how to use infrastructure automation and orchestration tools. You will be familiar and able to explain the concept of immutable infrastructure and will be able to use Linux commands for enabling cloud native development technologies.

### Tutorial Instructions

Issue a `git pull` command in the directory of your local copy of the `jhajek` sample code repos to get the sample code to complete this tutorial.

You will see two additional directories (For M1 macs and for x86/Intel Macs) under the ~~`example-code` > `advanced-tooling-examples`~~ `tooling-assignment-packer`

* `ubuntu_24043_apple_silicon_mac-vault-client-integration`
* `ubuntu_24043_vanilla-server-with-vault-integration`

You will find the tutorial instructions in Chapter 13.6 of the [Philosophy and Technology of Free and Opensource Software textbook](https://github.com/jhajek/Linux-text-book-part-1/releases/ "web page for download of Linux Textbook") -- free of charge (updates included).

Use the Vault-Server Vagrant box you created in the `packer-tooling-assignment` as your Vault server. Once Vault is installed and configured, you will create a final `ubuntu-server` that uses the secrets in your Vault server -- this will demonstrate that you can pass a secret to a brand new VM.

## Deliverable

Using the template provided: `Readme.md`, create a directory under the `itmt-430` directory named: `tooling-assignment-vault`, and add the two required screenshots, push to your private repo and  to the template and submit the URL to that document.
