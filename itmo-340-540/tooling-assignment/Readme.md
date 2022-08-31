# Tooling Assignment

## Objectives

* Discuss and describe modern IT tooling
* Learn and describe the advantage using modern package managers on Windows and MacOS for tooling install
* Demonstrate the advantages of using version control for documentation distribution
* Learn and discuss the use of Markdown for text based document creation

## Outcome

At the end of this assignment you will have become familiar with industry standard package managers for Windows and MacOS and be able to install standard tooling. This will be achieved by following a small demo and some small tutorials.

## Overview

Complete the required installs in this document via a Package Manager and take a screenshot of the proper output to show a successful install. Place the screenshot into this document markdown template.

In this assignment there will be a series of tools you need to install to complete the work for this class. This document will outline what is needed. The software categories are needed but no document can be exhaustive. If you have a different software you prefer to use, as long as it gets the job done then there is no problem is using an alternative software.

## Installation of Tools for Windows 10 and 11

The following sections are for installation of tools on a Windows 10/11 PC, this is a list of the tools we will need installed on your laptop for this class:

* Git
* VScode
* VirtualBox 6.x
* Vagrant
* Powershell-core (7.x)
* Microsoft Terminal
* Wireshark

[The Chocolatey Windows 10/11 package manager](https://chocolatey.org "chocolatey package manager install page") allows for scripted installs of applications.  This tool is convenient for installing common applications such as Firefox, Android Studio, Java JDK, VS code, VirtualBox and other commonly installed tools.  You need to enable PowerShell scripts, which is shown via [the install instructions](https://chocolatey.org/install "Chocolatey install instructions").  Using a package manager allows for having scripted installations as well as a function to update software in place from the command line.

From PowerShell (not `CMD`) with Administrative privileges, run this command to install chocolatey:

```PowerShell
Set-ExecutionPolicy Bypass -Scope Process -Force; `
[System.Net.ServicePointManager]::SecurityProtocol `
= [System.Net.ServicePointManager]::SecurityProtocol `
-bor 3072; iex ((New-Object `
System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
```

Upon finishing this command you will need to close the PowerShell terminal and reopen it with Administrative privileges again.  Once you have this done you can use the ```choco``` command to install Git amongst other software. Let us install some software we will use during the class.

```PowerShell
choco install powershell-core microsoft-windows-terminal git vscode vscode-powershell virtualbox vagrant wireshark
```

### macOS - Git Installation of tools via Homebrew

The following sections are for installation of tools on a MacOS Laptop x86 and M1 (where noted), this is a list of the tools we will need installed on your laptop for this class:

* Git
* VScode
* VirtualBox 6.x
* Vagrant
* iterm2
* WireShark

[Homebrew](https://brew.sh/ "macOS Homebrew webpage") is a third party package manager available for macOS.  This functions as a needed package manager and a way to install needed packages via an automated fashion. Using a package manager allows for having scripted installations as well as a function to update software in place from the command line.

To install `Homebrew` or `brew` run the below command:

```bash
/bin/bash -c \
"$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
```

For MacOS using Homebrew:

```bash
brew install brew install --cask iterm2 ; brew install git ; brew install --cask visual-studio-code ; brew install virtualbox ; brew install --cask vagrant ; brew install wireshark
```

For M1 Macs you will run the same as above but without the VirtualBox install:

```bash
brew install brew install --cask iterm2 ; brew install git ; brew install --cask visual-studio-code ; brew install --cask vagrant ; brew install wireshark
```

### M1 Virtualization

* For M1 Macs you will need to make a purchase of a copy of Parallels Pro or Enterprise edition
  * [https://www.parallels.com/products/desktop/pro/](https://www.parallels.com/products/desktop/pro/ "Parallels Pro Edition")
  * The standard and education edition doesn't contain the commandline interface needed for automation.
* Once Vagrant and Parallels Pro Edition is installed you need to also install the Parallels SDK from the Download Tab in your parallels.com account
  * From the Terminal run the command: `vagrant plugin install vagrant-parallels`
    * This will add the needed plugin to allow you to use Parallels from Vagrant
    * This will also work if you have Parallels Pro Edition on an Intel Mac

## Create and Push your Readme.md

Final step, is to clone the Private GitHub repo you have been provided with by the professor (you received an invite email to it).  If you already have a private repo provided by the professor from a previous class, just create a new folder named **itmo-340** or **itmo-540**, no spaces! Ever! and push your new folder along with a Readme.md file and a folder named **images**.  

This Readme.md will contain these elements written in Markdown. This is a good [Markdown cheat sheet reference](https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet "Markdown cheatsheet").

The document will include:

* h1 with your name
  * a picture of you
  * a picture of something that describes you
* h2 Where are you from?
  * Tell us where you are from
* h2 IT Interests
  * Tell us what you IT Interests and or skills are
* h2 Something Interesting About You
  * Tell us something interesting about you
* What was your first computing device?

Push this to your GitHub private account repo.

Here is my own completed sample: [https://github.com/illinoistech-itm/jhajek/blob/master/README.md](https://github.com/illinoistech-itm/jhajek/blob/master/README.md "Professor's GitHub Repo Sample").  
**Note**, I will have more folders then you because I have sample code for more classes.

### Create a .gitignore file

Every Git repository needs a `.gitignore` file.  This file tells Git to ignore certain files.  These are files that are too large, binary format, or things like security keys and passwords, that we don't want to be committing to our Git Repos.

We will create a file named: `.gitignore` and place the following values into it and add, commit, and push the file to your private repo.

```bash
# Files, Folders, security keys, and Binaries to ignore

*.vdi
*.box
.vagrant/
*console.log
packer-cache/
packer_cache/
*.pem
*~$
*.ova
output*/
vagrant.d/
*.iso
variables.pkr.hcl
*.priv
variables.json
.DS_Store
id_rsa
id_rsa*
id_rsa.pub
.Vagrantfile*
Vagrantfile~
config.default.yml
```

## Final deliverable to Blackboard

Submit to Blackboard the URL to your GitHub private repo, so I can clone and see all these elements. Make sure to push code as you go and push this edited Readme.md file under the tooling-assignments folder.
