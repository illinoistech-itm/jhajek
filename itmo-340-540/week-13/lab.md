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
* Debian 11 Bullseye server

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

In the first three files - you will want to edit line **35**, first delete the `#` to uncomment the code to add a host-only network interface.  A **host-only** network creates a virtual network on your own PC between your Host Operating System (Windows and Mac) and your virtual machines. We will use this feature of VirtualBox to quickly configure a network on your own laptop/desktop. Each person will need to set a unique IP address for each line 35 in the `Vagrantfile`. I recommend to start with the date of your birthday and increment. My birthday is November 18th so I will modify the default IP address to be `192.168.33.18`. If your birthday is on the first - just add a zero and start from 10. My configuration file looks like this:

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

```ruby
  config.vm.network "private_network", ip: "192.168.33.21"
```

In addition, for The Ubuntu Jammy Linux, we will uncomment line 40 and give the virtual machine a bridged network. This will place the virtual machine on your network and request a DHCP address. You will need to execute this from your home network. For those who are on the University Network, the school requires you to register each machine on the network for tracking purposes. This won't work, but there will be open lab hours where there is a network that doesn't need you to register and authenticate and you can quickly do this part of the lab in the Tech South building - TS-2030.

```ruby
config.vm.network "public_network"
```

### Getting the Virtual Machines Up and Running

