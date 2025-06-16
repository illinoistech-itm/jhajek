# Cluster Setup Tutorial

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

Most of the sample code can be used directly if your Vault Server is configured correctly. In the `variables.pkr.hcl` you will need to adjust the variable names.

You will also need to setup your Vault server Environment variables but editing your `.bashrc` file on the buildserver located in your Home directory. 

Refer to 13.6.4 and 13.6.5 in the [Linux Textbook](https://github.com/jhajek/Linux-text-book-part-1/blob/master/Chapter-13/chapter-13.md#setting-vault-environment-variables-on-your-host-linux-system "webpage demonstrating configuring Vault on the client-side")

![*Buildserver .bashrc*](./images/bashrc.png "screenshot .bashrc on Buildserver")

### Step 9: Second Packer Template 

This Template will build a single Vanilla Ubuntu Server. 
