# Tutorial Explanation for Deployment of a Three Tier Applicaton With Secrets

This tutorial will go over step by step the deployment and automation of a three tier application including secrets

## Objectives

* Explain and discuss the common problems in creating a three-tier app
* Explain the structures provided by Packer to help automate the creation of a three-tier app
* Explain the methods used to pass secrets
* Explain the user installation process concerning cloud-init (all cloud computing uses this)

## Outcomes

At the conclusion of the review of this working end-to-end sample, you will have been exposed to the common problems when moving an application from a manual deployment to an automated deployment. You will have engaged with methods to pass secret and see their pros and cons, and finally you will have understood cloud-init and its permissions structure.

## Overview

What are we trying to solve in this document and sprint-03? We are reinforcing a few concepts regarding security, deployment, automation, and repeatability. This brings new questions:

* How do we dynamically configure secrets in our application?
  * Can you name some secrets your application has?
  * Can you name components that have or need a secret value?
* How will we know the IP addresses of our frontend and backend systems when they have an epehemeral DHCP address?
  * Why do we have multiple networks? Why can't we just put everything on the public network or localhost?
* How to we preseed our database with tables and data?
* How do handle HTTP connections through a load-balancer?
* Why are we deploying in an automated fashion with Packer and Terraform when we can just SSH in to a single server and configure everything manually?

These questions and more will be answered via the provided sample code and concepts we will discuss in this tutorial.

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
  * If you have cloned previously, issue a `git pull` before starting this tutorial
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

### Seeding Secrets Using Environment Variables

Linux has a feature that you can define variables that are accessible from anywhere in an environment. This is how we can pass values in that can be accessed by our code to seed our secrets for Database connection strings for instance.

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

You will ask, how can I access these variables. Packer has a simple context, you provide the Linux Environement variable name and then assign it the value from the `variables.pkr.hcl` file. Then that Linux Environment variable is accessible by your shell script using the `$` nomenclature for bash shell variables. So when we see `environment_vars = ["DBUSER=${var.DBUSER}]` this allows the value set in the `variables.pkr.hcl` starting at line 94 for DBUSER:

```hcl
# This will be the non-root user account name
variable "DBUSER" {
  type = string
  sensitive = true
  default = "REPLACE"
}
```

To be read into the Linux environment variable also named `DBUSER` and therefore accessed within the Linux Virtual Machine via `$DBUSER`. Once the values added we can use the `sed` command to find the empty `.env` file and replace them with the actual values.

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

This `shell privisoner` does the same thing as using the `environment_vars` as the frontend `shell provisoner` did. This time we are passing in the `DBUSER`, `IPRANGE`, and `DBPASS`. This is a bit tricky as we have multiple security levels when dealing with a database.

First we have the IP level, meaning the firewall, which is configured via `post_install_prxmx_backend-firewall-open-ports.sh` to allow connections only on the `meta-network` internal interface, not exposing out database to the public network.

```sudo firewall-cmd --zone=meta-network --add-port=3306/tcp --permanent``` adjust the port 3306 (MySQL/MariaDB) to your appropriate database port.

Second we have a non-root username and password created, which needs to be created. We don't want our application using the `root` database user which lessens your attack surface and prevents serious explotation--we want to practice the principle of `least privilleges`. From the script: `post_install_prxmx_backend-database.sh` we see syntax for creating users and creating tables and prepopulating with data. Adjust as your team needs to.

```bash
# Change directory to the location of your JS code
cd /home/vagrant/team-00/code/db-samples

# Inline MySQL code that uses the secrets passed via the ENVIRONMENT VARIABLES to create a non-root user
sudo mysql -e "GRANT SELECT,INSERT,CREATE TEMPORARY TABLES ON posts.* TO '${DBUSER}'@'${IPRANGE}' IDENTIFIED BY '${DBPASS}';"

# Inline mysql command to allow the USERNAME you passed in via the variables.pkr.hcl file to access the Mariadb/MySQL commandline 
# for debugging purposes only to connect via localhost (or the mysql CLI)
sudo mysql -e "GRANT SELECT,INSERT,CREATE TEMPORARY TABLES ON posts.* TO '${DBUSER}'@'localhost' IDENTIFIED BY '${DBPASS}';"

# These sample files are located in the mysql directory but need to be part of 
# your private team repo
sudo mysql < ./create-database.sql
sudo mysql < ./create-table.sql
sudo mysql < ./insert-records.sql
```

