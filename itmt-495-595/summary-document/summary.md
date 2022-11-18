# Fall 2022 Monitoring and Metrics of a Cloud Native Platform

## Description of Project

This project was commenced as a small group study to work with a hands on deployment of Cloud Native Technologies and a focus on deploying a Monitoring and Metrics solution for a Cloud native application. The work was commenced on the ITM department's [Cloud Lab](https://jeremyhajek.com/pages/Cloud-Lab.html "Link to Cloud Lab Specs page") -- which will be further described later in this document.

### Project Goal

Define the project's overall goal

### Project Platform

Briefly define the elements of the project's platform

* [Proxmox](https://proxmox.com "web page for Proxmox Virtualization Platform")
* Ubuntu Server 22.04 and `systemd-resolved`
* Virtual Machines
* Prometheus
* Node Exporter (metrics collection)
* Grafana
* Consul (Service Discovery) and [DNS Forwarding](https://developer.hashicorp.com/consul/tutorials/networking/dns-forwarding#systemd-resolved-setup "web page for Consul DNS Forwarding")

### Tools for Deployment

Briefly describe the tools you used to deploy and develop your infrastructure and code

* VS Code
* Bash
* Packer
* Terraform
* Git and GitHub (Version Control)

### Discuss the Platform's build in Security features

* VM system updates
* RSA ed25519 keys for authentication
* Locked down default VM firewall - using `firewalld`
* Use of secondary non-routable internal network for application communication (ens20 and consul network)
* University VPN
* RFC 1918 VLAN

### Packer Concepts Explanation

* Packer build template
* Shell Scripts used in Packer build templates
* Ubuntu's Subiquity / Cloud-Init
* Proxmox VM Template

### Terraform Concepts Explanation

* What is the functionality of a Proxmox Template
* What is the functionality of a Terraform Plan
* What is the functionality of `terraform apply` and `terraform destroy`

### Deployment Iterations

* Approximately how many times during the semester did you create and destroy instances of virtual machines and virtual machine templates?
* Approximately how long did it take to build a virtual machine template with Packer?
* Approximately how long did it take to deploy a single virtual machine image Terraform?
* Approximately how long did it take to deploy a sample three tier web application using Terraform?

## Summary and Conclusion

Add any concluding thoughts about tools available and improvements that could be made with additional time, funding, or resources.
