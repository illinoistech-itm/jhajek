# Tutorial to Connect to the Department Cloud Platform

This tutorial will demonstrate how to use class build-server, provided API keys, and the Department Cloud Platform, running on [Proxmox](https://proxmox.com/en/ "webpage for Proxmox Virtualization Platform"), using [Hashicorp Packer](https://packer.io "webapge for Packer.io") and [Terraform](https://terraform.io "webpage for Terraform").

## Setup

This tutorial is specifically for the IT/Operations person in your group for Sprint-02, but eventually everyone will be able to do this starting Sprint-03.

You will need:

* 
* To have submitted your Public Key via blackboard and established a remote connection to the buildserver, which is `system44.rice.iit.edu`
* If off campus established school VPN access
* On the buildserver you will need to generate another keypair via the `ssh-keygen` command
  * This will be used by you (not shared) for cloning your team repo in your account on the buildserver (you could also clone your own repo as well if desired)
  * You will have to also generate a `config` file, as we did for our local systems when initally cloning our GitHub repos
  * You will need to have your team repo cloned to your local system, you won't be working on the buildserver, only deploying from it.
  * Each team member will want to duplicate these steps in their own buildserver account
  * You will need to add the content of the Public Key for this new keypair you generated on the server to your team-repo GitHub account for authentication
  * Test this connection via the command: `ssh git@github.com`, if all is ok, then proceed to clone the team repo
