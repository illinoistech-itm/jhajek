# Cluster Access Setup Tutorial

This is a short description of the tools we need to setup

## Configure VPN

If you are off of the campus network, connect via the university VPN client to our internal network. You can download the VPN client at [https://vpn-1.iit.edu](https://vpn-1.iit.edu "webpage for the VPN download") for MacOS and Windows (autodetects). 


![*VPN Login*](./images/vpn.png "image for displaying vpn login")

Use your full `@hawk.iit.edu` email and portal password to authenticate. You will have to 2-factor authenticate as well.

## Connect to VPN

Launch the Cisco VPN tool and connect to `vpn.iit.edu` 

![*VPN Connect*](./images/vpn-iit-edu.png "image of connection URL")

Authenticate using your Portal username and password

![*VPN Authentication*](./images/auth.png "image of correct authentication")

Watch out! The two-factor message triggers quickly and doesn't have much patience, make sure to have your phone ready to approve the connection.

## SSH Connection

Now we will test your SSH connection to the `buildserver`. From the terminal on your computer run the follwing command, replacing values of mine with yours:

```bash
ssh -i c:/users/palad/.ssh/id_ed25519_itmo_453_key hajek@system45.rice.iit.edu
```

The `-i` value is the path to the private key that matches the public key you provided to me in the excel Spreadsheet.

The value `hajek` is the username of the account. I created the accounts to use your HAWKID (just the value not the @hawk part), though these account are not related to the university accounts.

The FQDN of `system45.rice.iit.edu` is a virtual machine that we use as a buildserver to issue all of our build commands to our virtual machine cluster.

## VSCode Plugins 

You need to install two VScode Extensions. The `Extensions` store is the 2 by 2 squares icon in the VSCode menu.

* HashiCorp Terraform 
* Hashicorp HCL 

![*Hashicorp VSCode Extensions*](./images/hashicorp-extensions.png "Screenshot of installing Hashicorp extensions")

## Buildserver

Network Access: 

The entire cluster works on a single flat CIDR block: 192.168.172.0/24 and there is DNS available for each system. Which is based on the last octet of the IP address

```
system41.rice.iit.edu will resolve to 192.168.172.41 
```

2 Node Proxmox Cluster (Debian Linux running Managed KVM) 

![*system41.rice.iit.edu*](./images/system41.png "screenshot of system41")

![*system42.rice.iit.edu*](./images/system42.png "screenshot of system42")

## Cluster Access

For infrastructure deployment we will be using a central buildserver: `system45.rice.iit.edu`.  If you are on the Campus network you do not need to connect to the VPN. If you are off of the campus network then you need to connect to the VPN first. 

Let's connect to our buildserver and retrieve account credentials. An account has been created for you already, it is your HAWK ID (just the ID part, not the @HAWK part). This account is not related at all to your school account.

This account:

* You have a home directory but no sudo access 
* It contains a text file with your API keys to access our Cluster resources for API and Cloud Native deployment 
* Home directories are built using ZFS soft partitions, which allow for partitions that don’t have a fixed disk size. 
  * What Is ZFS?: A Brief Primer by Wendell at Level1techs at https://www.youtube.com/watch?v=lsFDp-W1Ks0 

### Step 1: Connecting to the Buildserver via SSH 

```
ssh -i "C:\Users\palad\OneDrive\Personal Vault\id_ed25519_proxmox" hajek@system45.rice.iit.edu
```

This private key is the key that matches the public key you provided in the excel account document at the beginning of class.

We will use ssh to remotely connect to the buildserver using the `–i` flag and passing the path to the private key

* The IP address is system45.rice.iit.edu (need VPN connected)  
* Your username is your hawkid without the @hawk part 
* There is no connection with your university Hawk account 
* There are no passwords 

### Step 2: Repeat the Git Tutorial Process 

On the buildserver, you will need to generate another ed25519 public private key pair and place the public half of this key pair into your GitHub account as a `Deploy Key` with read-only access.

* Repeat the process from the Git Tutorial on the buildserver 
* Create a config file containing the necessary information in your .ssh directory 
* Clone your own private repo code

### Step 3: Location of credentials

The credentials you will need are located in your buildserver home directory in a file named: `HAWKID-proxmox-credentials.txt`.

The first paragraph will contain your Cluster web console credentials. The next text blocks surrounded by textboxes will contain API Access and Secret Keys for building and deploying virtual machine artifacts via Packer and Terraform on the Proxmox cluster.

### Step 4: Example code for initial Vault construction

There are Packer templates available in the [https://github.com/illinoistech-itm/jhajek](https://github.com/illinoistech-itm/jhajek "webpage for jhajek sample code repo") repo. You can also clone this to your own local system to further investigate the code base. BE CAREFUL! Not to clone the jhajek repo into another existing repo. Git can become confused when repos are embedded inside of each other. 

![*Example Code location*](./images/430.png "screenshot for example code location")

```
itmt-430 > example-code > production
```
This folder includes: 

* You need to go through the process of filling out the `variables.pkr.hcl` with the provided credentials to build your Vault Server 
* The first vault template: `promox-jammy-vault-template` 
  * You will be managing your own secrets 
  * We need to build a Vault server first
    * We will build it the same way we did the in the Vault Tooling Assignment

Make sure to execute these commands: 

* `packer init .` (first time only) 
* `packer validate .`
* `packer build .`

These steps will complete and build an Ubuntu server with Vault, the `.bashrc`, and the firewall pre-configured via Packer's provisioning system. This will create a VM template on the Proxmox Cluster in which we can deploy arbitrary number of VMs via Terraform.

### Step 5: Deploying Instances with Terraform 

What is [Terraform](https://developer.hashicorp.com/terraform "webpage for Terraform")? Terraform is an infrastructure as code tool that lets you build, change, and version infrastructure safely and efficiently.

[Terraform](https://developer.hashicorp.com/terraform "webpage for Terraform") is Hashicorp’s application deployment tool. Like Vagrant, but all grown up. It allows you to automate infrastructure deployment on any cloud or VM platform.  

![*Terraform templates*](./images/terraform.png "screenshot of Terraform templates")

Steps:

* `terraform init` (first time only, per directory) 
* `terraform validate`
* `terraform apply`

### Step 6: Configure your Vault Server 

You will start by SSHing into your newly deployed Vault Server. The IP address will be printed out on the last line of a successful `terraform apply` command. Otherwise you can find it by selecting the instance of you VM in the Proxmox Web Console. 

![*Proxmox Web Console - Summary Tab*](./images/ip.png "screenshot proxmox web console")

```
ssh -i ./id_ed25519_vault_student_production vagrant@system73.rice.iit.edu
```

The private key listed here is the private key that matches the public key you generated ON the buildserver. Not the key for GitHub on the buildserver, but the match to the public key that you inserted into the `subiquity > http > user-data` file. In this case I moved the private key out of the packer directory and into the directory where the Terraform templates are.

You can now initialize and unseal your Vault. You will want to refer to the Vault tutorial. This will be the single Vault server you use for the rest of the project. 

### Step 7: Installing Vault via Ubuntu CLI 

Create new values in the policy file, `itmo453-secrets.hcl` -- adjust the policy name accordingly. 

```
path "secret/data/*" { 
  capabilities = ["read","create", "update","delete"] 
} 

path "auth/token/create" { 
   capabilities = ["create", "read", "update", "list"] 
} 
```

Finish the tutorial by creating a `VAULT TOKEN` for these credentials. Note these credentials are pretty wide-open. Feel free to experiment on reducing the capabilities. There will be some additional secrets that were not present in the tutorial. Later you will need to add additional secrets, but these will get you started.

```
vault kv put -mount=secret NODENAME SYSTEM41=system41 SYSTEM42=system42 
vault kv put -mount=secret SSH SSHUSER=vagrant SSHPW=vagrant 
vault kv put -mount=secret URL S41=https://system41.rice.iit.edu:8006/api2/json S42=https://system42.rice.iit.edu:8006/api2/json 
vault kv put -mount=secret ACCESSKEY PK-USERNAME='hajek-pk@pve!hajek-itmt4302024' TF-USERNAME='hajek-tf@pve!hajek-itmt4302024' 
vault kv put -mount=secret SECRETKEY PK-TOKEN='7935a1ca-7775-487f-adaa-9999999999b67' TF-TOKEN='c4662ce8-a9eb-4424-8573-9999999999140' 
vault kv put -mount=secret DB DBPASS=letmein DBUSER=controller DATABASENAME=foo DBURL=team-00-db.service.console CONNECTIONFROMIPRANGE='10.110.%.%' 
```
 
*Advanced:* Vault MySQL integration: [MySQL/MariaDB database secrets engine](https://developer.hashicorp.com/vault/docs/secrets/databases/mysql-maria "webpage MySQL Vault integration")

### Step 8: Configure Your Account on the Buildserver to Access Vault 

Most of the sample code can be used directly if your Vault Server is configured correctly.

You will also need to setup your Vault server Environment variables but editing your `.bashrc` file on the buildserver located in your Home directory. 

Refer to 13.6.4 and 13.6.5 in the [Linux Textbook](https://github.com/jhajek/Linux-text-book-part-1/blob/master/Chapter-13/chapter-13.md#setting-vault-environment-variables-on-your-host-linux-system "webpage demonstrating configuring Vault on the client-side")

![*Buildserver .bashrc*](./images/bashrc.png "screenshot .bashrc on Buildserver")

### Step 9: Three-tier Application Explanation

We will now go into the files that explain in detail how our three-tier app gets deployed as well as explain the systems and software we need to make this happen. This is also a place where you can begin to understand the entire codebase and begin to make changes and optimizations -- the example code is **intentionally** left verbose for learning purposes, but make it your own and optimize it as you see fit.

#### Getting Application Code from the Team Repo into VM Instances

Now that you have your infrastructure setup, how will we get code from a private team repo into each of our virtual machine instances? We will use the Git clone command as part of a `provisioner` script in the `packer build` phase. But we will run into a problem, the team repository is a private repo requiring authentication to clone. In this case we will need to provide a private key for GitHub authentication and an ssh `config` file into a deployed instance. We can do that via a `file provisioner` in Packer. 

A [file provisioner](https://developer.hashicorp.com/packer/docs/provisioners/file "webpage for packer file provisioner documentation") allows you to securely upload files from your local system to the virtual machine being built. This is a simple way to insert a private key and an ssh config file to a virtual machine template. Later you can use a [shell provisioner](https://developer.hashicorp.com/packer/docs/provisioners/shell "webpage for shell provisioner documentation") to do the cloning of your private team repo.

Taking a look at the example Packer build template, `proxmox-jammy-ubuntu-three-tier-template.pkr.hcl` we added two file provisioners under the `build` block.

```hcl
build {
  sources = ["source.proxmox-iso.frontend-webserver","source.proxmox-iso.backend-database","source.proxmox-iso.load-balancer"]

  #############################################################################
  # Using the file provisioner to SCP this file to the instance 
  # Copy the configured config file to the ~/.ssh directory so you can clone 
  # your GitHub account to the server
  #############################################################################

  provisioner "file" {
    source      = "./config"
    destination = "/home/vagrant/.ssh/config"
  }

  #############################################################################
  # Using the file provisioner to SCP this file to the instance 
  # Copy the private key used to clone your source code -- make sure the public
  # key is in your GitHub account
  #############################################################################

  provisioner "file" {
    source      = "./id_ed25519"
    destination = "/home/vagrant/.ssh/id_ed25519"
  }
```

This will require you create an additional `ed25519` public/private keypair that will be placed in the directory where you execute the `packer build .` command. You will add the public key portion to your GitHub account so that your virtual machine instance can use these credentials to authenticate. You will need to make note of the keys and make proper adjustments to the names.

There is also an additional security step, at the very end of the Packer provisioning phase, you will see a script called `cleanup.sh`. This will delete your private key off of your server instance just before completing the provisioner phase--so that even if your instance is compromised--no keys will be available to abuse.

#### Values that need to be changed

In the sample code, there are many variables that assume you are using the `team-00` private GitHub repo. I will note the files and lines you need to change. All paths assume you are in the `proxmox-cloud-production-templates` directory.

#### move-nginx-files.sh

* `packer > scripts > proxmox > three-tier > loadbalancer > move-nginx-files.sh`

```bash
# This overrides the default nginx conf file enabling loadbalacning and 443 TLS only
sudo cp -v /home/vagrant/team-00/code/nginx/nginx.conf /etc/nginx/
sudo cp -v /home/vagrant/team-00/code/nginx/default /etc/nginx/sites-available/
# This connects the TLS certs built in this script with the instances
sudo cp -v /home/vagrant/team-00/code/nginx/self-signed.conf /etc/nginx/snippets/

sudo systemctl daemon-reload
```

Update the path to the `code` folder. The `team-00` placeholder should be replaced with your private repo you were given for the class. Adjust the path as well.

#### clone-team-repo.sh

* `packer > scripts > proxmox > three-tier > clone-team-repo.sh`

```bash
sudo -u vagrant git clone git@github.com:illinoistech-itm/team-00.git
```

Update the repo name to clone -- this should be the provided private repo. Make sure you have generated an additional ed25519 key and placed the public key portion into GitHub as a per repo Deploy Key.

#### application-start.sh

* `packer > scripts > proxmox > three-tier > frontend > application-start.sh`

```bash
cd /home/vagrant/team-00/code/express-static-app/
```

This line of code needs to be adjusted. Change the `team-00` value to your GitHub repo name and adjust the path to `code` as needed.

#### post_install_prxmx_frontend-webserver.sh

* `packer > scripts > proxmox > three-tier > frontend > post_install_prxmx_frontend-webserver.sh`

```bash
# Change directory to the location of your JS code
cd /home/vagrant/team-00/code/express-static-app/
```

This line of code needs to be adjusted. Change the `team-00` value to your GitHub repo name and adjust the path to `code` as needed.

```bash
###############################################################################
# Using Find and Replace via sed to add in the secrets to connect to MySQL
# There is a .env file containing an empty template of secrets -- essentially
# this is a hack to pass environment variables into the vm instances
###############################################################################

sudo sed -i "s/FQDN=/FQDN=$FQDN/" /home/vagrant/team-00/code/express-static-app/.env
sudo sed -i "s/DBUSER=/DBUSER=$DBUSER/" /home/vagrant/team-00/code/express-static-app/.env
sudo sed -i "s/DBPASS=/DBPASS=$DBPASS/" /home/vagrant/team-00/code/express-static-app/.env
sudo sed -i "s/DATABASE=/DATABASE=$DATABASE/" /home/vagrant/team-00/code/express-static-app/.env
```

These lines are taking the username and password values from Vault and using the to execute inline mysql commands to create users and databases for the example project. Adjust the paths to the files. **Advanced:** This part could be replaced by using the MySQL Vault secrets backend...

#### post_install_prxmx_backend-database.sh

* `packer > scripts > proxmox > three-tier > backend > post_install_prxmx_backend-database.sh`

```bash
# Change directory to the location of your JS code
cd /home/vagrant/team-00/code/db-samples
```

The `team-00` directory name needs to be changed as well as the path to the `code` directory.

#### nginx.conf

* `packer > scripts > proxmox > jammy-services > nginx > nginx.conf`

```
upstream backend {
  ip_hash;  # this allows for a sticky session - requests from origin IP always sent to the same backend
      server team00-fe-vm0.service.consul:3000;
      server team00-fe-vm1.service.consul:3000;
      server team00-fe-vm2.service.consul:3000;
}
```

Update the value of `team-00-fe` to be the value you have or will provide in the `terraform.tfvars` file for this variable: `frontend-yourinitials`. This is how you will assign you Consul network FQDN so that you can resolve the IP in your application.

#### Troubleshooting

As our application grows more complex, in software and in infrastructure, there grows a complexity. We are trying to tame this complexity via version control and automation. There is a temptation to just fix things and patch the system together, but this contradicts our Third Way - Creating a Learning Culture.

Though it is ok to experiment and fix things manually, you need to take the time to port all your changes into source code and your automation deploy scripts -- so that anyone can deploy the application and everyone can know the state of the application at any time. 

This is important because if you are trying to troubleshoot the system and the system you are reasoning about is not in the state you assume it is, this makes troubleshooting extremely difficult, as all your hypothesis will be made on shifting sand. Try to overcome and put the work in to automate everything and document it via GitHub, not to take shortcuts.

Another important concern is Linux system service control. How do you start services at boot? How does your application start at boot? You will need to think about creating systemd `.service` files so that your application can start up immediately at boot--without human intervention.

#### The 3 P's of Troubleshooting Linux Problems

All my troubleshooting experience in Linux boils down to three things. I have named them the 3P's (yes I know that they all don't start with *P*).  If you have an error message or cannot execute a command--run down these three troubleshooting steps:

* Path
  * If you get an error message telling you that `file not found` or `path does not exist`--double check your path.  Is the absolute path correct? Is it a relative path problem?  Are you on the wrong level of the tree?
* Permission
  * Every file has permission on what is allowed to be done with it based on a simple access control of read write and execute.  Maybe you don't have permission to write and therefore can't delete a file. Perhaps the file is owned by someone else and they didn't give you permission.  Check permissions via ls -la or see if you need sudo.
* dePendencies
  * Are all the correct software dependencies installed? Perhaps you are missing a library or have an incompatible version that is preventing a tool from running? 
  * If you try to run the commmand `btop` or `links 127.0.0.1` and you don't have these packages installed, you will receive error messages. 
  * If you don't have the `gcc` compiler installed you won't be able to compile and build the VirtualBox Guest Additions, which will be a dependency error.
* All else fails and you still have a problem, see if it is a full moon outside.

### Step 10: Three-tier Web Application Packer Templates 

What are we trying to solve? We are reinforcing a few concepts regarding security, deployment, automation, and repeatability. This brings new questions:

* How do we dynamically configure secrets in our application?
  * Can you name some secrets your application has?
  * Can you name components that have or need a secret value?
* How will we know the IP addresses of our frontend and backend systems when they have an ephemeral DHCP address?
  * Why do we have multiple networks? Why can't we just put everything on the public network or localhost?
* How to we preseed our database with tables and data?
* How do handle HTTP connections through a load-balancer?
* Why are we deploying in an automated fashion with Packer and Terraform when we can just SSH in to a single server and configure everything manually?

These questions and more will be answered via the provided sample code and concepts we will discuss in this tutorial.

#### Plugins

It is highly recommended to install the `HCL` syntax highlighting plugin in VSCode. Click the 4 squares icon and search for `HCL`

![*HCL Syntax Highlighitng*](./images/hcl-plugin.png "image of VSCode HCL Plugin")

#### Parts of the App

For this example you will find a working prototype three-tier application that has:

* A simple EJS webapp
* Nginx load-balancer
* TLS cert (self-signed)
* MariaDB database
  * With a populated table
* Secrets passed in via Packer's `environment_vars` command

#### Lets Look at the Packer Build Template

We will be starting out by looking at the Packer build template - `proxmox-jammy-ubuntu-three-tier-template.pkr.hcl`.

#### Shell Provisioners

**Note:** The entire setup here is an example, it works, but you will have to modify settings, and add or remove things that are not relevant to your project. If you are using Django, then you would remove all the Javascript setup code. Nothing here is required and feel free to adjust settings so that they make sense to you. Also comment everything you can so you can pass this on to your other group members when you rotate.

Now lets take a look at the shell provisioners section of the Packer build template, starting at line 315. We will go through each of these and see how we handle creating the application, creating the database, connecting them, securing them, and passing some secrets into them. Starting on line 315 we see a `shell provisioner` that allows us to execute a shell script on our virtual machine images. This requires us to clone a private GitHub repo where our team code is located. The team00 is my sample code.  

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
  * Install frontend application dependencies
  * This could be via `apt`, `npm`, or `pip` -- your package manager
  * This also involves moving code and/or starting services
  * Finding and replacing default values for secrets
* `application-start.sh`
  * Retrieving and installing application dependencies
  * This sample uses NodeJS and NPM and based on a `package.json` file, has an additional install command to retrieve all the package dependencies
  * I choose to include the `mysql2` and `dotenv` npm packages here
  * [NPM](https://www.npmjs.com/ "webpage of NPM") - is the Node Package Manager that NodeJS Uses --   
  * [Recently purchased by Microsoft](https://www.cnbc.com/2020/03/16/microsoft-github-agrees-to-buy-code-distribution-start-up-npm.htm "webpage Microsoft purchases NPM")

#### post_install_prxmx_frontend-firewall-open-ports.sh

First step will be opening of the firewall ports. Remember we are on a three-tier setup -- so we won't be opening ports on the `public` network interface, but on the `meta-network`, the internal non-routable network. Doesn't this make things extra complicated? It does, but this is a security measure, by not exposing webserver directly to the public network, we route all traffic through the load-balancer. Second this allows us to create, destroy, and modify frontend instances as needed.

Second you have to consider that all cloud-native applications live behind a load-balancer. This is something we are getting used to as students, it breaks the direct request model, but its how we need to think and reason. This means that we will need to make heavy use of the logs.

#### Troubleshooting

In Linux using `systemd` there is the `journalctl` command, as well as the venerable `/var/log/` logs location and in addition service managers such as `pm2` have their own shortcut to applcation logs via the `pm2 logs` command. All of these will help you troubleshoot why applciation are not loading or installing on your Ubuntu Linux servers.

Use the `firewall-cmd` syntax to interrogate your firewall. You can see the state of your firewall interfaces via these commands:

* `sudo firewall-cmd --zone=public --list-all`
* `sudo firewall-cmd --zone=meta-network --list-all`
* [firewalld documentation](https://firewalld.org "webpage for firewalld documentation")

Use the `journalctl`, `systemctl`, and the good old `/var/logs` tools to interrogate your services

* `sudo systemctl status nginx`
* `sudo journalctl -u nginx.service`
* `sudo journalctl -u mariadb.service`
  * `-u` means service name
* `tail /var/log/nginx/error.log`
* If using `pm2` it has a built in log feature that captures all the `console.log()` content
  * `pm2 logs`

You can also SSH in directly from the buildserver to your instances. Just use the private key you have in the directory containing the `main.tf` file

* For example: `ssh -i ./id_ed25519_terraform_deploy_key vagrant@system96.rice.iit.edu`
  * Assume that system96 is the FQDN of the instance you want to connect to
* Try to resist using the Proxmox GUI - use as a last resort
  * Normally you won't have this console access anyway and the only way will be via SSH

#### SSH Errors and Warnings

What happens if you try to `ssh` to a system you just deployed and you recieve this error?
```
hajek@newyorkphilharmonic:~/team-00/build/example-code/$ ssh -i ./id_ed25519_terraform_deploy_key vagrant@system107.rice.iit.edu
```

```
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@    WARNING: REMOTE HOST IDENTIFICATION HAS CHANGED!     @
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
IT IS POSSIBLE THAT SOMEONE IS DOING SOMETHING NASTY!
Someone could be eavesdropping on you right now (man-in-the-middle attack)!
It is also possible that a host key has just been changed.
The fingerprint for the ECDSA key sent by the remote host is
SHA256:7a2Ei1s54cU2f+N2kO32I9TIHXwL1VsWyHZnBNP/X5c.
Please contact your system administrator.
Add correct host key in /datadisk1/home/hajek/.ssh/known_hosts to get rid of this message.
Offending ECDSA key in /datadisk1/home/hajek/.ssh/known_hosts:102
  remove with:
  ssh-keygen -f "/datadisk1/home/hajek/.ssh/known_hosts" -R "system107.rice.iit.edu"
ECDSA host key for system107.rice.iit.edu has changed and you have requested strict checking.
Host key verification failed.
```

This is due to strict host key checking and is due to the nature that IP address are correlated with hostnames. This is simply stating that from a previous SSH connection the previous IP/hostname pair doesn't match. And if you deploy many times, this is bound to happen--our network is small only 192.168.172.0/24 IPs. The reason this doesn't happen on major cloud providers is that they have massive IP ranges and the chance of being assigned the same one is very small.

#### post_install_prxmx_frontend-webserver.sh

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

#### Seeding Secrets Using Environment Variables

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
    environment_vars = ["DBUSER=${local.DBUSER}","DBPASS=${local.DBPASS}","DATABASE=${local.DATABASE}","FQDN=${local.FQDN}"]                      
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

#### application-start.sh

A simple shell script that from the application directory where the `package.json` file is located, will run a simple command:

```bash

npm install

```

This command reads the `package.json` file and all of the packages required to install your EJS Node application. What you want to **Strongly** avoid is adding all of those packages to your GitHub repo. Once the `npm install` command is run -- npm will retrieve a **LARGE** amount of code, packages, and dependecies, and place them all in a directory: `node_module` -- you don't need this is your repository -- add that folder entry to your `.gitignore` file otherwise you will mess your repo up by committing these files, but won't be able to push the to GitHub. You want to retrieve them at build time.

For other platforms you may want to remove or edit this -- for Django there is an equivilant step to initialize or build all of your views. This might be a good place for that.

#### environment_vars

```hcl
  provisioner "shell" {
    execute_command = "echo 'vagrant' | {{ .Vars }} sudo -E -S sh '{{ .Path }}'"
    scripts         = ["../scripts/proxmox/three-tier/backend/post_install_prxmx_backend-firewall-open-ports.sh",
                      "../scripts/proxmox/three-tier/backend/post_install_prxmx_backend-database.sh"]
    environment_vars = ["DBUSER=${local.DBUSER}", "IPRANGE=${local.CONNECTIONFROMIPRANGE}", "DBPASS=${local.DBPASS}"]
    only             = ["proxmox-iso.backend-database41"]
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

#### Moving Nginx Files for to Create a Load Balancer

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

#### Cleaning it all Up

```hcl
  provisioner "shell" {
    execute_command = "echo 'vagrant' | {{ .Vars }} sudo -E -S sh '{{ .Path }}'"
    scripts         = ["../scripts/proxmox/three-tier/cleanup.sh"]
  }
```

In the final stages -- you want to clean up. This shells script is going to remove some of the download artifacts for the node_exporter metrics collector. Most importantly it will delete the private key used to `git clone` your team private repo. This does force you to rebuild everytime you have code changes, but also makes sure that you don't leave the keys to the kingdom lying around. Also reduce your security footprint and not leave a power private key laying around.

#### Building Only a Certain Templates

Sometimes you will find that you only need to rebuild one of the three packer templates, or perhaps two of the three. You can always rebuild all of them, there is no additional time required to build 1, 2, or 3 as they build in parallel. But there is a Packer option for this condition.

```bash
# Will build everything except proxmox-iso.load-balancer
packer build -except='proxmox-iso.load-balancer' .
# Will build only proxmox-iso.load-balancer
packer build -only='proxmox-iso.load-balancer' .
```

#### Adjustements in the `remote-exec` portion

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

See this [additional walk-through](https://github.com/illinoistech-itm/jhajek/tree/master/itmt-430/project-tutorials/application-automation-deployment-with-secrets "webpage explaining example three tier web application.") for extensive three-tier application explanations and descriptions of the different functions needed to build and deploy our three-tier web application.

### Step 11: Three-tier Web Application Terraform Templates

Here we will deploy our example three-tier web application VMs and explain the content of the files in the `terraform` directory: `main.tf, provider.tf, terraform.tfvars, variables.tf`.

## Conclusion

In this tutorial we were able to successfully connect and configure access to the Proxmox See-through Cloud. We were able to setup secrets' management and deploy a sample three-tier web application via Packer and Terraform, demonstrating automation and Linux OS concepts in a Cloud Native manner.
