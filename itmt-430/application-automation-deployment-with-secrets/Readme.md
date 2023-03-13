# Tutorial Explanation for Deployment of a Three Tier Applicaton With Secrets

This tutorial will go over step by step the deployment and automation of a three tier application including secrets

## Objectives

* Explain and discuss the common problems in creating a three-tier app
* Explain the structures provided by Packer to help automate the creation of a three-tier app
* Explain the methods used to pass secrets
* Explain the user installation process concerning cloud-init (all cloud computing uses this)

## Outcomes

At the conclusion of the review of this working end-to-end sample, you will have been exposed to the common problems when moving an application from a manual deployment to an automated deployment. You will have engaged with methods to pass secret and see their pros and cons, and finally you will have understood cloud-init and its permissions structure.

### Sample Code Location

Working code to demonstrate all of this is located in two places

* Sample Javascript code is located in a public repo
  * [https://github.com/illinoistech-itm/team-00](https://github.com/illinoistech-itm/team-00 "git repo for sample code")
  * Normally should be private but for demo purposes
* Setup files included
  * This includes EJS (Javascript) code
  * Nginx load-balancer configs
  * SQL files for creating a database and populating it
* Sample Packer and Terraform build scripts
  * Located in the [jhajek](https://github.com/illinoistech-itm/jhajek "Git repo for jhajek sample code") sample code repo
  * If you have cloned in previously, issue a `git pull`
  * Under the `itmt-430` directory, `example-code`
    * All artifacts located under the `proxmox-jammy-ubuntu-three-tier-template` folder
    
### Parts of the App

For this example you will find a working prototype three-tier application that has:

* A simple EJS webapp
* Nginx load-balancer
* TLS cert (selfsigned)
* MariaDB database
  * With a populated table
* Secrets passed in via Packer's environment_vars command

### Lets Look at the Packer Build Template

We will be starting out by looking at the updates to the Packer build template - [proxmox-jammy-ubuntu-three-tier-template.pkr.hcl](https://github.com/illinoistech-itm/jhajek/blob/master/itmt-430/example-code/proxmox-cloud-production-templates/packer/proxmox-jammy-ubuntu-three-tier-template/proxmox-jammy-ubuntu-three-tier-template.pkr.hcl "webpage to proxmox-jammy-ubuntu-three-tier-template.pkr.hcl"), go ahead and open it in a tab now.

The first additional we notice is starting on line 134, we see a new `source` block for a load-balancer.

![*Load Balancer Source*](./images/load-balancer.png "image of load-balancer code")

The content of this `source` block doesn't change -- other than to create one more builder, other than to give you one more template/image to deploy instances from. 

![*Three Templates/Images*](./images/three.png "image of three produced templates")

### Shell Provisioners

**Note:** The entire setup here is an example, it works, but you will have to modify settings, and add or remove things that are not relevant to your project. If you are using Django, then you would remove all the Javascript setup code. Nothing here is required and feel free to adjust settings so that they make sense to you. Also comment everything you can so you can pass this on to your other group memebrs when you rotate.

Now lets take a look at the shell provisioners section of the Packer build template, starting at line 315. We will go through each of these and see how we handle creating the application, creating the database, connecting them, securing them, and passing some secrets into them. Starting on line 315 we see a `shell proivisioner` that allows us to execute a shell script on our virtual machine images. This requires us to clone a private GitHub repo where our team code is located. The team00 is my sample code.  

```hcl
  provisioner "shell" {
    execute_command = "echo 'vagrant' | {{ .Vars }} sudo -E -S sh '{{ .Path }}'"
    scripts         = ["../scripts/proxmox/three-tier/clone-team-repo.sh"]
  }
```

In the `clone-team-repo.sh` there is one important command to clone your team repo but to do it as the default user: `vagrant`. In this case if we don't all files will be cloned as the default cloud-init user -- which is `root`, this will mess up file permissions and assumptions when trying to access your own code.

```bash
cd /home/vagrant

sudo -u vagrant git clone git@github.com:illinoistech-itm/team-00.git
```

The script `clone-team-repo.sh` assumes you have added `file provisioners` on line 201 and 212. Here we are adding a private key and a `config` file to our virtual machine images so by the time we come to execute line 315.

```hcl
  provisioner "file" {
    source      = "./config"
    destination = "/home/vagrant/.ssh/config"
  }

  provisioner "file" {
    source      = "./id_ed25519"
    destination = "/home/vagrant/.ssh/id_ed25519"
  }
```

Starting on line 326, we see the file provisioner that contains instructions to get a few things setup. 

```hcl
 provisioner "shell" {
    execute_command = "echo 'vagrant' | {{ .Vars }} sudo -E -S sh '{{ .Path }}'"
    scripts         = ["../scripts/proxmox/three-tier/frontend/post_install_prxmx_frontend-firewall-open-ports.sh",
                      "../scripts/proxmox/three-tier/frontend/post_install_prxmx_frontend-webserver.sh",
                      "../scripts/proxmox/three-tier/frontend/application-start.sh"]
    environment_vars = ["DBUSER=${var.DBUSER}","DBPASS=${var.DBPASS}","DATABASE=${var.DATABASE}","FQDN=${var.FQDN}"]                      
    only            = ["proxmox-iso.frontend-webserver"]
  }
```

* `post_install_prxmx_frontend-firewall-open-ports.sh`
  * Setup and open firewall ports
  * Understand the network diagram
* `post_install_prxmx_frontend-webserver.sh`
  * Install frontend applcation dependencies
  * This could be via `apt`, `npm`, or `pip` -- your package manager
  * This also involves moving code and/or starting services
  * Finding and replacing default values for secrets
* `application-start.sh`
  * Retrieving and installing application dependencies
  * This sample uses NodeJS and NPM and based on a `package.json` file, has an additional install command to retrieve all the package dependencies
  * I choose to inclue the `mysql2` and `dotenv` npm packages here
  * [NPM](https://www.npmjs.com/ "webpage of NPM") - is the Node Package Manager that NodeJS Uses --   
  * [Recently purchased by Microsoft](https://www.cnbc.com/2020/03/16/microsoft-github-agrees-to-buy-code-distribution-start-up-npm.htm "webpage Microsoft purchases NPM")

### post_install_prxmx_frontend-firewall-open-ports.sh

First step will be opening of the firewall ports. Remember we are on a three-tier setup -- so we won't be opening ports on the `public` network interface, but on the `meta-network`, the internal non-routable network. Doesn't this make things extra complicated? It does, but this is a security measure, by not exposing webserver directly to the public network, we route all traffic through the load-balancer. Second this allows us to create, destroy, and modify frontend instances as needed.

Second you have to consider that all cloud-native applications live behind a load-balancer. This is something we are getting used to as students, it breaks the direct request model, but its how we need to think and reason. This means that we will need to make heavy use of the logs.

### Troubleshooting via Logs

In Linux using `systemd` there is the `journalctl` command, as well as the venerable `/var/log/` logs location and in addition service managers such as `pm2` have their own shortcut to applcation logs via the `pm2 logs` command. All of these will help you troubleshoot why applciation are not loading or installing.

There is also the `firewall-cmd` syntax to interrogate your firewall. You can see the state of your firewall interfaces via these commands:

* `sudo firewall-cmd --zone=public --list-all`
* `sudo firewall-cmd --zone=meta-network --list-all`
* [firewalld documentation](https://firewalld.org "webpage for firewalld documentation")

### post_install_prxmx_frontend-webserver.sh

In this file, all the application dependencies are installed. This means that if we are using EJS via NodeJS -- served on ExpressJS we need to install those operating system libraries first. Let us take a look at some of the sample bash shell scripts to do this

```bash
curl -fsSL https://deb.nodesource.com/setup_16.x | sudo -E bash -
sudo apt-get install -y nodejs
sudo npm install -g npm@9.6.0
```

This code retrieves the NodeJS 16 longterm support PPA repository for Ubuntu Linux and adds it to your operating system, making for an easy installtion of nodejs via the apt package manager. The next line updates the `npm` NodeJS package manager that is installed along with NodeJS. You would adjust this for non-NodeJS code and applications.

```bash
# Change directory to the location of your JS code
cd /home/vagrant/team-00/code/express-static-app/
```

This line assumes I have succesfully cloned your own team code -- make sure to change the path here to include your team and not mine.

```bash
sudo npm install -g --save express ejs pm2
```

This installs the express, ejs, and pm2 packages -- technically the express and ejs packages will be installed as part of the application-start.sh script, but [pm2](https://pm2.io/docs/plus/overview/ "webpage for pm2 service manager documentation") is our service event manager. This is the software that will help us create a systemd `.service` file to start, restart, and stop our NodeJS application as if it were a normal Linux service. 

```bash
sudo -u vagrant pm2 start server.js
```

This line is key to start the service initially, note that we use the `sudo -u vagrant` command -- this executes the pm2 start server.js command with sudo privilleges, but gives ownership to any scaffolding created to the `vagrant` user. Otherwise your application would need `root` permission to run and that could be done but is very dangerous and highly unneccesary. This is a security feature. This command needs to be executed where your *index* or *start* page for your JavaScript application is located.

```bash
# This creates your javascript application service file
sudo env PATH=$PATH:/usr/bin /usr/lib/node_modules/pm2/bin/pm2 startup systemd -u vagrant --hp /home/vagrant

# This saves which files we have already started -- so pm2 will 
# restart them at boot
sudo -u vagrant pm2 save
```

This is the command that `pm2` uses to create the actual systemd `.service` file in the `/etc/systemd/system` directory that loads services at boot.

```bash
###############################################################################
# Using Find and Replace via sed to add in the secrets to connect to MySQL
# There is a .env file containing an empty template of secrets -- essentially
# this is a hack to pass environment variables into the vm instances
###############################################################################

sudo sed -i "s/FQDN=/FQDN=$FQDN/" /home/vagrant/team-00/code/express-static-app/.env
sudo sed -i "s/USER=/USER=$DBUSER/" /home/vagrant/team-00/code/express-static-app/.env
sudo sed -i "s/PASS=/PASS=$DBPASS/" /home/vagrant/team-00/code/express-static-app/.env
sudo sed -i "s/DATABASE=/DATABASE=$DATABASE/" /home/vagrant/team-00/code/express-static-app/.env
```

The last part is where we are using Find and Replace via the Linux command line, which is called `sed`, to replace an empty password template. Our application needs to connect to a database - that is on a discrete server, no localhost here. We don't want to hardcode these values into our source code, would be dangerous, lazy, and possibly illegal (or fineable).

So for NodeJS - there is an NPM package called [dotenv](https://www.npmjs.com/package/dotenv "webpage for npm package dotenv") that allows you to create a `.env` file in the root of your NodeJS application and then access Key/Value pairs in your code -- without having to hardcode any parameters.

If you look in the [team-00](https://github.com/illinoistech-itm/team-00 "git repo for sample code") sample repo, under `code` > `express-static-app` you will see an empty `.env` file:

```bash
FQDN=
PASS=
USER=
DATABASE=
```

These are values that will need to be defined for my NodeJS application to connect to the MariaDB SQL server. We don't want to define them in our source code repo, so where do we define them? At this point we will define them at run time, via our Packer `variables.pkr.hcl` if you take a look at the `template-for-variables.pkr.hcl` you will now see additional variables located at the end of the file. This allows us to use something called `environment_vars` in Packer where we can pass the content of these variables from the variables.pkr.hcl file into our Virtual Machine as Linux Environement Variables. These are the same variables that are accessible via the `$` nomenclature. The good news is that these environment variables last only for the duration of the `file provisioner` so they won't be accssibile later.

Nothing needs to be changed in this sample other than the path to the `.env` file. Or if you are using a different construct change the file path as needed.

FQDN will be the fully qualified domain name of our interface on the meta-network for the backend database: `team-00-be-vm0.service.consul`
You will know this name ahead of time because you defined the `team-00-be` portion in the `terraform.tfvars` file on line 25, `backend-yourinitials  = ""`. To this value the Terraform `count` variable will be appended, `-vm0`. Finally all systems are given the `.service.consul` domain name so that the [Consul](https://consul.io "webpage for consul.io") dns-forwarding service knows to resolve any request to that FQDN using the internal Consul service and not external DNS.

How does this work then, again starting from line 326, we see a new Packer value, [environment_vars](https://developer.hashicorp.com/packer/docs/provisioners/shell#environment_vars "webpage for Packer environement_vars value").

```hcl
 provisioner "shell" {
    execute_command = "echo 'vagrant' | {{ .Vars }} sudo -E -S sh '{{ .Path }}'"
    scripts         = ["../scripts/proxmox/three-tier/frontend/post_install_prxmx_frontend-firewall-open-ports.sh",
                      "../scripts/proxmox/three-tier/frontend/post_install_prxmx_frontend-webserver.sh",
                      "../scripts/proxmox/three-tier/frontend/application-start.sh"]
    environment_vars = ["DBUSER=${var.DBUSER}","DBPASS=${var.DBPASS}","DATABASE=${var.DATABASE}","FQDN=${var.FQDN}"]                      
    only            = ["proxmox-iso.frontend-webserver"]
  }
```

<dl>
  <dt><code>environment_vars</code></dt>
  <dd>(array of strings) - An array of key/value pairs to inject prior to the execute_command. The format should be key=value. Packer injects some environmental variables by default into the environment, as well, which are covered in the section below.</dd>
</dl>

You will ask, how can I access these variables. Packer has a simple context, you provide the Linux Environement variable name and then assign it the value from the `variables.pkr.hcl` file. Then that Linux Environment variable is accessible by your shellscript using the `$` nomenclature for bash shell variables. 

### application-start.sh

A simple shell script that from the application directory where the `package.json` file is located, will run a simple command:

```bash

npm install

```

This command reads the `package.json` file and all of the packages required to install your EJS Node application. What you want to **Strongly** avoid is adding all of those packages to your GitHub repo. Once the `npm install` command is run -- npm will retrieve a **LARGE** amount of code, packages, and dependecies, and place them all in a directory: `node_module` -- you don't need this is your repository -- add that folder entry to your `.gitignore` file otherwise you will mess your repo up by committing these files, but won't be able to push the to GitHub. You want to retrieve them at build time.

For other platforms you may want to remove or edit this -- for Django there is an equivilant step to initialize or build all of your views. This might be a good place for that.

### environment_vars

```hcl
  provisioner "shell" {
    execute_command = "echo 'vagrant' | {{ .Vars }} sudo -E -S sh '{{ .Path }}'"
    scripts         = ["../scripts/proxmox/three-tier/backend/post_install_prxmx_backend-firewall-open-ports.sh",
                      "../scripts/proxmox/three-tier/backend/post_install_prxmx_backend-database.sh"]
    environment_vars = ["DBUSER=${var.DBUSER}","IPRANGE=${var.CONNECTIONFROMIPRANGE}","DBPASS=${var.DBPASS}"]
    only            = ["proxmox-iso.backend-database"]
  }
```

```hcl
  provisioner "shell" {
    execute_command = "echo 'vagrant' | {{ .Vars }} sudo -E -S sh '{{ .Path }}'"
    scripts         = ["../scripts/proxmox/three-tier/loadbalancer/post_install_prxmx_load-balancer-firewall-open-ports.sh",
                      "../scripts/proxmox/three-tier/loadbalancer/post_install_prxmx_load_balancer.sh",
                      "../scripts/proxmox/three-tier/loadbalancer/move-nginx-files.sh"]
    only            = ["proxmox-iso.load-balancer"]
  }
```

```hcl
  provisioner "shell" {
    execute_command = "echo 'vagrant' | {{ .Vars }} sudo -E -S sh '{{ .Path }}'"
    scripts         = ["../scripts/proxmox/three-tier/cleanup.sh"]
  }
```

## Summary and Conclusion

This sprint is a long one, but important as we are beginning to create an actual working cloud native application. Continue to make use of the principles we are learning in the DevOps handbook and keep working at this--soon you will see the fruits of your labors.
