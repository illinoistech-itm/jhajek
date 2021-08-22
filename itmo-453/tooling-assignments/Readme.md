# Tooling Setup Assignment

In this assignment there will be a series of tools you need to install to complete the work for this class. This document will outline what is needed.  The software categories are needed but no document can be exhaustive.  If you have a different software you prefer to use, as long as it gets the job done then there is no problem is using an alternative software.

## Sign Up for a GitHub.com Account

If you have not already signed up for a [GitHub.com](https://github.com "Github.com signup") account, do so.  We recommend using your name or some combination of your name, not your Hawk ID as this account is yours the rest of your life.  Once you have your ID, submit it on BlackBoard under Assignments >  Tooling Assignment and Setup > GitHub ID.  If you already have an ID, then just submit that ID.

## Installation of Tools for Windows 10

The following sections are for installation of tools on a Windows 10 PC, this is a list of the tools we will need installed on your laptop for this class:

* git
* VScode
* VirtualBox 6.x
* packer
* vagrant
* powershell-core
* (optional) vim

[The Chocolatey Windows 10 package manager](https://chocolatey.org "chocolatey package manager install page") allows for scripted installs of applications.  This tool is convenient for installing common applications such as Firefox, Android Studio, Java JDK, VS code, VirtualBox and other commonly installed tools.  You need to enable PowerShell scripts, which is shown via [the install instructions](https://chocolatey.org/install "Chocolatey install instructions").  Using a package manager allows for having scripted installations as well as a function to update software in place from the command line.

From PowerShell (not console or terminal!) with Administrative privileges, run this command to install chocolatey:

```PowerShell
Set-ExecutionPolicy Bypass -Scope Process -Force; `
[System.Net.ServicePointManager]::SecurityProtocol `
= [System.Net.ServicePointManager]::SecurityProtocol `
-bor 3072; iex ((New-Object `
System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
```

Upon finishing this command you will need to close the PowerShell terminal and reopen it with Administrative privileges again.  Once you have this done you can use the ```choco``` command to install Git amongst other software. Let us install some software we will use during the class.

```PowerShell
# from an admin console
choco install git vscode powershell-core virtualbox vagrant packer vim
```

### macOS - Git Installation of tools via Homebrew

The following sections are for installation of tools on a Windows 10 PC, this is a list of the tools we will need installed on your laptop for this class:

* git
* VScode
* VirtualBox 6.x
* packer
* vagrant

[Homebrew](https://brew.sh/ "macOS Homebrew webpage") is a third party package manager available for macOS.  This functions as a needed package manager and a way to install needed packages via an automated fashion. Using a package manager allows for having scripted installations as well as a function to update software in place from the command line.

To install `Homebrew` or `brew` run the below command:

```bash
/bin/bash -c \
"$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
```

For installing Git on a Mac, open the `terminal` app.  Run the command:

```bash
brew install git packer bash
brew cask install visual-studio-code virtualbox vagrant
```

## Git-It Tutorial

Download, extract, and execute the Git-it tutorial, located: [https://github.com/jlord/git-it-electron/releases](https://github.com/jlord/git-it-electron/releases "Git-it release tutorial").  The program runs as an executable so there is no installation needed and is cross platform.

Next we can download and extract the [Git-it Tutorial](https://github.com/jlord/git-it-electron/ "Git-it install Page"). Git-it is a desktop (Mac, Windows and Linux) app that teaches you how to use Git and GitHub on the command line.  Releases can be found under the [Release Tab](https://github.com/jlord/git-it-electron/releases "Git-it Download Releases").  Extract the file, execute the file `Git-it`. Upon a completion of the tutorial take a screenshot of your completion badge (or dots).

![*Git-it Completion Badge*](images/completed.png "Image of Git-it Badge Completion")

## Create and Push your Readme.md

Final step, is to clone the Private GitHub repo you have been provided with by the professor (you received an invite email to it).  If you already have a private repo provided by the professor from a previous class, just create a new folder named **itmo-453** or **itmo-553**, no spaces! Ever! and push your new folder along with a Readme.md file and a folder named **images**.  

This Readme.md will contain these elements written in Markdown. This is a good [Markdown cheatsheet reference](https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet "Markdown cheatsheet").

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
* h2 Git-It Badge
  * Place your Git-It Tutorial badge image here.

Push this to your GitHub private account repo.

Here is my own completed sample: [https://github.com/illinoistech-itm/jhajek/blob/master/README.md](https://github.com/illinoistech-itm/jhajek/blob/master/README.md "Professor's GitHub Repo Sample").  
**Note**, I will have more folders then you because I have sample code for more classes.

## Final deliverable to Blackboard

Submit to Blackboard the URL to your GitHub private repo, so I can clone and see all these elements.  Make sure to push code as you go and push this edited Readme.md file under the tooling-assignments folder.