Third we restrict access to our database, not only via username and password, but restrict it by which IP address range can be allowed to connect and to which tables. This further tightens our access control and security.

```bash
# Inline MySQL code that uses the secrets passed via the ENVIRONMENT VARIABLES to create a non-root user
sudo mysql -e "GRANT SELECT,INSERT,CREATE TEMPORARY TABLES ON posts.* TO '${DBUSER}'@'${IPRANGE}' IDENTIFIED BY '${DBPASS}';"
```

Notice that I am granting limited privilleges to all the tables in the database named post: `posts.*` and then further limiting access to only a certain user, `$DBUSER` and that user connecting from a certain IP range, in this case the `meta-network` IP range of `10.110.0.0/16`. In the SQL syntax there is no CIDR block representation, so we need to use wildcard which are `%` signs in this case: `10.110.%.%`--this is defined in the `template-for-variables.pkr.hcl` file, line 108, CONNECTIONFROMIPRANGE, and give it the default value of `10.110.%.%`.

### Moving Nginx Files for to Create a Load Balancer

In this `shell privisoner` you will notice that there is now a `move-nginx-files.sh` which is needed to move the configuration files needed to turn Nginx from a webserver into a load-balancer. These files are located in the [team-00](https://github.com/illinoistech-itm/team-00 "git repo for sample code")] repo under the `nginx` folder.  You will need to make a few slight adjustments here, replacing my team named FQDNs with yours.

```hcl
  provisioner "shell" {
    execute_command = "echo 'vagrant' | {{ .Vars }} sudo -E -S sh '{{ .Path }}'"
    scripts         = ["../scripts/proxmox/three-tier/loadbalancer/post_install_prxmx_load-balancer-firewall-open-ports.sh",
                      "../scripts/proxmox/three-tier/loadbalancer/post_install_prxmx_load_balancer.sh",
                      "../scripts/proxmox/three-tier/loadbalancer/move-nginx-files.sh"]
    only            = ["proxmox-iso.load-balancer"]
  }
```

```bash
# Content of move-nginx-files.sh
# This overrides the default nginx conf file enabling loadbalacning and 443 TLS only
sudo cp -v /home/vagrant/team-00/code/nginx/nginx.conf /etc/nginx/
sudo cp -v /home/vagrant/team-00/code/nginx/default /etc/nginx/sites-available/
# This connects the TLS certs built in this script with the instances
sudo cp -v /home/vagrant/team-00/code/nginx/self-signed.conf /etc/nginx/snippets/
sudo systemctl daemon-reload
```

**Note:** if the frontend webservers fail to come up -- the load balacner won't start. Be default it needs all backends responding upon initial load-balancer start. You can troubleshoot the load-balancer by sshing into the `lb` instance and taking a look at the nginx error logs. Usally `tail /var/log/nginx/error.log` will show you the last few errors. Watch the timestamps, our servers are configured to `UTC` timezone, not local timezones.

### Cleaning it all Up

```hcl
  provisioner "shell" {
    execute_command = "echo 'vagrant' | {{ .Vars }} sudo -E -S sh '{{ .Path }}'"
    scripts         = ["../scripts/proxmox/three-tier/cleanup.sh"]
  }
```

In the final stages -- you want to clean up. This shells script is going to remove some of the download artifacts for the node_exporter metrics collector. Most importantly it will delete the private key used to `git clone` your team private repo. This does force you to rebuild everytime you have code changes, but also makes sure that you don't leave the keys to the kingdom lying around. Also reduce your security footprint and not leave a power private key laying around.

### Building Only a Certain Templates

Sometimes you will find that you only need to rebuild one of the three packer templates, or perhaps two of the three. You can always rebuild all of them, there is no additional time required to build 1, 2, or 3 as they build in parallel. But there is a Packer option for this condition.

```bash
# Will build everything except proxmox-iso.load-balancer
packer build -except='proxmox-iso.load-balancer' .
# Will build only proxmox-iso.load-balancer
packer build -only='proxmox-iso.load-balancer' .
```

### Terraform main.tf

There are some coding adjustments you need to make to the Terraform `main.tf` file. Starting at line 42 of the `main.tf` you will have to give the first network interface a MAC address. This is so that your load balancer will always get the same public IP address, `192.168.172.0/24`. This is due to a DHCP lease that is linked to the MAC address--which I setup ahead of time.

```hcl
  network {
    model  = "virtio"
    bridge = "vmbr0"
    # Replace this mac addr with your assigned Mac
    # https://github.com/illinoistech-itm/jhajek/tree/master/itmt-430/three-tier-tutorial#how-to-assign-a-mac-address-to-get-a-static-ip
    macaddr = "00:00:00:00:00:00"
  }
```
Here is the chart for all the teams

| Team Number | MacAddr | Static IP | FQDN |
| ----------- | -------------| ------------- | ----------------- |
| team 01m | 04:9F:15:00:00:11 | 192.168.172.60 | system60.rice.iit.edu |
| team 02m | 04:9F:15:00:00:12 | 192.168.172.61 | system61.rice.iit.edu |
| team 03m | 04:9F:15:00:00:13 | 192.168.172.62 | system62.rice.iit.edu |
| team 04m | 04:9F:15:00:00:14 | 192.168.172.63 | system63.rice.iit.edu |
| team 05w | 04:9F:15:00:00:15 | 192.168.172.64 | system64.rice.iit.edu |
| team 05o | 04:9F:15:00:00:16 | 192.168.172.65 | system65.rice.iit.edu |
| team 06o | 04:9F:15:00:00:17 | 192.168.172.66 | system66.rice.iit.edu |
| team 07o | 04:9F:15:00:00:18 | 192.168.172.67 | system67.rice.iit.edu |

This change is the only change that needs to be made and can be pushed into your team private repo.


 adjustements in the `remote-exec` portion

```hcl
provisioner "remote-exec" {
    # This inline provisioner is needed to accomplish the final fit and finish of your deployed
    # instance and condigure the system to register the FQDN with the Consul DNS system
    inline = [
      "sudo hostnamectl set-hostname ${var.backend-yourinitials}-vm${count.index}",
      "sudo sed -i 's/changeme/${random_id.id.dec}${count.index}/' /etc/consul.d/system.hcl",
      "sudo sed -i 's/replace-name/${var.backend-yourinitials}-vm${count.index}/' /etc/consul.d/system.hcl",
      "sudo sed -i 's/ubuntu-server/${var.backend-yourinitials}-vm${count.index}/' /etc/hosts",
      "sudo sed -i 's/FQDN/${var.backend-yourinitials}-vm${count.index}.service.consul/' /etc/update-motd.d/999-consul-dns-message",
      "sudo sed -i 's/#datacenter = \"my-dc-1\"/datacenter = \"rice-dc-1\"/' /etc/consul.d/consul.hcl",
      "echo 'retry_join = [\"${var.consulip}\"]' | sudo tee -a /etc/consul.d/consul.hcl",
      "sudo sed -i 's/HAWKID/${var.consul-service-tag-contact-email}/' /etc/consul.d/node-exporter-consul-service.json",
      "sudo systemctl daemon-reload",
      "sudo systemctl restart consul.service",
      "sudo rm /opt/consul/node-id",
      "sudo systemctl restart consul.service",
      "sudo sed -i 's/0.0.0.0/${var.backend-yourinitials}-vm${count.index}.service.consul/' /etc/systemd/system/node-exporter.service",
      "sudo systemctl daemon-reload",
      "sudo systemctl enable node-exporter.service",
      "sudo systemctl start node-exporter.service",
      "sudo systemctl stop mariadb.service",
      "sudo sed -i '1,$s/127.0.0.1/${var.backend-yourinitials}-vm${count.index}.service.consul/g' /etc/mysql/mariadb.conf.d/50-server.cnf",
      "sudo systemctl daemon-reload",
      "sudo systemctl restart mariadb.service",
      "echo 'Your FQDN is: ' ; dig +answer -x ${self.default_ipv4_address} +short"
    ]
```

## Summary and Conclusion

This sprint is a long one, but important as we are beginning to create an actual working cloud native application. Continue to make use of the principles we are learning in the DevOps handbook and keep working at this--soon you will see the fruits of your labors.
