# Tooling Assignment Packer

## Objectives

* Demonstrate the use of Virtual Machines and discuss how they can extend your PCs capabilities
* Discuss the tools used for x86 based Virtualization and Apple Silicon based virtualization
* Examine the benefits of constructing virtual machine text based templates
* Demonstrate using version control in conjunction with text based templates
* Examine and explain the benefits creating custom virtualization artifacts
* Explain the uses and advantages of the Packer platform in relation to virtual machine creation

## Outcomes

At the conclusion of this lab you will have investigated using a virtualization platform (x86 VirtualBox and M1 Parallels) and demonstrated the ability to build your own custom virtualization artifacts.  You will have discussed the advantages of using Packer and Vagrant and you will have implemented and deployed your own custom virtual machine artifacts.

### Packer - Part I

Taken from [https://packer.io](https://packer.io "Packer webpage"): Why Packer?

* Multi-provider Portability
  * Identical images allow you to run dev, staging, and production environments across platforms.
* Improved Stability
  * By provisioning instances from stable images installed and configured by Packer, you can ensure buggy software does not get deployed.
* Increased Dev / Production Parity
  * Keep dev, staging, and production environments as similar as possible by generating images for multiple platforms at the same time.
* Reliable Continuous Delivery
  * Generate new machine images for multiple platforms, launch and test, and verify the infrastructure changes work; then, use Terraform to put your images in production.
* Appliance Demo Creation
  * Create software appliances and disposable product demos quickly, even with software that changes continuously.

## Packer HCL2 template

Lets take a look and see how Packer is able to build virtual machines from a YAML based text file. For the sample code used in the next section you can issue the command `git pull` in the jhajek repo you cloned at the beginning of class to get the latest source code samples.  They will be located in the directory [packer-code-examples](https://github.com/illinoistech-itm/jhajek/tree/master/itmt-430/packer-code-examples "website for packer code exmaple"). Let us look at the file named: `ubuntu-22041-live-server.pkr.hcl`

```hcl

locals { timestamp = regex_replace(timestamp(), "[- TZ:]", "") }

packer {
  required_plugins {
    virtualbox = {
      version = ">= 1.0.4"
      source  = "github.com/hashicorp/virtualbox"
    }
  }
}

source "virtualbox-iso" "ubuntu-22041-live-server" {
  boot_command          = ["<cOn><cOff>", "<wait5>linux /casper/vmlinuz"," quiet"," autoinstall"," ds='nocloud-net;s=http://{{.HTTPIP}}:{{.HTTPPort}}/'","<enter>","initrd /casper/initrd <enter>","boot <enter>"]
  boot_wait               = "5s"
  disk_size               = 15000
  guest_additions_path    = "VBoxGuestAdditions_{{ .Version }}.iso"
  guest_os_type           = "Ubuntu_64"
  http_directory          = "subiquity/http"
  http_port_max           = 9200
  http_port_min           = 9001
  iso_checksum            = "sha256:10f19c5b2b8d6db711582e0e27f5116296c34fe4b313ba45f9b201a5007056cb"
  iso_urls                = ["https://mirrors.edge.kernel.org/ubuntu-releases/22.04.1/ubuntu-22.04.1-live-server-amd64.iso"]
  shutdown_command        = "echo 'vagrant' | sudo -S shutdown -P now"
  ssh_username            = "vagrant"
  ssh_password            = "${var.user-ssh-password}"
  ssh_timeout             = "45m"
  vboxmanage              = [["modifyvm", "{{ .Name }}", "--memory", "${var.memory_amount}"]]
  virtualbox_version_file = ".vbox_version"
  vm_name                 = "ubuntu-jammy"
  headless                = "${var.headless_build}"
}

build {
  sources = ["source.virtualbox-iso.ubuntu-22041-live-server"]

  provisioner "shell" {
    execute_command = "echo 'vagrant' | {{ .Vars }} sudo -E -S sh '{{ .Path }}'"
    script          = "../scripts/post_install_ubuntu_2204_vagrant.sh"
  }

  post-processor "vagrant" {
    keep_input_artifact = false
    output              = "${var.build_artifact_location}{{ .BuildName }}-${local.timestamp}.box"
  }
}
```

There are two main sections to understand.  First is the **Source** section which tells us details about what needs to be built and how it will be built.  The second section, is the **Build** section and this section is the part of the code that executes the first section in order to build your virtualized artifact.

### Source Section

The source code in the [HCL (HashiCorp Language)](https://www.packer.io/guides/hcl "HCL web-site") document under the header marked source, tells Packer what Operating System it will be building.  It tells Packer what the answers to all the installation questions are going to be and it tells Packer which virtualization platform it should be using on the local system.

In this case, Packer is building a virtual machine using VirtualBox.   The documentation for the [VirtualBox ISO build method](https://www.packer.io/plugins/builders/virtualbox/iso "Packer vbox iso documentation web-site") is very helpful in allowing you to customize and expand this simple template.

### Build Section

The build section tells Packer what to build.  You can have multiple *source* sections in a single Packer build template. Within the Build portion of the template, there are two additional optional sections: provisioners and post-processors

### Provisioners

[Provisioners](https://www.packer.io/docs/provisioners "Packer provisioners web-page") are an extra feature of Packer. This allows you to execute additional commands after the initial install is completed.  This allows you to separate the installation template and the ability to customize your artifacts.  You can reuse the same template to build many Ubuntu Server Virtual Machines, but use a single or multiple shell script to install different software in each virtual machine.  You can see the source code on the line that has **script**: `script = "../scripts/post_install_ubuntu_2204_vagrant.sh"`

You can also use inline shell commands for customizing your artifact.  Packer will manage all of this using an SSH session.

### Post-Processors

This is one of the best features of Packer.  Not only is Packer able to build a Virtual Machine artifact from a single *.pkr.hcl document, but it is able to convert a single artifact into 1 of 30 other formats.  This allows for a single standardized template to be built, checked for compliance, version controlled, and converted all in a single step.

List of Post-Processor Options:

* 1&1
* Alicloud
* Anka
* Ansible
* Amazon EC2
* Azure
* Chef
* Cloudstack
* DigitalOcean
* Docker
* Google Cloud Platform
* HashiCups
* hcloud
* HuaweiCloud
* Hyper-V
* InSpec
* JD Cloud
* Kamatera
* Linode
* Naver Cloud
* Openstack
* Oracle
* Outscale
* Parallels
* Proxmox
* QEMU
* Scaleway
* Tencent Cloud
* Vagrant
* VirtualBox
* VMware vSphere
* VMware
* Yandex

At the conclusion of our Packer build template we will have Packer export our VirtualBox artifact and turn it into a Vagrant *.box file -- which we will then import into Vagrant so that we can run and use the artifact for us. We will walk through this manually, but you will quickly see places where these steps can be automated via a PowerShell or Zsh/Bash script.

## Tutorial Steps

These steps will walk you through building a custom VirtualBox Image from a Packer Template. The objectives for doing this are to show you how you can build your own virtual machines with your custom setup of software. This is a quick way to setup a multi-node network and install the same software you will be using on your production Operating Systems.

### Acquiring the Packer Sample Templates

The first templates we will be building will be on your local systems. We will be creating a 2 VM node using VirtualBox. This assumes you are working on an x86 system. If using the Apple Silicon your instructions will be mostly the same, the templates will be different.

The second step will be the IT Operations for your team deploying a Packer Build Tempalte to build the same software to our production cloud using Packer, Terraform, and Proxmox -- our Virtualization Platform. 

You will find two folders, one for local VirtualBox build, the other for your team repo to build and deploy on our production server. Lets start with the first one

### Acquiring the Packer Sample Templates to build VirtualBox VMs for Vagrant

To get a hold of the Packer Build Template samples, you will need to clone an additional repo to your host systems (MacOS, Windows, or Linux). Issue the command: `git clone https://github.com/illinoistech-itm/jhajek`. There will be many directories with sample code from other classes, but all you are interested in is the `itmt-430` directory and the conent in the `example-code` folder. For the first part, copy the `packer-virtualbox-example` code directory out of the `example-code` directory and place a copy into your GitHub repo under the `itmt-430` folder -- **Note:** do not clone the `jhajek` repo directly into your own repo. Repos and not meant to be mixed together and can cause unexpected behavior.

### Building Your Own Virtual Machines Using Packer and VirtualBox

The sample code provided is heavily templated, to allow many people to use without hard-coding specific values or secrets into the template. There will be a few steps to and values that we need to fill out. Let's take a look at the file named: `ubuntu22041-server.pkr.hcl`.

### Ubuntu 2204.1 Packer Template 

### Working with Vagrant and the Output Artifact - Part II

Upon success from your terminal you will see dialog similar to this in your terminal:

```bash

Build 'virtualbox-iso.ubuntu-22041-live-server' finished after 13 minutes 41 seconds.

==> Wait completed after 25 minutes 41 seconds

==> Builds finished. The artifacts of successful builds are:
--> virtualbox-iso.ubuntu-22041-live-server: 'virtualbox' provider box: ../build/ubuntu-22041-live-server-20220207051528.box
```

* The last line tells you were the Vagrant Box artifact is located.
  * This location can be changed, it is defined on line 42 of the file: `ubuntu22041-vanilla-live-server.pkr.hcl`
  * Currently the location is set for: `../build/`
  * Let us issue the `cd` command into the `../build` directory and issue an `ls`, what do you see?
  * There should be a file with a similar name: `ubuntu-22041-live-server-20220207051528.box`

Now we need to add this *.box file to Vagrant so we can start, stop, and ssh to it with Vagrant.

* In the current directory issue the command: `mkdir ubuntu-vanilla`
  * This will be the directory where we store our `Vagrantfile`
  * Issue the command: `vagrant box add ./ubuntu-22041-live-server-20220207051528.box --name ubuntu-vanilla`
  * Your file name will have different numbers (timestamp)
  * The --name option should match the directory name it helps keep track of things
  * `cd` into the `ubuntu-vanilla` directory and issue the command: `vagrant init ubuntu-vanilla`
  * Then issue the commands: `vagrant up ; vagrant ssh` and you will find yourself SSH'd into your Vagrant Box
  * Remember to shut it down by issuing the command to exit the SSH session and then: `vagrant halt`
  * You can see the new box added to Vagrant by issuing the command: `vagrant box list`

### Additional Information on how to delete a vagrant box

For this assignment, this step is optional, but I wanted to expose you to it as you will have to use this in your scripts to automate the deployment and recreation of your application. To delete the box from the `ubuntu-vanilla` directory:

* Issue the command: `vagrant box remove ubuntu-vanilla`
  * You can also use a `-f` flag to force the action
  * You will also need to manually delete the `.vagrant` directory left behind: `rm -rf ./.vagrant`

### Notes while build the Vagrant box via packer

* The Packer build process may take anywhere from 10 to 25 minutes based on your system hardware
  * Note the initial build will take longer as you have to download the Ubuntu/Rocky Linux installation ISO file
  * It is cached for subsequent use in the local directory `./packer_cache`
  * Note that on Windows there is no download meter, it will appear the process is frozen, its not, just have to be patient

## Now lets use the build server

We have a central build server with lots of disk, CPU, and memory to allow you to build and retrieve your Vagrant Boxes

The build server hardware:

* 67 GB DDR4 2133 MHz
* Intel(R) Xeon(R) CPU E5-2620
* 2 500 GB disks, with PCIe based NVMe ZFS write and read caches
  * You can run the command: `zpool iostat -v` to watch the caches working

* Each of you has access to this server on campus and remotely via the schools VPN software
  * In order to access the Build Server from off campus you need to go to [https://vpn-1.iit.edu](https://vpn-1.iit.edu "School VPN software website") and use your Portal Authentication
  * Install the Cisco VPN software
  * Note you only need this if you are working off of the campus - inside the campus network VPN is not needed
  * You would use your HAWK portal credentials to authenticate
    * If you have an issue please post to Discussion Board
* You need to generate one more Twisted Edward Curve key (Public/Private key) as you did in the previous section
  * Name this key: `id_ed25519_HAWKID_key` -- replace HAWKID with your hawkID
  * Submit the `id_ed25519_HAWKID_key.pub` key to Blackboard so I can add this to the account I made for you on the Build Server
  * Once submitted and I add the key, you will be able to SSH via RSA key into the build server
* From your Terminal issue the command: `ssh -i ~/.ssh/id_ed25519_HAWKID_key HAWKID@192.168.172.44`
  * The HAWKID value is just the ID part, no @hawk.iit.edu
  * Here you will have access to a command line
* Within your home directory you can create another RSA keypair, add the public key to you GitHub repo, and create a `config` file on the BuildServer
  * Follow the steps and content for the `config` file as you created in the prior steps
* Test this by issuing the command: `git clone git@github.com:illinoistech-itm/jhajek.git`
  * Replace jhajek with your Repo ID
  * Now you will be able to run your Packer build commands using the faster build system hardware

* On the build server, in the directory `packer-example-code` locate the file `template-for-variables.pkr.hcl`
  * Rename this file to: `variables.pkr.hcl`
  * Edit line 3 to say true -- the build server has no GUI, without this change there will be an error
  * Edit line 15 to have the value: `vagrant` -- this is the default password I set
  * Comment line 20 out -- this is only for building on your host OS
  * Uncomment line 25, replacing the term: XYZ with your initials, team name, or other unique identifier.  The rest of the path is the required path to place the build artifact on a webserver for download
* Upon completion of the Packer build command, on your Host OS open a web-browser and navigate to [http://192.168.172.44/boxes](http://192.168.172.44/boxes "internal URL for build server")
* You will see your own Vagrant box artifact - which you can click on to download to your local system.
  * Repeat the steps you used in the section: **Working with Vagrant and the Output Artifact - Part II** to add the *.box file via Vagrant to your system, naming it `ubuntu-vanilla-build-server`

* ~~Your team will use this process for Sprint 2 to build all 5 required boxes and each person will have access to the build artifacts~~

### M1 Macs Note

Due to the newness of M1 macs, I don't have any build hardware for the remote building of ARM based VMs, only x86. To continue the assignment you can switch to using the non-arm build template provided.  You should still build the artifact following the below steps, you just won't be able to run it on your M1 due to it being an x86 based artifact. The M1 is a fast machine, you will have to use your own system as a build server for this assignment.  When it is your turn as the IT Operations comes around you will still use the Build Server to build for everyone else.

* Once your .box file has been downloaded to your Host OS, you can move it to the `build` directory where we first added the `ubuntu-vanilla` box
  * Let's repeat those steps: issue the command: `mkdir ubuntu-vanilla-build-server`
  * Issue the command: `vagrant box add ./XYZ-ubuntu-22041-live-server-20220207051528.box --name ubuntu-vanilla-build-server`
  * Note that you want to make sure you add the correct box file
  * Also once you have successfully added the Vagrant .box file, the actual .box file is no longer needed, think of it like the wrapping on a package, you can delete it
  * `cd` into the `ubuntu-vanilla-build-server` and issue the command: `vagrant init ubuntu-vanilla-build-server`
  * Issue the commands: `vagrant up; vagrant ssh`
  * You will have now successfully have used remote build infrastructure to build the first of your projects Virtual Machines
* Issue the command: `vagrant box list` to see the boxes that Vagrant manages

## Summary

We went through using HashiCorp Packer and Vagrant to completely automate the building of Infrastructure to be used in the creation of our 3-tier application.  We covered using secure remote authentication to leverage build server infrastructure.  We provided you with a demonstration of how to use these tools and to leverage them to help automate tasks as well as version control them for audit and inspection.

## Deliverable

Submit the URL as designated in the file: `tooling-assignment-packer.md`
