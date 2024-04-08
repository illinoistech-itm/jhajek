# See-Through Cloud Lab

A quick introduction and explanation of the See-Through Cloud Lab capabilities and functionality available to you and to students.

## History of the Lab

Originally called, "The Range for Year-round Gurus Studying Technology And Design", the name "See Through Cloud Lab" or "See Through Lab" came about when we found ourselves describing the lab as a safe and secure environment that exposed internal functions so that students could learn about what happens in a Cloud Computing Environment. Much like the see-through models of the human body that lets you see hwo the organs are placed, we wanted to same idea.

## Why “See Through?”

There are various public cloud and enterprise grade virtualization platforms available. These are by nature designed to run securely and reliably and many companies big and small use them with great success. Our lab wants to focus on the internal parts of how these services work – which the Public and the enterprise won’t or can’t give you access to. Hence the name See Through Cloud Lab.  

We are endeavoring to use the 5 basic principals of cloud-native to recreate these features internally and give students the access to use and research on a cloud-computing platform.  

## Location of Lab and Commitment to Secure and Safe Access

Currently located at the Wheaton Rice Campus in the Johanneson Computer Lab.  The cloud was built with technology donations from various companies and alum of the program and that were facilitated by [Professor Phil Matuszak](https://www.iit.edu/directory/people/philip-matuszak "webpage - IIT Phil Matuszak") and Professor Ray Trygstad. Access to the lab is available securely and remotely via the school VPN. No portions of the infrastructure is exposed publicly. Currently an email to Jeremy Hajek (hajek@iit.edu) to discuss capabilities to get individuals and classes onto the platform and generate API keys. Access is granted for a semester and renewed on request.

The Cloud Lab has been managed by Professor Jeremy Hajek for over 6 years, in concert with design help from OTS members Fred Eichorst and Adrian Bucarica, and have worked hand-in-hand with OTS Cyber Tech group. We are continually updating and modifying our compute stack as new threats become available.

## 5 Basic Components of Cloud Native

1.  All resources only accessed via APIs over HTTP  
a. [Jeff Besos API Mandate](https://nordicapis.com/the-bezos-api-mandate-amazons-manifesto-for-externalization/ "webpage for Jeff Besos API menu")
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

#### Secure Templates

A pre-made secure template is provided to each student which can be used to build basic virtual machines or extend virtual machines via shell scripts for custom systems. Our secure template includes the needed modifications for integrating various services with the stock operating systems to make them function in a cloud native way.

* Integration with our service discovery 
  * [Consul](https://consul.io "webpage hashicorp consul.io") using the [Gossip protocol](https://en.wikipedia.org/wiki/Gossip_protocol "webpage wikiarticle for gossip protocol") on the `meta-network` for application service discovery.
  * Its how clouds can find systems with non-static IPS and without static DNS mappings.
* Use of `systemd-firewalld` to block all firewall ports by default
  * User must open then as needed (AWS has the same behavior)
  * Standard to `systemd` which means all linux platforms use the same configuration
* Dynamic registration of each VM upon creation with our monitoring and metrics solution
  * Node Exporter, Prometheus, and Grafana
* Force the use of Public/Private key use
  * Never any passwords and all user generated so ITM maintains no keys or secrets
* Use of Vault for secure secrets management over HTTP
* Use of Version control for integration for code and script deployment
* Cloud Lab is very reliable, but comes with a 0% guarantee of uptime or reliability
  * You are required to use version control
  * Version control, GitHub, should be the source of truth
* Disabling of SSH password auth (Keys only)
  * Public keys are inserted by the user
  * A general admin key is also inserted at build time

### The Student Buildserver

This is the single point of access to the Cloud Lab Infrastructure. Each student is given an account on this server, securely using SSH and Public/Private Key infrastructure (never any passwords). From the buildserver account students can clone their GitHub repo and user Packer to build VM templates on the Proxmox VM infrastructure and Terraform to deploy their VMs and applications.  

### Student GitHub Accounts

As part of the See Through lab, Professor Jeremy Hajek was granted unlimited private GitHub repos per a full organization. I have been creating and distributing repos based off of students HAWKIDs in the `illinoistech-itm` organization for over 6 years. We have distributed over 600 repos that students can use. These are private repos that only the owners or admins of the repos can see and the students, not public. 

Public repos can be created for instructors who want to use it for code sharing, such as `https://github.com/illinoistech-itm/jhajek` and with a simple PowerShell script and a two column excel csv, I can create private repos for students and send out the invites in an automated fashion using the GitHub CLI. Note Powershell is cross platform and this can run on Macs and Linux as well. To create and send invites for a 100 person class took about 15 minutes (GitHub has rate limits).

```Powershell
# Assuming csv data structured like this
# https://stackoverflow.com/questions/2157554/how-to-handle-command-line-arguments-in-powershell
# hawkid,githubid
# jhajek,coolguy744
# lhajek,iwojima45 
# ehajek,whateves1

# script.ps1 -level admin
param (
    [string]$level = "write",
    [string]$repocomment = "Private repo for ITM class work"
 )

# https://learn.microsoft.com/en-us/powershell/module/microsoft.Powershell.utility/import-csv
$Data = Import-Csv -Path "./roster.csv"

foreach ($obj in $Data) {
    # Write the HAWK ID to the console
    Write-Output "Creating repo for $($obj.hawkid)..."
  
    gh repo create https://github.com/illinoistech-itm/$($obj.hawkid) --private --add-readme -d $repocomment -g "Packer"
    Start-Sleep -Seconds 25
    
    Write-Output "Now inviting GitHub ID $($obj.githubid)..."
    gh api --method PUT -H "Accept: application/vnd.github+json" -H "X-GitHub-Api-Version: 2022-11-28" /repos/illinoistech-itm/$($obj.hawkid)/collaborators/$($obj.githubid) -f permission=$level

    Start-Sleep -Seconds 15
}
```

##### Proxmox

Currently in operation are a two-node Proxmox VM Cluster. Proxmox is a German company that produces a management platform (akin to VM Ware ESXi and Hyper-V) on top of Debian Linux using the KVM platform for virtualization. This cluster can be expanded to add capacity and make the cluster able to hold even more resources. Largest deploys see over 230 VMs extent and about 60 active without a dent into resources.


| System FQDN       | CPUs      | Memory      | Disk         |
| ------------------| ----------| ----------- | ------------ |
system41.rice.iit.edu | 24 CPUs | 196 GB RAM | 4 x8TB disks
system42.rice.iit.edu | 24 CPUs | 224 GB RAM | 4 x8TB disks


### Automation Tooling Used

Currently we make use of opensource and source available tooling. The majority of our automation software is from cross-platform industry leader Hashicorp. As of January 2024 their opensource license was change to the BSL license but the software is still available for non-competitive use.

* [Hashicorp Packer](https://packer.io "website for Hashicorp Packer")
  * Used for building VM images and templates
  * Supports all major Virtualization platforms
* [Hashicorp Consul](https://consul.io "website for Hashicorp Consul")
  * Used for dynamic DNS and service discovery to help connect applications
* [Hashicorp Terraform](https://terraform.io "website for Hashicorp Terraform")
  * Infrastructure automation to provision and manage resources in any cloud or data center
  * Cross-cloud and cross-platform
* [Hashicorp Vault](https://vault.io "website for Hashicorp Vault")
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


