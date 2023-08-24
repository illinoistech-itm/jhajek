# Markdown and Git Assignment

## Objectives

* Learn and describe the advantage using modern package managers on Windows and MacOS for tooling install
* Demonstrate the advantages of using version control for documentation distribution
* Learn and discuss the use of Markdown for text based document creation

## Outcome

At the end of this assignment you will have become familiar with industry standard package managers for Windows and MacOS and be able to install standard tooling used in Cloud Native application development. This will be achieved by following a small demo and some small tutorials.

### Create and Push your Readme.md

In this step you will clone the Private GitHub repo you have been provided with by the professor (you received an invite email to it) to your local system.  In the root of this repo you will create a file named `Readme.md` and a folder named **images**. This `Readme.md` will contain the elements below written in Markdown. This is a good [Markdown cheat-sheet reference](https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet "Markdown cheatsheet").

The document will include:

* h1 with your name
  * a picture of you
  * a picture of something that describes you
* h2 Where are you from?
  * Tell us where you are from
* h2 What was your first computing device?
* h2 IT Interests
  * Tell us what you IT Interests and or skills are
* h2 Something Interesting About You
  * Tell us something interesting about you

Push this to your GitHub private account repo.

Here is my own completed sample: [https://github.com/illinoistech-itm/jhajek/blob/master/README.md](https://github.com/illinoistech-itm/jhajek/blob/master/README.md "Professor's GitHub Repo Sample").  **Note**, I will have more folders then you because I have sample code for more classes.  If you have previously completed this assignment, no need to do anything unless you want to update the information.

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

### Adding Screenshots

Using the Readme.md template file provided under the Assignment Tab > Week-01 in Blackboard, add your screenshots to the `Readme.md` and commit and push the document to a folder named: `itmo-540` > `markdown-assignment`

Use the [Markdown cheatsheet reference](https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet "Markdown cheatsheet").

### Final deliverable to Blackboard

Submit to Blackboard the URL to your GitHub private repo, so I can clone and see all these elements. You will submit URL's to the work in the Private GitHub repo to Blackboard, but the work will stay in GitHub.