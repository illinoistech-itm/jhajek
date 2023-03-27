# Vault Integration Tutorial

This tutorial will walk through the installation and configuration of a Hashicorp Vault for Secrets Storage. All data is taken from the [Hashicorp Vault Tutorial](https://developer.hashicorp.com/vault/docs "webpage for hashicorp vault tutorial").

## Outcomes

Walking through this written and demo tutorial you will find how to create a Vault with secrets, creating limited access to those secrets, and finally removing hardcoding any secrets into files

### What is Vault

> *Vault is an identity-based secret and encryption management system.*

> *Secure applications and protect sensitive data. Create and secure access to tokens, passwords, certificates, and encryption keys.*

> *The kv secrets engine is a generic Key-Value store used to store arbitrary secrets within the configured physical storage for Vault. This backend can be run in one of two modes; either it can be configured to store a single value for a key or, versioning can be enabled and a configurable number of versions for each key will be stored.*

### First Steps with Packer

Each team will need to build and deploy their own Vault server. There is a new Packer build template provided in the `three-tier` example code to build a template/image just to host your Vault server. Vault is sperate from the Packer build template used to create frontend, backend, and load-balancers. The Vault server lives outside of the application so that is why we have a second Packer build template.

There is a simple shell provisioner under the `three-tier` > `vault` folder to open a firewall port (8200) on the `meta-network` to listen for credential requests and to install the Vault software. This will allow you to build a vm template that has Vault installed and firewall port opened. There are no settings to configure here, we will be entering all the vault credentials ourselves.

### Second Steps with Terraform

You will find a sample Terraform plan in the `example-code` > `proxmox-cloud-production-templates` > `terraform` `proxmox-jammy-ubuntu-vault` sample code. 
