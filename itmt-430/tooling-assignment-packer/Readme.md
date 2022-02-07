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

### Packer

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

Lets take a look and see how Packer is able to build virtual machines from a YAML based text file. For the sample code used in the next section you can issue the command `git pull` in the jhajek repo you cloned at the beginning of class to get the latest source code samples.  They will be located in the directory [packer-code-examples](https://github.com/illinoistech-itm/jhajek/tree/master/itmt-430/packer-code-examples "website for packer code exmaple"). Let us look at the file named: `ubuntu20043-vanilla-live-server.pkr.hcl`

```hcl

locals { timestamp = regex_replace(timestamp(), "[- TZ:]", "") }

source "virtualbox-iso" "ubuntu-20043-live-server" {
  boot_command            = ["<enter><enter><f6><esc><wait> ", "autoinstall ds=nocloud-net;seedfrom=http://{{ .HTTPIP }}:{{ .HTTPPort }}/", "<enter><wait>"]
  boot_wait               = "5s"
  disk_size               = 15000
  guest_additions_path    = "VBoxGuestAdditions_{{ .Version }}.iso"
  guest_os_type           = "Ubuntu_64"
  http_directory          = "subiquity/http"
  http_port_max           = 9200
  http_port_min           = 9001
  iso_checksum            = "sha256:f8e3086f3cea0fb3fefb29937ab5ed9d19e767079633960ccb50e76153effc98"
  iso_urls                = ["http://mirrors.kernel.org/ubuntu-releases/20.04.3/ubuntu-20.04.3-live-server-amd64.iso"]
  shutdown_command        = "echo 'vagrant' | sudo -S shutdown -P now"
  ssh_wait_timeout        = "1800s"
  ssh_password            = "${var.SSHPW}"
  ssh_port                = 2222
  ssh_timeout             = "20m"
  ssh_username            = "vagrant"
  vboxmanage              = [["modifyvm", "{{ .Name }}", "--memory", "${var.memory_amount}"]]
  virtualbox_version_file = ".vbox_version"
  vm_name                 = "ubuntu-focal"
  headless                = "${var.headless_build}"
}

build {
  sources = ["source.virtualbox-iso.ubuntu-20043-live-server"]

  provisioner "shell" {
    #inline_shebang  =  "#!/usr/bin/bash -e"
    inline          = ["echo 'Resetting SSH port to default!'", "sudo rm /etc/ssh/sshd_config.d/packer-init.conf"]
    }

  provisioner "shell" {
    execute_command = "echo 'vagrant' | {{ .Vars }} sudo -E -S sh '{{ .Path }}'"
    script          = "../scripts/post_install_ubuntu_2004_vagrant.sh"
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

[Provisioners](https://www.packer.io/docs/provisioners "Packer provisioners web-page") are an extra feature of Packer. This allows you to execute additional commands after the initial install is completed.  This allows you to separate the installation template and the ability to customize your artifacts.  You can reuse the same template to build many Ubuntu Server Virtual Machines, but use a single or multiple shell script to install different software in each virtual machine.  You can see the source code on the line that has **script**: `script = "../scripts/post_install_ubuntu_2004_vagrant.sh"`

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

On your local system we will need to generate at least two Public/Private Keypairs.  This will enable us to replace using Personal Access Tokens and secure our source code deployment while automating it.

### SSH Setup Steps

* Execute the command: `ssh-keygen -t ed25519` ([Twisted Edwards Curve](https://en.wikipedia.org/wiki/Twisted_Edwards_curve "wiki site for Twisted Edwards Curve"))
  * Store the key in the default location of the `.ssh` directory under your home directory and name it: `id_ed25519_git_key`
  * Hit enter to skip the passphrase portion of the key creation
* Create a second keypair named: `id_ed25519_packer_key`
* Using the `cat` command, display the content of the `id_ed25519_git_key.pub` - copy this content to the clipboard
  * In your GitHub private repo page open the icon in the upper right hand corner and click on SETTTINGS
  * Click on the SSH and GPG keys left hand menu link
  * Click the Green **New SSH Key** button and paste the content into the new key
* Go back to your main GitHub repo page and click the Green Clone button, but this time select the **SSH** tab and not *https*
  * Copy this URL to the clip board

Upon finishing this step we will need to adjust our [Git Remote URL](https://devconnected.com/how-to-change-git-remote-origin/ "website to adjust git remote url").

* Open a terminal (MacOS or Windows) and issue the command: `git remote -v`, note the output, it still points to https
  * We need to change the remote URL value to be the git URL.  Issue this command: `git remote set-url origin git@github.com:illinoistech-itm/jhajek.git`
  * Issue the command: `git remote -v` to see that it has changed
* In the `.ssh` directory on your host system you need to create a file named: `config`
  * This file will have overloads so that when you use Git the keys will be automatically configured
  * The `config` file should have similar content (change my ID our to yours)

```bash
Host github.com
  User jhajek
  Hostname github.com
  IdentityFile ~/.ssh/id_ed25519_git_key
```

### Acquiring the Packer Sample Templates

To get a hold of the Packer Build Template samples, issue the command: `git pull` from the jhajek repo directory you cloned previously.  Copy the packer-example-code directory over to your private repo under the `itmt-430` directory.

* To setup the template to use the second RSA key you generated, issue the command: `cat ~/.ssh/id_ed25519_packer_key.pub` and copy that value.
  * In the sample code you just copied to your own private repo, navigate to the directory ubuntu_20043_vanilla > subiquity > http > user-data.  
  * Proceed to edit the `user-data` file, line 30, adding the contents of `id_ed25519_packer_key.pub` to the value
  * `- 'ssh-rsa '` would become `- 'ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDu9nNkiO5LiIK8SUKLq59DnVGjU3R6H+K5jMxJTGfW+ controller@lenovo-laptop'`
    * Your PUBLIC key will have a similar structure but different value
* Upon completing the prior steps you can now build your first virtual machine with Packer
  * Note if you are on an M1 Mac use the `ubuntu_20043_vanilla-arm` directory but otherwise all commands are the same
* `cd` into the directory with the Packer build templates (ubuntu_20043_vanilla or ubuntu_20043_vanilla-arm)
  * Packer has a feature where instance variables can be declared and read in at run time.  This is helpful if you want to make a template and change variable values per instance -- this prevents you from having to have multiple copies of the same template for different variables.
  * You need to rename the variables template file to variables.  Issue the command: `mv template-for-variables.pkr.hcl variables.pkr.hcl`
  * Using this convention, the file `variables.pkr.hcl` is ignored but the .gitignore file -- now you can distribute a template and then customize the variables and not have to worry about committing any sensitive configuration settings to your repo.
  * You will need to change line 12 in the file `varialbes.pkr.hcl` to have the value: `vagrant` for that is the default password I setup
* To build the artifact, issue the command: `packer validate .` and if all comes back positive, issue the command: `packer build .`

### Working with Vagrant and the Output Artifact

Upon success from your terminal you will see dialog similar to this in your terminal:

```bash

Build 'virtualbox-iso.ubuntu-20043-live-server' finished after 13 minutes 41 seconds.

==> Wait completed after 13 minutes 41 seconds

==> Builds finished. The artifacts of successful builds are:
--> virtualbox-iso.ubuntu-20043-live-server: 'virtualbox' provider box: ../build/ubuntu-20043-live-server-20220207051528.box
```

* The last line tells you were the Vagrant Box artifact is located.
  * This location can be changed, it is defined on line 42 of the file: `ubuntu20043-vanilla-live-server.pkr.hcl`
  * Currently the location is set for: `../build/`
  * Let us issue the `cd` command into the `../build` directory and issue an `ls`, what do you see?
  * There should be a file with a similar name: `ubuntu-20043-live-server-20220207051528.box`

Now we need to add this *.box file to Vagrant so we can start, stop, and ssh to it with Vagrant.

* In the current directory issue the command: `mkdir ubuntu-vanilla`
  * This will be the directory where we store our `Vagrantfile`
  * Issue the command: `vagrant box add ./ubuntu-20043-live-server-20220207051528.box --name ubuntu-vanilla`
  * Your file name will have different numbers (timestamp)
  * The --name option should match the directory name it helps keep track of things
  * `cd` into the `ubuntu-vanilla` directory and issue the command: `vagrant init ubuntu-vanilla`
  * Then issue the commands: `vagrant up ; vagrant ssh` and you will find yourself SSH'd into your Vagrant Box
  * Remember to shut it down by issuing the command to exit the SSH session and then: `vagrant halt`
  * You can see the new box added to Vagrant by issuing the command: `vagrant box list`

* To delete the box from the `ubuntu-vanilla` directory
  * Issue the command: `vagrant box remove ubuntu-vanilla`
  * You can also use a `-f` flag to force the action
  * You will also need to manually delete the `.vagrant` directory left behind: `rm -rf ./.vagrant`

## Summary


