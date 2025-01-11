# Readme.md Tutorial

You can now proceed to complete the GitHub tutorial setup.

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

On your local system, clone the instructors sample code repo containing this assignment. Issue the command: `git clone https://github.com/illinoistech-itm/jhajek.git` on your local system command line. **Note** - if you already have this repo clone just issue: `git pull` to update to the latest assignment. From your local system's file manager copy the document from the cloned repo: jhajek > itmt-430 > tooling-assignment > Readme.md and place the copied document into your own private repo on the local system under a root folder named: **itmt-430**. In that itmt-430 directory, add an directory named: `images` and place all of your screenshots into that directory.

Open your private Repo using your IDE and now that we have worked with Markdown, I want you to go back, using the [Markdown cheatsheet reference](https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet "Markdown cheatsheet") and add image links under each of the screenshot statements in the assignment above.

Once complete, add, commit, and push your tooling assignment Readme.md to your GitHub Repo
