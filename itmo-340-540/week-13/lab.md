# Questions Week 13 Data Link Layer

## Objectives

* Display knowledge of configuring subnets and CIDR blocks
* Examine practical applications of DHCP distribution of IP addresses
* Demonstrate and explain how virtual network interfaces work

### Notes and Instructions

To complete this lab you will end up create 4 additional virtual machines via Vagrant and VirtualBox. There is a short corresponding video demonstration in Blackboard under the recordings link.

To install these virtual machines, we will download pre-installed machines, referred to as boxes, from the [Vagrant Box Repo](https://app.vagrantup.com/boxes/search "webpage for Vagrant Box Repo") the first step is to open your Terminal program.

We will install 4 Linux virtual machines:

* Ubuntu Jammy 22.04 server
* Ubuntu Focal 20.04 server
* FreeBSD 13 server
* Debian Bullseye server

**Note** in this context the character **~** represents a shortcut to your user account's home directory. In my Windows system's case that would be: `C:\Users\palad`.  On my Mac Laptop it would be `/Users/jeremy` -- since everyone's account and OS is different the `~` is a universal short cut to represent whatever your user account's home directory. Also the `home directory` does not refer to `/home` in Linux either.

You will need to create a directory that is outside of your GitHub directory. I recommend to start in your Documents directory. Let's issue the command: `cd Documents`. Remember Windows is case INSENSITIVE and MacOS is case sensitive.

Once in the `Documents` directory, we will need to create one more directories to house all our Virtual Machine configurations. Using the `mkdir` command to create another directory named either `itmo-340` or `itmo-540`. Issue the command: `cd itmo-340` or `itmo-540`.

Now we can create 4 more directories, one for each virtual machine. Issue the command: `mkdir jammy64`, then the command: `mkdir focal64`, then the command: `mkdir freebsd13`, then the command: `mkdir debian11`.

Now we need to enter into each of these directories and initialize our virtual machines. Issue the command: `cd jammy64`, then issue this command: `vagrant init ubuntu/jammy64`. This command will create a file named: `Vagrantfile` and will tie this configuration file to Virtual Box properties for this virtual machine (jammy64). This file is a simple Key-Value pair, these settings are processed by `Vagrant` and translated into VirtualBox commands. Repeat these steps for each of the folders.

To create the remaining `Vagrantfiles`, we need to issue the change directory, `cd` command to move over to the next directory. You could also issue absolute paths, but in this case we will be issuing relative paths.

Issue the command: `cd ../focal64` to go up one directory and over into the `focal64` directory. Then issue the command `vagrant init ubuntu/focal64` to initialize the Vagrantfile for Ubuntu Focal Linux.

Next issue the command: `cd ../freebsd13` to go up one directory and over into the `freebsd13` directory. Then issue the command `vagrant init generic/freebsd13` to initialize the Vagrantfile for Rocky Linux.

Finally issue the command: `cd ../debian11` to go up one directory and over into the `debian11` directory. Then issue the command `vagrant init debian/bullseye64` to initialize the Vagrantfile for Debian 11, codenamed Bullseye.

### Editing of Vagrantfile to Configure Network Settings

We need to edit one setting in each of the newly created `Vagrantfile`. You can edit files in place by using `VS Code` from the terminal via the `code` command (use the appropriate `itmo-340` or `itmo-540`).

1. `code ~/Documents/itmo-340/focal/Vagrantfile`
1. `code ~/Documents/itmo-340/freebsd13/Vagrantfile`
1. `code ~/Documents/itmo-340/debian11/Vagrantfile`
1. `code ~/Documents/itmo-340/jammy/Vagrantfile`

In the first three files - you will want to edit line **35**, first delete the `#` to uncomment the code to add a host-only network interface.  A **host-only** network creates a virtual network on your own PC between your Host Operating System (Windows and Mac) and your virtual machines. We will use this feature of VirtualBox to quickly configure a network on your own laptop/desktop. Each person will need to set a unique IP address for each line 35 in the `Vagrantfile`. I recommend to start with the date of your birthday and increment. My birthday is November 18th so I will modify the default IP address to be `192.168.33.18`. My configuration file look like this:

#### Focal Ubuntu Configuration

```ruby
  config.vm.network "private_network", ip: "192.168.33.18"
```

#### FreeBSD 13 Configuration

```ruby
  config.vm.network "private_network", ip: "192.168.33.19"
```

#### Debian 11 Linux Configuration

```ruby
  config.vm.network "private_network", ip: "192.168.33.20"
```

#### Jammy Ubuntu Configuration

For The Ubuntu Jammy Linux, we will uncomment line 40 and give the virtual machine a bridged network. This will place the virtual machine on your network and request a DHCP address. You will need to execute this from your home network. For those who are on the University Network, this won't work, but there will be open lab hours where there is a network that doesn't need you to register and authenticate and you can quickly do this part of the lab.

```ruby
config.vm.network "public_network"
```

### Getting the Virtual Machines Up and Running

Now that we have created the configuration files and setup our networking correctly, we can now begin to download the pre-made virtual machines. They are pre-built VMs provided by the community and are part of the [Vagrant Cloud](https://app.vagrantup.com/boxes/search "web page to Vagrant Cloud"). To get each virtual machine started we need to change directory, using the `cd` command into the directories where the Vagrantfile resides for each server. For example these commands will bring the virtual machines to a running state. *NOTE* - the first time we run the `vagrant up` command will involve a virtual machine download which could take from 5 to 15 mins per machine. This is only needed once.

* `cd ~/Documents/itmo-340/focal`
  * then execute: `vagrant up`
* `cd ~/Documents/itmo-340/freebsd13`
  * then execute: `vagrant up`
* `cd ~/Documents/itmo-340/debian11`
  * then execute: `vagrant up`
* `cd ~/Documents/itmo-340/jammy`
  * then execute: `vagrant up`

### Connecting to the Virtual Machines

You will need to open 4 terminal windows and execute each command in one terminal so that you can have connections to all 4 virtual machines at the same time. Using the `vagrant ssh` command will connect you via a remote shell to the command line terminal of each server. This will allow you to install software, execute commands, and inspect the network on each virtual machine - without needing an entire laboratory of computers and equipment for each student. Your laptop/pc is enough for now using VirtualBox and Vagrant.

1. `cd ~/Documents/itmo-340/focal` then execute: `vagrant ssh`
1. `cd ~/Documents/itmo-340/freebsd13` then execute: `vagrant ssh`
1. `cd ~/Documents/itmo-340/debian11` then execute: `vagrant ssh`
1. `cd ~/Documents/itmo-340/jammy` then execute: `vagrant ssh`

### Installing the Software

There is a small amount of software we need to install on each virtual machine. Since these are Debian based Linux and one FreeBSD systems, they are all a bit different than MacOS and Windows. Here are the commands needed to execute the lab and answer the questions. We will install Web Servers and a commandline version of WireShark called T-Shark. In addition we will execute some network configuration commands and do some T-Shark captures.

* `Focal`
  * Display the operating system version: `cat /etc/os-release`
  * Install a webserver and tshark: `sudo apt update` and then `sudo apt install nginx tshark`
  * Display the ip address information: `ip a sh`
* `FreeBSD 13`
  * Display the operating system version: `cat /etc/os-release`
  * Install a webserver and tshark: `sudo pkg install nginx tshark`
  * Start the Nginx service: `sudo service nginx start`
  * Display the ip address information: `ifconfig`
* `Debian 11`
  * Display the operating system version: `cat /etc/os-release`
  * Install a webserver and tshark: `sudo apt update` and then `sudo apt install nginx tshark`
  * Display the ip address information: `ip a sh`
* `Jammy`
  * Display the operating system version: `cat /etc/os-release`
  * Install a webserver and tshark: `sudo apt update` and then `sudo apt install nginx tshark`
  * Display the ip address information: `ip a sh`

### Shutting Down the Virtual Machines

When done with the lab or when done using these virtual machines you should power them off by issuing the `vagrant halt` command. Otherwise they will occupy disk and ram on your system when they don't need to be.

* `cd ~/Documents/itmo-340/focal`
  * then execute: `vagrant halt`
* `cd ~/Documents/itmo-340/freebsd13`
  * then execute: `vagrant halt`
* `cd ~/Documents/itmo-340/debian11`
  * then execute: `vagrant halt`
* `cd ~/Documents/itmo-340/jammy`
  * then execute: `vagrant halt`

### Deliverable

What to turn in