Now that we have created the configuration files and setup our networking correctly, we can now begin to download the pre-made virtual machines. "*Vagrant boxes*" are pre-built VMs provided by the community and part of the [Vagrant Cloud](https://app.vagrantup.com/boxes/search "web page to Vagrant Cloud"). To get each virtual machine started we need to change directory, using the `cd` command into the directory where the `Vagrantfile` resides for each server. For example these commands will bring the virtual machines to a running state. *NOTE* - the first time we run the `vagrant up` command will involve a virtual machine download which could take from 5 to 15 mins per machine. This is only needed once.

* `cd ~/Documents/itmo-340/focal`
  * then execute: `vagrant up`
* `cd ~/Documents/itmo-340/freebsd13`
  * then execute: `vagrant up`
* `cd ~/Documents/itmo-340/debian11`
  * then execute: `vagrant up`
* `cd ~/Documents/itmo-340/jammy`
  * then execute: `vagrant up`

### Connecting to the Virtual Machines

You will need to open four terminal windows and execute each command in one terminal so that you can have connections to all 4 virtual machines at the same time. Using the `vagrant ssh` command will connect you via a remote shell to the command line terminal of each server. This will allow you to install software, execute commands, and inspect the network on each virtual machine - without needing an entire laboratory of computers and equipment for each student. Your laptop/pc is enough for now using VirtualBox and Vagrant.

1. `cd ~/Documents/itmo-340/focal` then execute: `vagrant ssh`
1. `cd ~/Documents/itmo-340/freebsd13` then execute: `vagrant ssh`
1. `cd ~/Documents/itmo-340/debian11` then execute: `vagrant ssh`
1. `cd ~/Documents/itmo-340/jammy` then execute: `vagrant ssh`

### Installing the Software

There is a small amount of software we need to install on each virtual machine. Since these are Debian based Linux and one FreeBSD systems, they are all a bit different than MacOS and Windows. Here are the commands needed to execute the lab and answer the questions. We will install Web Servers and a commandline version of WireShark called T-Shark. In addition we will execute some network configuration commands and do some T-Shark captures. The command `cat /etc/os-release` is just to print out the operating system version information to make sure you are on the correct server.

* `Focal`
  * Display the operating system version: `cat /etc/os-release`
  * Install a webserver and tshark: `sudo apt update` and then `sudo apt install nginx tshark`
  * Display the network information: `ip a sh`
* `FreeBSD 13`
  * Display the operating system version: `cat /etc/os-release`
  * Install a webserver and tshark: `sudo pkg install nginx tshark`
  * Start the Nginx service: `sudo service nginx start`
  * Display the network information: `ifconfig`
* `Debian 11`
  * Display the operating system version: `cat /etc/os-release`
  * Install a webserver and tshark: `sudo apt update` and then `sudo apt install nginx tshark`
  * Display the network information: `ip a sh`
* `Jammy`
  * Display the operating system version: `cat /etc/os-release`
  * Install a webserver and tshark: `sudo apt update` and then `sudo apt install nginx tshark`
  * Display the network information: `ip a sh`

Not all four virtual machines need to be running always, you can start and stop them as needed. See the final section **Shutting Down the Virtual Machines** for details to halt your VMs.

## Lab Question One

Our purpose here is to explore and discover commandline tools to find your Network Card information. Each system has many physical and virtual network interfaces to operate on. First step for your host system is to decide if you are using the WiFi interface or the Ethernet interface. Second step on your host system is to determine what your active virtual network interface is. The clue is to look for the ip of `192.168.33.1`. For the virtual machines we will be looking at interface `enp0s8`, on FreeBSD we will be looking for interface em1, and on Debian interface eth1. We will be using the following commands to do our discovery:

* Windows: `ipconfig`
* MacOS and FreeBSD: `ifconfig`
* Linux: `ip`

Using the above commands, on your host system and on each of the virtual machines execute the proper command (per operating system) and report the following information:

| OS | Value |
| -- | ------|
| Your OS IP | - |
| Your Virtual NIC | - |
| Focal IP | - |
| FreeBSD IP | - |
| Debian IP | - |
| Jammy enp0s8 IP | - |
| Jammy enp0s9 IP | - |

Using the above commands, on your host system and on each of the virtual machines execute the proper command (per operating system) and report the following information:

| OS | Value |
| -- | ------|
| Your OS MAC | - |
| Your Virtual NIC MAC | - |
| Focal MAC | - |
| FreeBSD MAC | - |
| Debian MAC | - |
| Jammy enp0s8 MAC | - |
| Jammy enp0s9 MAC | - |

Using the above commands, on your host system and on each of the virtual machines execute the proper command (per operating system) and report the following information:

| OS | Value |
| -- | ------|
| Your OS Subnet | - |
| Your Virtual NIC Subnet | - |
| Focal Subnet | - |
| FreeBSD Subnet | - |
| Debian Subnet | - |
| Jammy enp0s8 Subnet | - |
| Jammy enp0s9 Subnet | - |

Using the routing table information, find each systems default gateway or default route for the interface that you identified in the first step of this exercise. On Windows, Mac, and FreeBSD use the command `netstat -r`, Linux no longer supports the netstat command, use the `ip -r` command.

| OS | Destination CIDR Block | Interface |
| -- | ------| ---- |
| Your OS | - | - |
| Your Virtual NIC | - | - |
| Focal | - | - |
| FreeBSD | - | - |
| Debian | - | - |
| Jammy enp0s8 | - | - |
| Jammy enp0s9 | - | - |

## Lab Question Two

For this exercise, ignore any packets relating to 239.255.255.250. We will be using the ICMP protocol to communicate with other systems on our network. The ICMP echo protocol was defined very early in [RFC 792](https://www.rfc-editor.org/rfc/rfc792 "webpage rfc 792"). This will also involve the [ARP protocol](https://www.rfc-editor.org/rfc/rfc1027 "webpage for rfc1027") and display how LANs operate -- at the link layer.

Enter the Debian 11 virtual machine via the command: `vagrant ssh` if you are not already logged in. Issue the command `sudo tshark -i eth1 -c 14`, note that after the confirmation text, there is no output.

Now in another terminal windows, in the directory for `focal64` enter the command: `vagrant ssh`. Once connected into the Focal virtual machine, issue the command: `ping -c 5 192.168.33.X` -- where X is the IP address of your Debian 11 system. In both cases the `-c N` is limiting the count of packets sent and captured. You can always use the key combo: `ctrl-c` to break out of the tshark capture if there are no more packets coming.

Use the command: `ip n` to show the ARP tables of each system in between the triple tics after executing the previous commands.

```
Focal
192.168.33.18 dev eth1 lladdr 08:00:27:4d:c2:00 STALE
10.0.2.3 dev eth0 lladdr 52:54:00:12:35:03 STALE
10.0.2.2 dev eth0 lladdr 52:54:00:12:35:02 DELAY
```

```
Debian
192.168.33.18 dev eth1 lladdr 08:00:27:4d:c2:00 STALE
10.0.2.3 dev eth0 lladdr 52:54:00:12:35:03 STALE
10.0.2.2 dev eth0 lladdr 52:54:00:12:35:02 DELAY
```

```
Your samples here
```

1. Looking back at the output of the tshark capture on the Debian system, can you briefly explain why the first two packets captured are ARP packets?  
i.

1. Run the experiment again, this time the first two packets are not ARP packets -- why do you think this is the case?  
i.

## Lab Question Three

This exercise will use the Wireshark capture on your host OS as we connect over our virtual network to a webserver running on one of our virtual machines. For this we will select the `FreeBSD 13` virtual machine. To make sure the Nginx webserver is running, make sure from the directory where you ran the `vagrant up` command, that you have executed, `vagrant ssh`. Run the command: `sudo service nginx start` to confirm that the service is running.

Open WireShark on your host OS. Select the interface that is your virtual network interface (identified in Lab Question One). The capture will have no traffic when you start the capture, don't worry, it is much less chatty than your main WiFi or Ethernet connection. Open a browser tab on your host OS. Using **http** enter the address of the virtual machine into the browser address bar. Take note of the WireShark capture. Capture all the way until you see the connection termination (FIN - FIN/ACK) about 30 packets total.

Save this capture file in WireShark as `week13-q3.pcapng` submit this along with the markdown lab.md document.

Answer the following questions:

1. Why are the first two packets (approximately) ARP packets?  
i.

1. What is the HTTP request type being sent for the `/` (index file)?  
i.

1. What is the HTTP response code sent back for this request and did it succeed?  
i.

1. The browser made and addition HTTP request - what additional file did it request?  
i.

1. What was the response code and did this request succeed?  
i.

## Lab Question Four

This question will deal with the [DHCP protocol - RFC 2131](https://www.rfc-editor.org/rfc/rfc2131 "webpage rfc2131"). We will see forwarding decisions take place when communicating between hosts and over multiple switches. We will make use of the Jammy Linux and our host OS for this last question.

On your host OS terminal execute the command: `ping -c 4 64.131.110.67` (where the IP is the IP of your primary network interface) and then execute the command:`ping -c 4 192.168.33.X` (where X is the IP of your Jammy Linux system). Answer the following questions:

1. Why are both of these commands successful when they are two different networks?  
i.

1. Using the `netstat -r` command on your host OS and answers from question one, identify the routes on your computer that make this work.  
i.

On your host OS, Start a WireShark capture for your primary WiFi or Ethernet connection. Issue the command to release your IP address on your primary Ethernet or WiFi connection: `ipconfig /release Ethernet` or `ipconfig /release WiFi`. Now we will issue a DHCP request for a new IP address, with the WireShark capture still running issue the command: `ipconfig /renew Ethernet` or `ipconfig /renew WiFi`. The MacOS combines these into one command: `sudo ipconfig set en0 DHCP` for WiFi the interface name is traditionally `en1`. When this command returns successfully, you can stop the WireShark capture. You will want to use a WireShark filter (dhcp) to show only the packets we require.

1. Looking in the WireShark capture, in the DHCP OFFER packet, at the application level, list all of the details of the option fields and give a quick explanation of each item. You can skip *Rebinding Time*  
i.  
i.  
i.  
i.  
i.  
i.  
i.  
i.  

1. What are the four phases of acquiring an IP address via DHCP?  
i.

## Lab Question Five

Using the Debian 11 virtual machines, issue the command `ping -c 4 google.com` and you will receive 4 ICMP echo replies from a Google.com server. Then issue the `ip r` command to look at the routing table for the virtual machine. Briefly explain how your ICMP packet (the ping command) makes it from your virtual machine to Google.com and back to your virtual machine, when the Virtual Machine has a private non-routable IP address (192.168.33.X).  
i.

### Shutting Down the Virtual Machines

When done with the lab or when done using these virtual machines you should power them off by issuing the `vagrant halt` command. Otherwise they will occupy CPU and RAM on your system.

* `cd ~/Documents/itmo-340/focal`
  * then execute: `vagrant halt`
* `cd ~/Documents/itmo-340/freebsd13`
  * then execute: `vagrant halt`
* `cd ~/Documents/itmo-340/debian11`
  * then execute: `vagrant halt`
* `cd ~/Documents/itmo-340/jammy`
  * then execute: `vagrant halt`

### Deliverable

Follow the tutorial instructions and answer the outstanding questions in this document. Place this file along with the required WireShark capture to your GitHub repo under the week-13 folder. Submit the URL to Blackboard.
