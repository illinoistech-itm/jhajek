# Vagrant and Packer Lab

## Part 1 - Undergraduates

You are to use Packer and the Vanilla templates provided to build 4 Ubuntu 18.04.5 virtual machines.  Upon successful build, add these four boxes to be managed by Vagrant. Name each box accordingly:

* riemanna
* riemannmc
* graphitea
* graphitemc

Deliverable:  Take a screenshot of the output of the command: `vagrant box list` showing the four boxes added to Vagrant and add that screenshot here.  

## Part 2 - Undergradutes

Based on the four virtual machines you built, install these additional pieces of software and run their status commands to show they are installed from each Virtual Machine

* openjdk-8
  * java -version
* fail2ban
 * sudo systemctl status fail2ban
* collectd
  * sudo systemctl status collectd

## Part 1 - Graduates

You are to use Packer and the Vanilla templates provided to build 4 Ubuntu 18.04.5 virtual machines. And build 2 centos 7 systems.  Upon successful build, add these four boxes to be managed by Vagrant. Name each box accordingly:

* riemanna
* riemannb - Centos 7
* riemannmc
* graphitea
* graphiteb - Centos 7
* graphitemc

## part 4 - Graduates

Based on the four virtual machines you built, install these additional pieces of software and run their status commands to show they are installed from each Virtual Machine

* openjdk-8
  * java -version
* fail2ban
 * sudo systemctl status fail2ban
* collectd
  * sudo systemctl status collectd

### Deliverable

Push this markdown file to your private repo, into the class folder (itmo-453 or itmo-553) under the folder week-02, place all required screenshots under the individual item
