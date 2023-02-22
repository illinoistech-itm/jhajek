# Tutorial to Connect to the Department Cloud Platform - Part I

This tutorial will demonstrate how to use class build-server, provided API keys, and the Department Cloud Platform, running on [Proxmox](https://proxmox.com/en/ "webpage for Proxmox Virtualization Platform"), using [Hashicorp Packer](https://packer.io "webapge for Packer.io") and [Terraform](https://terraform.io "webpage for Terraform").

## Overview

This tutorial assumes you have completed the Vagrant-Tooling-Assigment and the Packer-Tooling-Assignment under Sprint-02 in Blackboard. It is critical to complete those first -- this tutorial builds upon those concepts.

At the conclusion of this tutorial you will have succesfully connected to the remote buildserver and used Packer to build two virtual machine templates on the the Proxmox Virtualization Platform.

## Setup

This tutorial is specifically for the IT/Operations person in your group for Sprint-02, but eventually everyone will be able to do this starting Sprint-03. Sample templates are provided in the [jhajek](https://github.com/illinoistech-itm/jhajek "github repo for 430 sample code") repo. If you cloned the sample code in the previous Packer exercise, issue the command: `git pull` from the repo directory to get any update.  

**Note** you will need to upgrade your VirtualBox to 7.0.x if you have 6.1.x. You can do this from `choco upgrade virtualbox` on Windows or `brew upgrade virtualbox` on MacOS. This is due to modern Linux OSes cutting off support for older hardware -- which VirtualBox 6.1.x emulates. 

### Retrieving Template Examples

* Make sure you have cloned your team repo to your local system. From the `jhajek` repo copy the `example-code` directory from the `jhajek` -> `itmt-430` directory into the `build` folder in your team repo.

![*Build Folder Containing All Build Scripts*](./images/build.png "Image showing build folder in repo")

For now lets copy the directory entirely, there are the local Packer/VirtualBox examples which you won't need. You can delete them if you want. We will be focusing on the `proxmox-cloud-production-templates` directory.

### Additional Configuration Steps

* To have submitted your Public Key via blackboard and established a remote connection to the buildserver, which is `system44.rice.iit.edu`
* If off campus established school VPN access

Initial steps to complete on the buildserver once you log in:

* On the buildserver you will need to generate another keypair via the `ssh-keygen` command
  * This will be used by you (not shared) for cloning your team repo in your account on the buildserver (you could also clone your own repo as well if desired)
  * You will have to also generate a `config` file, as we did for our local systems when initally cloning our GitHub repos
  * You will need to have your team repo cloned to your local system, you won't be working on the buildserver, only deploying from it.
  * Each team member will want to duplicate these steps in their own buildserver account - but for now only IT/Operations needs to do so
  * You will need to add the content of the Public Key for this new keypair you generated on the server to your team-repo GitHub account for authentication
  * Test this connection via the command: `ssh git@github.com`, if all is ok, then proceed to clone the team repo

## Department Production Cloud Details

The ITM department has a mock production cloud. The purpose of this on-prem cloud is not neccesarialy robustness or SLA based security, but has a promise of *good-enough* with the added ability to make thing visible--so we can see what is going on internally to the cloud.

We provide the building blocks of *cloud*

* IAM - Identity and Access Management
  * API based access/restriction to all resources
  * Gives you monitoring and auditing
* Compute and Networking
  * Virtualization gives you EC2 and VPS
* Block Storage
* Storage
  * S3-like Object storage over HTTP
* All over API via HTTP

### Virtualization Platform (Elastic Compute)

The Virtualization template we chose for building this internal cloud runs on a software called: [Proxmox](https://proxmox.com "webpage for Proxmox"). This is a German company that runs and opensource platform. Essentially the platform is a GUI manager on top of [Debian Linux](https://debian.org "webpage for Debian Linux") and [KVM](https://en.wikipedia.org/wiki/Kernel-based_Virtual_Machine "webpage explaining Kernel based virtual Machines"). We call it elastic compute because we can expand or contract the amount of compute at will via an API call.

![*Proxmox GUI Console*](./images/proxmox.png "webpage for Proxmox GUI")

The functionaly is very similar to [VMware_ESXi](https://en.wikipedia.org/wiki/VMware_ESXi "webpage for VMware ESXi") or [Microsoft Hyper-V](https://learn.microsoft.com/en-us/virtualization/hyper-v-on-windows/quick-start/enable-hyper-v "webpage for Hyper-V"). 

### Cloud Network

Our Cloud platform has three attached networks:

* 192.168.172.0/24 is the private routable network available via the VPN or on campus, your virtual machines will be assigned an DHCP address from this IP range
* 10.0.0.0/16 is an internal non-routable network used to attach to an Ubuntu mirror so that all package updates happen over a local pre-configured network
* 10.110.0.0/16 is an internal non-routable network used for metrics collection (see Telemetry from chapter 14)
  * This uses a preconfigured event-router called `node-exporter` which is part of the `Prometheus` project
  * Each virtual machine launched will automatically register itself and begin reporting basic hardware metrics
  * This network also uses [Hashicorp Consul](https://consul.io "webpage for consul") for applciation discovery

### Proxmox API

Proxmox has an API that allows you to programatically access any action you can take in the GUI--such as create virtual machine, delete, and so forth. This API is controlled by a `token_id` and a `token_secret` -- these are standard issue for working with Cloud Native software, no passwords here.

The Proxmox API can be accessed in two ways: [Packer has a Proxmox builder](https://developer.hashicorp.com/packer/plugins/builders/proxmox/iso "webpage for Packer Proxmox-iso provider") which we can leverage to build Virtual Machine Templates for our Virtualization Platform and [Terraform has a Proxmox Provider](https://registry.terraform.io/providers/Telmate/proxmox/latest/docs "webpage for Proxmox Provider") as well. You will be provided with a `token_id` and `token_secret` per person - starting with just IT/Operations.

### Terraform 

When dealing with Cloud-Native application deployments, the concepts we are used to when installing operating systems onto PCs and Laptops change radically. On a new laptop you would have to install an operating system by retrieving an installation iso file and burning it to some installation media. Then you would manually step through installation questions. Though the cloud is just someone else's computer&trade;, you don't have physical access to *install* operating systems on the cloud.

You don't actually install anything--you create OS templates or `images` and upload them to each provider (AWS, Proxmox, Azure...) and then use a templated language to deploy many `instances` of an image. You may have a `database` image. You might have a `loadbalancer` image. You might have a `webserver` image. And you may want variable copies or `instances` of each of these `images`.

[Hashicorp Terraform](https://terraform.io "webpage for Terraform") is a platform nuetral way to programmatically deploy arbitrary numbers of instances from pre-made images. Packer will help make your templates, and Terraform helps you think in terms of deploying your application in total. Think of Terraform as Vagrant all grown up.

### Examples and HCL Templates

Let us start by unpacking the first Packer Proxmox template, `proxmox-jammy-ubuntu-front-back-template` > [proxmox-jammy-ubuntu-front-back-template.pkr.hcl](https://github.com/illinoistech-itm/jhajek/blob/master/itmt-430/example-code/proxmox-cloud-production-templates/packer/proxmox-jammy-ubuntu-front-back-template/proxmox-jammy-ubuntu-front-back-template.pkr.hcl "webpage showing packer proxmox first template") then we will go over each section and explain it. Most of it should look familiar to the Packer VirtualBox templates in the previous assignment.

### Packer Init Block

This block is placed to initialize the Proxmox plugin for Packer. From the commandline run the command: `packer init .` -- this is needed only once per user account.

```hcl

locals { timestamp = regex_replace(timestamp(), "[- TZ:]", "") }

packer {
  required_plugins {
    virtualbox = {
      version = "= 1.1.0"
      source  = "github.com/hashicorp/proxmox"
    }
  }
}
```

**Note** If you execute a `packer build .` command and receive a `501` error, it has to do with a bug in the the latest `packer-proxmox-plugin`. You will need to revert to a version before `1.1.1`. You can delete the plugin if you installed `1.1.1` by executing the command: `rm ~/.config/packer/plugins/github.com/hashicorp/proxmox/packer-plugin-proxmox_v1.1*` - the example code was updated 02/20 and the `packer init` block has been locked to `1.1.0`.

### Source Blocks

The next part of the code contains the `source` directive to tell Packer what which virtualization platform to connect to and build for. In this case it will be Proxmox, *proxmox-iso*. We will also give the particalar `source` block a name so to be able to reference it in later `build` and `provisioner` stages.

* [Source Block Documentation](https://www.packer.io/docs/from-1.5/blocks/source "webpage for SOurce Block Documentation")
* [Packer Proxmox example template](https://github.com/burkeazbill/ubuntu-22-04-packer-fusion-workstation/blob/master/ubuntu-2204-daily.pkr.hcl "webpage for example promox template")

```hcl

###############################################################################
# This is a Packer build template for the backend database / datastore
###############################################################################
source "proxmox-iso" "backend-database" {
  boot_command = [
        "e<wait>",
        "<down><down><down>",
        "<end><bs><bs><bs><bs><wait>",
        "autoinstall ds=nocloud-net\\;s=http://{{ .HTTPIP }}:{{ .HTTPPort }}/ ---<wait>",
        "<f10><wait>"
      ]
  boot_wait    = "5s"
  cores        = "${var.NUMBEROFCORES}"
  node         = "${var.NODENAME}"
  username     = "${var.USERNAME}"
  token        = "${var.PROXMOX_TOKEN}"
  cpu_type     = "host"
  disks {
    disk_size         = "${var.DISKSIZE}"
    storage_pool      = "${var.STORAGEPOOL}"
    storage_pool_type = "lvm"
    type              = "virtio"
  }
  http_directory   = "subiquity/http"
  http_port_max    = 9200
  http_port_min    = 9001
  iso_checksum     = "sha256:10f19c5b2b8d6db711582e0e27f5116296c34fe4b313ba45f9b201a5007056cb"
  iso_urls         = ["https://mirrors.edge.kernel.org/ubuntu-releases/22.04.1/ubuntu-22.04.1-live-server-amd64.iso"]
  iso_storage_pool = "local"
  memory           = "${var.MEMORY}"

  network_adapters {
    bridge = "vmbr0"
    model  = "virtio"
  }
  network_adapters {
    bridge = "vmbr1"
    model  = "virtio"
  }
  network_adapters {
    bridge = "vmbr2"
    model  = "virtio"
  }

  os                       = "l26"
  proxmox_url              = "${var.URL}"
  insecure_skip_tls_verify = true
  unmount_iso              = true
  qemu_agent               = true
  cloud_init               = true
  cloud_init_storage_pool  = "local"
  ssh_password             = "vagrant"
  ssh_username             = "${var.backend-SSHPW}"
  ssh_timeout              = "28m"
  template_description     = "A Packer template for backend database"
  vm_name                  = "${var.backend-VMNAME}"
}

###########################################################################################
# This is a Packer build template for the frontend webserver
###########################################################################################
source "proxmox-iso" "frontend-webserver" {
  boot_command = [
        "e<wait>",
        "<down><down><down>",
        "<end><bs><bs><bs><bs><wait>",
        "autoinstall ds=nocloud-net\\;s=http://{{ .HTTPIP }}:{{ .HTTPPort }}/ ---<wait>",
        "<f10><wait>"
      ]
  boot_wait    = "5s"
  cores        = "${var.NUMBEROFCORES}"
  node         = "${var.NODENAME}"
  username     = "${var.USERNAME}"
  token        = "${var.PROXMOX_TOKEN}"
  cpu_type     = "host"
  disks {
    disk_size         = "${var.DISKSIZE}"
    storage_pool      = "${var.STORAGEPOOL}"
    storage_pool_type = "lvm"
    type              = "virtio"
  }
  http_directory   = "subiquity/http"
  http_port_max    = 9200
  http_port_min    = 9001
  iso_checksum     = "sha256:10f19c5b2b8d6db711582e0e27f5116296c34fe4b313ba45f9b201a5007056cb"
  iso_urls         = ["https://mirrors.edge.kernel.org/ubuntu-releases/22.04.1/ubuntu-22.04.1-live-server-amd64.iso"]
  iso_storage_pool = "local"
  memory           = "${var.MEMORY}"

  network_adapters {
    bridge = "vmbr0"
    model  = "virtio"
  }
  network_adapters {
    bridge = "vmbr1"
    model  = "virtio"
  }
  network_adapters {
    bridge = "vmbr2"
    model  = "virtio"
  }

  os                       = "l26"
  proxmox_url              = "${var.URL}"
  insecure_skip_tls_verify = true
  unmount_iso              = true
  qemu_agent               = true
  cloud_init               = true
  cloud_init_storage_pool  = "local"
  ssh_password             = "vagrant"
  ssh_username             = "${var.frontend-SSHPW}"
  ssh_timeout              = "28m"
  template_description     = "A Packer template for a frontend webserver"
  vm_name                  = "${var.frontend-VMNAME}"
}

```

### Build Blocks

The build block is where we tell Packer what to build when the `packer build .` command is executed. Packer has the unique ability to build in parallel, as many templates as you create in the `source` blocks. Each `source` name has to be entered into the `build sources` in order to be built. This built in parallelism means you can generally completely build these two templates on our buildserver in around 12-17 minutes.

```hcl

build {
  sources = ["source.proxmox-iso.frontend-webserver","source.proxmox-iso.backend-database"]

```

### Provisioners

There is an additional type of `provisioner` than just the shell script one demonstrated in the Packer Tooling Assignment.  There is also a [file provisioner](https://developer.hashicorp.com/packer/docs/provisioners/file "webpage for Packer File Provisioner"). A file provisioner is a way to place a file from your local system into a Virtual Machine template. These could be configuration files that are pre-configured, or they could be sensitive security keys. For this round we will use the `file provisioner` but as you might have guessed it, there is a Hashicorp product named [Vault](https://www.hashicorp.com/products/vault "webpage for Vault") that we will dive into the following sprints as we evolve our projects.

I have provided a series of static files that are needed for various operations to take place on the Cloud Platform. 

* `system.hcl` 
  * A file that is needed to register each virtual machine with Consul for Service Discovery / DNS forwarding.
* `node-exporter-consul-service.json` 
  * To allow the `Prometheus` telemetry system to automatically discover newely launched virtual machines
* `node-exporter.service` 
  * A systemd service file - to start the telemetry export at boot

You will find additional scripts needed for dynamically setting up firewalls for all of this internal traffic taking place. We are using [firewalld](https://firewalld.org "webpage for firewalld"). For our setup this material needs to remain here, you won't have to edit any of it, but I leave it here so that you can see what it takes to get a *regular* os into shape to work on a Cloud Native Platform. At the very end you will see some `provisioners` with shell scripts, but with an additional tag, `only            = ["proxmox-iso.proxmox-frontend-webserver"]`.

The `only` tag is how you can create specific shell scripts that should be applied to only certain `images`. For instance you don't want to install a webserver on the backend image, and you don't want an uneeded database on a frontend image.

```hcl
  ########################################################################################################################
  # Using the file provisioner to SCP this file to the instance 
  # Add .hcl configuration file to register an instance with Consul for dynamic DNS on the third interface
  ########################################################################################################################

  provisioner "file" {
    source      = "./system.hcl"
    destination = "/home/vagrant/"
  }

  ########################################################################################################################
  # Copy the node-exporter-consul-service.json file to the instance move this file to /etc/consul.d/ 
  # directory so that each node can register as a service dynamically -- which Prometheus can then 
  # scape and automatically find metrics to collect
  ########################################################################################################################

  provisioner "file" {
    source      = "../scripts/proxmox/jammy-services/node-exporter-consul-service.json"
    destination = "/home/vagrant/"
  }

  ########################################################################################################################
  # Copy the consul.conf file to the instance to update the consul DNS to look on the internal port of 8600 to resolve
  # .consul domain lookups
  ########################################################################################################################

  provisioner "file" {
    source      = "../scripts/proxmox/jammy-services/consul.conf"
    destination = "/home/vagrant/"
  }

  ########################################################################################################################
  # Copy the node_exporter service file to the template so that the instance can publish its own system metrics on the
  # metrics interface
  ########################################################################################################################

  provisioner "file" {
    source      = "../scripts/proxmox/jammy-services/node-exporter.service"
    destination = "/home/vagrant/"
  }

  ########################################################################################################################
  # This is the script that will open firewall ports needed for a node to function on the the School Cloud Platform
  # and create the default firewalld zones.
  ########################################################################################################################

  provisioner "shell" {
    execute_command = "echo 'vagrant' | {{ .Vars }} sudo -E -S sh '{{ .Path }}'"
    scripts         = ["../scripts/proxmox/core-jammy/post_install_prxmx-firewall-configuration.sh"]
  }

  ########################################################################################################################
  # These shell scripts are needed to create the cloud instances and register the instance with Consul DNS
  # Don't edit this
  ########################################################################################################################

  provisioner "shell" {
    execute_command = "echo 'vagrant' | {{ .Vars }} sudo -E -S sh '{{ .Path }}'"
    scripts         = ["../scripts/proxmox/core-jammy/post_install_prxmx_ubuntu_2204.sh",
                       "../scripts/proxmox/core-jammy/post_install_prxmx_start-cloud-init.sh",
                       "../scripts/proxmox/core-jammy/post_install_prxmx_install_hashicorp_consul.sh",
                       "../scripts/proxmox/core-jammy/post_install_prxmx_update_dns_for_consul_service.sh"]
  }

  ########################################################################################################################
  # Script to change the bind_addr in Consul to the dynmaic Go lang call to
  # Interface ens20
  # https://www.consul.io/docs/troubleshoot/common-errors
  ########################################################################################################################
  
  provisioner "shell" {
    execute_command = "echo 'vagrant' | {{ .Vars }} sudo -E -S sh '{{ .Path }}'"
    scripts         = ["../scripts/proxmox/core-jammy/post_install_change_consul_bind_interface.sh"]
  }
  
  ############################################################################################
  # Script to give a dynamic message about the consul DNS upon login
  #
  # https://ownyourbits.com/2017/04/05/customize-your-motd-login-message-in-debian-and-ubuntu/
  #############################################################################################
  
  provisioner "shell" {
    execute_command = "echo 'vagrant' | {{ .Vars }} sudo -E -S sh '{{ .Path }}'"
    scripts         = ["../scripts/proxmox/core-jammy/post_install_update_dynamic_motd_message.sh"]
  }  
  
  ############################################################################################
  # Script to install Prometheus Telemetry support
  #############################################################################################
  
  provisioner "shell" {
    execute_command = "echo 'vagrant' | {{ .Vars }} sudo -E -S sh '{{ .Path }}'"
    scripts         = ["../scripts/proxmox/core-jammy/post_install_prxmx_ubuntu_install-prometheus-node-exporter.sh"]
  } 

  ########################################################################################################################
  # Uncomment this block to add your own custom bash install scripts
  # This block you can add your own shell scripts to customize the image you are creating
  ########################################################################################################################

  provisioner "shell" {
    execute_command = "echo 'vagrant' | {{ .Vars }} sudo -E -S sh '{{ .Path }}'"
    scripts         = ["../scripts/proxmox/frontend/post_install_prxmx_frontend-firewall-open-ports.sh",
                      "../scripts/proxmox/frontend/post_install_prxmx_frontend-webserver.sh"]
    only            = ["proxmox-iso.proxmox-frontend-webserver"]
  }

  provisioner "shell" {
    execute_command = "echo 'vagrant' | {{ .Vars }} sudo -E -S sh '{{ .Path }}'"
    scripts         = ["../scripts/proxmox/backend/post_install_prxmx_backend-firewall-open-ports.sh",
                      "../scripts/proxmox/backend/post_install_prxmx_backend_database.sh"]
    only            = ["proxmox-iso.proxmox-backend-database"]
  }

}

```

Notice under the `scripts` directive I can run many shell scripts. Some like to put everything into a single script, but it might be better to break it into many small scripts so that you can trouble shoot functionality easier. The location of the scripts is arbitrary but I gave it a logical place, `../scripts/proxmox/frontend/...` that way I can reason about where and how scripts are identified, in the end you can change any of this structure or reference it as an example.

### Template for Variables

You will need to rename (using the `mv` command) the file: `template-for-variables.pkr.hcl` to `variables.pkr.hcl` this is the default file that Packer will look for.  This file now contains secret information -- **you do not** want this to be in version control. This could be a legal issue or definately a security liability. Before modifying this file make sure that you have the `variables.pkr.hcl` in your team repo `.gitignore` file. The reason we make the change on the buildserver and not on your local system is due to secrets (tokens).

The first four values are specific and you will receive an email with the exact credentials to enter if you are the IT/Operations person for this sprint.

The values you will enter inside the `default` quotes are the following:

* NODENAME
  * proxmonster3
* TOKEN_ID
  * provided to you via email
* TOKEN_SECRET
  * provided to you via email
* URL
  * https://system41.rice.iit.edu:8006/api2/json

```hcl
variable "NODENAME" {
  type    = string
  default = ""
}

variable "TOKEN_ID" {
  sensitive = true
  type   = string
  default = ""
}

variable "TOKEN_SECRET" {
  sensitive = true
  type   = string
  default = ""
}

variable "URL" {
  type = string
  # https://x.x.x.x:8006/api2/json
  default = ""
  sensitive = true
}
```

The next set of values are only for Virtual Machine Template building -- the amount of memory or CPUs doesn't reflect when the instances are deployed. You can experiement with these values, but I didn't notice a large performance increase when I added more memory or CPU.

The disksize you want to leave low, when deploying virtual machine instances from and image, you can increase the disk size, but not decrease it, so best to start low and increase when deploying with Terraform.

### Instance Variables

These remaining fields will be familiar, while building the images, Packer needs SSH credentials to log into the system and execute all the `provisioners` before it cuts off password based ssh access and goes to key based auth only (which we will have to generate another keypair shortly). These remaining fields allow you to name your template, always a good idea to put your team name in the template name, something like `team-00-fe` (frontend) that lets you know who the VM belongs too as we will be sharing the same server to run all of these. The SSH password is again defaulted to `vagrant` but there instructions to change that password in the `subiquity/http/user-data` file. One can also consider that SSH password auth will be removed upon completion so it might not matter, unless someone has console access, then they can easily log into your system. This is a security decision you will have to make.

```hcl
variable "frontend-VMNAME" {
  type    = string
  default = ""
}

variable "frontend-SSHPW" {
  type    = string
  default = ""
  sensitive = true
}

variable "backend-VMNAME" {
  type    = string
  default = ""
}

variable "backend-SSHPW" {
  type    = string
  default = ""
  sensitive = true
}
```

### Subiquity Cloud-init Modifications

We will also need to modify the `subiquity/http/template-user-data` and rename the file to `user-data`. Then you will have the option of editing line 9 (the user account password). The main item you will need to edit is line 56.

```
authorized-keys:
  - 'ssh-ed25519 '
```

You will once again generate an `ed25519` keypair using the ssh-keygen command. This key will be used to authenticate to your instances when you launch them.  What you will do is place the content of the public generated in to the line with the `ssh-ed25519` stub so it will look something like the below option. Cloud-init will automatically insert this public key--this is how it works in AWS, Azure, and GCP too -- the magic of cloud init. Make sure to maintain the indents and tabs in the `user-data` file as YAML, like Python is space sensitive.

```
authorized-keys:
  - 'ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIE288nVirfucLQIfHXOdEW6xQ2otramp587k6rn9IwBE hajek@newyorkphilharmonic '
```

### Ready to Launch

Now I believe we are ready. You can execute the same three commands we ran for the Packer Tooling Assignment to begin to build the Packer Templates.

* `packer init .`
* `packer validate .`
* `packer build .`

Sit back and watch: you are about to become a cloud-native Ops Engineer.

If succesful, in the [Proxmox GUI Console](https://system41.rice.iit.edu:8006 "webpage for Proxmox GUI console") you will see two virtual machine templates a screen with a paper icon behind it and indicated by the red square. Virtual Machines are indicated by a little computer screen icon in the figure below.

![*Successful Packer Build*](./images/templates.png "image of templates being built")

## Conclusion

This ends part 1, how to build Virtual Machine Templates on out Cloud provider, Proxmox. There will be a separate username and password to authenticate to a GUI to check your progress. The second part will engage with Terraform and how to deploy arbitrary numbers of virtual machines into production.

You can now proceed to the part two, [Virtual Machine Images Deployment tutorial](https://github.com/illinoistech-itm/jhajek/blob/master/itmt-430/IT-Operations-cloud-connect-tutorial/Virtual-Machine-Images-Deployment-turotial-Part-2.md "webpage for Terraform Tutorial") which will show you how to deploy virtual machines from Proxmox templates.

