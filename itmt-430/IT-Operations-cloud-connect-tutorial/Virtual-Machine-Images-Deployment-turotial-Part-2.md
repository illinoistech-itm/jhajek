# Virtual Machine Images Deployment Turotial Part 2

This tutorial assumes you have completed the [IT Operations cloud connect tutorial](https://github.com/illinoistech-itm/jhajek/blob/master/itmt-430/IT-Operations-cloud-connect-tutorial/Readme.md "webpage for IT Operations Cloud Connect Tutorial").

## Overview

At the conclusion of this tutorial, you will have deployed 2 virtual machine instances from your Proxmox image templates using [terraform](https://terraform.io "webpage for terraform").

## Setup

The only setup needed is to copy the private key created in the previous tutorial into the directory where the `main.tf` file is located: `terraform` > `proxmox-jammy-ubuntu-front-back-template` > `main.tf`. This also assumes that you have copied the `terraform` directory from the `jhajek` sample code repo noted in the Packer-Tooling-Assignment.

## Terraform Structure and Nomenclature

Taken from [Terraform About page](https://developer.hashicorp.com/terraform/intro "webpage for Terraform about page"):

### What is Terraform?
Terraform is an infrastructure as code tool that lets you build, change, and version cloud and on-prem resources safely and efficiently.

> HashiCorp Terraform is an infrastructure as code tool that lets you define both cloud and on-prem resources in human-readable configuration files that you can version, reuse, and share. 

> You can then use a consistent workflow to provision and manage all of your infrastructure throughout its lifecycle. Terraform can manage low-level components like compute, storage, and networking resources, as well as high-level components like DNS entries and SaaS features.

### How does Terraform work?

> Terraform creates and manages resources on cloud platforms and other services through their application programming interfaces (APIs). Providers enable Terraform to work with virtually any platform or service with an accessible API.

### Core Terraform Concepts

The core Terraform workflow consists of three stages:

* Write
  * You define resources, which may be across multiple cloud providers and services.
  * For example, you might create a configuration to deploy an application on virtual machines in a Virtual Private Cloud (VPC) network with security groups and a load balancer.
* Plan
  * Terraform creates an execution plan describing the infrastructure it will create, update, or destroy based on the existing infrastructure and your configuration.
* Apply
  * On approval, Terraform performs the proposed operations in the correct order, respecting any resource dependencies. 
  * For example, if you update the properties of a VPC and change the number of virtual machines in that VPC, Terraform will recreate the VPC before scaling the virtual machines.

You can see our example here: [Terraform Plan](https://github.com/illinoistech-itm/jhajek/blob/master/itmt-430/example-code/proxmox-cloud-production-templates/terraform/proxmox-jammy-ubuntu-front-back-template/main.tf "webpage for Terraform plan").

## Terraform Example

Now let us take a look at the structure of our example Terraform plans.  The plan is setup to create X number of virtual machine instances. The programing and structure will remind you of Packer. In fact, Hashicorp has intentionally made them vastly similar.

There are four files to consider:

* `main.tf`
  * This is the main plan file -- similar in function to a Packer build template *.pkr.hcl
* `provider.tf`
  * This is similar to the `init block` in the packer build template, that tells Terraform which version and any provider plugins to download
  * In this case we will be downloading the Proxmox Provider in addition to the a random number generator plugin
* `template-terraform.tfvars`
  * This file is where you will place secrets and variables to customize configuration. The file will need to be renamed from `template-terraform.tfvars` to `terraform.tfvars` on the buildserver
  * `terraform.tfvars` is part of the .gitignore, so as not to pass secrets via version control.
  * You will enter the Cloud Credentials the IT/Ops person received here
* `variables.tf`
  * Every varialbe that exists in the terraform.tfvars file needs to exist here, this file is for assigning default values and allowing for a commandline runtime override of variables set in `terraform.tfvars`

### Main.tf Structure

Let us take a look at our Terraform Plan - main.tf.  You will notice many of the same constraints as a Packer build template and that is on purpose as Hashicorp wanted to unify their platforms syntax. [Terraform Plan](https://github.com/illinoistech-itm/jhajek/blob/master/itmt-430/example-code/proxmox-cloud-production-templates/terraform/proxmox-jammy-ubuntu-front-back-template/main.tf "webpage for Terraform plan").

The first section is initialization of some plugins and variables. Terraform allows for variables (almost like a programming language) but doesn't quite have full looping support. Terraform, like Packer provides run-time variable declaration as well.  You will see the `${var}` spread throughout the Terraform plan.

In this case we are generating a random_id of 8 bytes that will be used to assign a unique id to each virtual machine instance when it launches and registers itself with the [Consul](https://www.consul.io "webpage for consul service discovery") DNS service. The second variable is a provided array of values and Terraform will randomly select a hard disk name. This will be the underlying disk where your virtual machines are stored on the Proxmox server. Of course this level of detail is never exposed in AWS or Azure, but part of this cloud is to show you the insides so here I am exposing what happens under the hood and how I spread virtual machines out so disks don't fill up.

```hcl

###############################################################################################
# This template demonstrates a Terraform plan to deploy one Ubuntu Focal 20.04 instance.
# Run this by typing: terraform apply -parallelism=1
###############################################################################################
resource "random_id" "id" {
  byte_length = 8
}

# https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/shuffle#example-usage
resource "random_shuffle" "datadisk" {
  input        = ["datadisk2", "datadisk3", "datadisk4", "datadisk5"]
  result_count = 1
}

```

### Terraform Resource Blocks

Packer has source blocks, and [Terraform has Resource blocks](https://developer.hashicorp.com/terraform/language/resources/syntax "webpage for the resource block descriptions"). *"Resources are the most important element in the Terraform language. Each resource block describes one or more infrastructure objects, such as virtual networks, compute instances, or higher-level components such as DNS records."*

We are using the third party [Proxmox Terrform Provider](https://registry.terraform.io/providers/Telmate/proxmox/latest/docs/resources/vm_qemu "webpage for terraform proxmox provider") to interface Terraform and Proxmox. This plan will be how you create arbitrary numbers of Virtual Machines from single Virtual Machines images (or templates in the Proxmox terms). 

```hcl

###############################################################################
# Terraform Plan for frontend webserver instances
###############################################################################

resource "proxmox_vm_qemu" "frontend-webserver" {
  count       = var.frontend-numberofvms
  name        = "${var.frontend-yourinitials}-vm${count.index}.service.consul"
  desc        = var.frontend-desc
  target_node = var.target_node
  clone       = var.frontend-template_to_clone
  os_type     = "cloud-init"
  memory      = var.frontend-memory
  cores       = var.frontend-cores
  sockets     = var.frontend-sockets
  scsihw      = "virtio-scsi-pci"
  bootdisk    = "virtio0"
  boot        = "cdn"
  agent       = 1

  ipconfig0 = "ip=dhcp"
  ipconfig1 = "ip=dhcp"
  ipconfig2 = "ip=dhcp"

  network {
    model  = "virtio"
    bridge = "vmbr0"
  }

  network {
    model  = "virtio"
    bridge = "vmbr1"
  }

  network {
    model  = "virtio"
    bridge = "vmbr2"
  }

  disk {
    type    = "virtio"
    storage = random_shuffle.datadisk.result[0]
    size    = var.frontend-disk_size
  }
```

### Terraform Plan Provisioner

Just like Packer, there is a concept of a provisioner to make launch time customizations that couldn't be made during the template building. We want each virtual machine to be registered with the Consul DNS service and learn all the IPs of our other instances, but only at the time we are launching our virtual machines instances. The only difference here is that you can either run a `shell` provisioner or run the `remote-exec` not a combination like in Packer. So below you see all of the run-time customizations needed to provision and make the last changes to our cloud instance. You won't need to edit any of these and can add on to this list without impacting anything.

```hcl

  provisioner "remote-exec" {
    # This inline provisioner is needed to accomplish the final fit and finish of your deployed
    # instance and condigure the system to register the FQDN with the Consul DNS system
    inline = [
      "sudo hostnamectl set-hostname ${var.frontend-yourinitials}-vm${count.index}",
      "sudo sed -i 's/changeme/${random_id.id.dec}${count.index}/' /etc/consul.d/system.hcl",
      "sudo sed -i 's/replace-name/${var.frontend-yourinitials}-vm${count.index}/' /etc/consul.d/system.hcl",
      "sudo sed -i 's/ubuntu-server/${var.frontend-yourinitials}-vm${count.index}/' /etc/hosts",
      "sudo sed -i 's/FQDN/${var.frontend-yourinitials}-vm${count.index}.service.consul/' /etc/update-motd.d/999-consul-dns-message",
      "sudo sed -i 's/#datacenter = \"my-dc-1\"/datacenter = \"rice-dc-1\"/' /etc/consul.d/consul.hcl",
      "echo 'retry_join = [\"${var.consulip}\"]' | sudo tee -a /etc/consul.d/consul.hcl",
      "sudo systemctl daemon-reload",
      "sudo systemctl restart consul.service",
      "sudo rm /opt/consul/node-id",
      "sudo systemctl restart consul.service",
      "sudo sed -i 's/0.0.0.0/${var.frontend-yourinitials}-vm${count.index}.service.consul/' /etc/systemd/system/node-exporter.service",
      "sudo systemctl daemon-reload",
      "sudo systemctl enable node-exporter.service",
      "sudo systemctl start node-exporter.service",
      "echo 'Your FQDN is: ' ; dig +answer -x ${self.default_ipv4_address} +short"
    ]

    connection {
      type        = "ssh"
      user        = "vagrant"
      private_key = file("${path.module}/${var.keypath}")
      host        = self.ssh_host
      port        = self.ssh_port
    }
  }
}

output "proxmox_frontend_ip_address_default" {
  description = "Current Pulbic IP"
  value       = proxmox_vm_qemu.frontend-webserver.*.default_ipv4_address
}

```
### Provider.tf


