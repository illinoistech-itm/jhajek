# Virtualization Milestone

* Create and configure a parallel Ubuntu Server build template
  * 4 nodes
* Using Provisioner shell scripts create:
  * one Nginx Load-Balancer
  * Three ExpressJs instances that say "Hello World"
    * Clone the ExpressJs Code from your private GitHub Repo
* Create the proper PowerShell/Bash scripts to:
  * Vagrant Add
  * Vagrant Init
  * Vagrant Start
  * Vagrant Stop
* Pre-create and preconfigure each Vagrantfile
  * Using the private network feature assign private (host-only) IPs to each node
  * 192.168.33.100 to Nginx load balancer
  * 192.168.33.101 to node1
  * 192.168.33.102 to node2
  * 192.168.33.103 to node3
