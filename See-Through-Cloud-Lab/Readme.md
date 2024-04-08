# See-Through Cloud Lab

A quick introduction and explanation of the See-Through Cloud Lab capabilities and functionality available to you and to students.

## Why “See Through?”

There are various public cloud and enterprise grade virtualization platforms available. These are by nature designed to run securely and reliably and many companies big and small use them with great success. Our lab wants to focus on the internal parts of how these services work – which the Public and the enterprise won’t or can’t give you access to. Hence the name See Through Cloud Lab.  

We are endeavoring to use the 5 basic principals of cloud-native to recreate these features internally and give students the access to use and research on a cloud-computing platform.  

## Location of Lab and Commitment to Secure and Safe Access

Currently located at the Wheaton Rice Campus in the Johanneson Computer Lab. Access to the lab is available via the school VPN and at the moment an email to Jeremy Hajek (hajek@iit.edu) to create accounts and generate API keys. Access is renewed before each semester.

The Cloud Lab has been managed by Professor Jeremy Hajek for over 6 years, in concert with design help from OTS members Fred Eichorst and Adrian Bucarica, and have worked hand-in-hand with OTS Cyber Tech group. We are continually updating and modifying our compute stack as new threats become available. We are making extensive use of the university VPN.

## 5 Basic Components of Cloud Native

1.  All resources only accessed via APIs over HTTP
2.  Elastic Virtual Machine resources  
a.	Linux and x86-based
3.	Elastic Block storage   
a.	Virtual disk
4.	Object Storage 
a.	Immutable Objects storage via HTTP
5.	IAM  
a.	Identity and Access Management, fine grained resource and account control

## What does the lab contain?

There are various components to the See Through Cloud Lab. The main goal of this lab is using the 5 components of cloud native to recreate the basic functionality your would find in the Public Cloud. To give students access to the concepts behind the public cloud and give them code that can be migrated between cloud platforms.

### Cloud Lab Infrastructure Makeup

The lab is made up of several parts...

* Infrastructure Cluster
  * Running Proxmox 8.0 and a 2x Node Cluster
* Student Production Cluster
  * Running Proxmox 8.0 and a 2x Node Cluster

#### Infrastructure Cluster

* 2 Consul servers (Service Discovery)
* 1 DHCP server for 3 internal non-routable networks
  * Metrics Collection Network - `10.0.0.0/16`
  * Meta-Network for application discovery - `10.110.0.0/16`
  * Data-Network - for access to our internal Big Data Cluster - `10.200.0.0`
* 1 Prometheus Server for VM metrics aggregation
* 1 Grafana Server for Graphing and Visualization
* 1 Jenkins CI system for CI building of Android Applications
* OTS provides DHCP services and DHCP leases on an RFC 1918 `192.168.172.0/24` network
* OTS also provides internal DNS mapping for each IP in the `/24` network	

#### Student Production Cluster

This cluster is currently used by students in the capstone ITMT-430 course. The purpose is to provide them a sandbox and a system that represents as close as possible to a modern cloud-computing platform. Students are given VM level admin access so they can inspect all the parts of the platform, even each others systems. They do not have Account level access but otherwise we give them enough access to call this a *see through cloud*. We have a flat network structure by design so that all resources can see everyone others resource on the network--this is by design.

To make this as cloud native as possible we enforce the use of automation tooling for the creation of virtual machine templates and the integration of (on the administrative side) of the setting necessary to connect components of our cloud.  Version control is a **must** and required. This is similar to how modern PaaS platforms like Heroku function.

#### Secure Template

A pre-made secure template is provided to each student which can be used to build basic virtual machines or extended via shell scripts for custom needs. Our secure template also includes needed modification to integrate various cloud services into the stock operating systems.

* Integration with our service discovery (Consul using the Gossip protocol) on the `meta-network` so applications can dynamically discover systems that don't have static IP mappings.
* Use of `systemd-firewalld` to block all firewall ports by default
  * User must open then as needed (AWS has the same behavior)
* Dynamic registration of each VM upon creation with our monitoring and metrics solution
  * Node Exporter, Prometheus, and Grafana
* Force the use of Public/Private key use
  * Never any passwords and all user generated so ITM maintains no keys or secrets
* Use of Vault for secure secrets management over HTTP
* Use of Version control for integration for code and script deployment
* Cloud Lab is very reliable, but comes with a 0% guarantee of uptime or reliability
  * If you are using version control you should be able to restore your entire application
* Disabling of SSH password auth (Keys only)
  * Public keys are inserted by the user
  * A general admin key is also inserted at build time

### The Student Buildserver

This is the single point of access to the Cloud Lab Infrastructure. Each student is given an account on this server, securely using SSH and Public/Private Key infrastructure (never any passwords). From the buildserver account students can clone their GitHub repo and user Packer to build VM templates on the Proxmox VM infrastructure and Terraform to deploy their VMs and applications.  

##### Proxmox

Currently in operation is a two node Proxmox VM Cluster. Proxmox is a German company that produces a management platform (akin to VM Ware ESXi and Hyper-V) on top of Debian Linux using the KVM platform for virtualization.

### Automation Tools

* Hashicorp Packer
  * Used for building VM images and templates
  * Supports all major Virtualization platforms
* Hashicorp Consul
  * Used for dynamic DNS and service discovery to help connect applications
* Hashicorp Terraform
  * Infrastructure automation to provision and manage resources in any cloud or data center
  * Cross cloud and platform
* Hashicorp Vault
  * Secure management of secrets via HTTP
* Linux, SSH, and ed25519 private keys
  * Ubuntu Server and AlmaLinux (but can be extended)
  * All public clouds use this authentication method


## Spark Cluster Big Data and Data Engineering 

For distributed Big Data Calculations.  Currently CPU based not GPU based--though there are many workloads that are still CPU based.

* 8 nodes
* 170 CPU cores
* 600 GB of RAM
* Storage disassociated and done via the Minio Object Storage Cluster
* Students can submit jobs to a queue for deployment
  * Remote access 24/7 secure access available via the school VPN

## Minio Object Storage Cluster

*"[MinIO](https://min.io "website - minio, a high-performance, S3 compatible object store") is a high-performance, S3 compatible object store. It is built for large scale AI/ML, data lake and database workloads. It is software-defined and runs on any cloud or on-premises infrastructure. MinIO is dual-licensed under open source GNU AGPL v3 and a commercial enterprise license."*

In addition to support S3 Object based storage we have an on-prem solution housing 16TB of storage.  Students receive an account that is controlled via an IAM policy that grants them access to their own bucket as well as read-access to certain data source buckets.

This is used to store large amounts of data in custom Big Data Formats, such as Parquet and Arrow.  Currently the ITMD-521 (~100 users) are making use of this working with NOAA historic weather datasets ~1TB of text data.

This system is also used in conjunction with the ITMT-430 Capstone course for application development. Modern applications store artifacts (images, css, video) and serve it via HTTP. This allows students to experience secure and cloud native data-storage for applications. Applications speak HTTP.


