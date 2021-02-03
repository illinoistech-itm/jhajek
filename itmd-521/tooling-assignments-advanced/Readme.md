# Tolling Assignment Advanced

## Objectives and Outcomes

* Understand how to add custom virtual machines to the Vagrant platform
* Understand the advantages of using Vagrant and Packer
* Configure specific software needed to use Big Data tooling platform, Spark, Hadoop, and MariaDB in virtual machines

## Packer and Vagrant Build Steps

* From the commandline, ```cd``` into the build directory of the packer-vagrant-build-scripts repo you cloned.
  * ```packer-vagrant-build-scripts\packer\build```
* Find the build artifact, there should be one *.box file, similar to ```ubuntu-vanilla-18045-server-virtualbox-1580565828.box```
  * Your number will be different as it is a timestamp
* Add this box to Vagrant
  * Initialize and connect to this virtual machine.

## From your host system

* From the command line (non-admin) execute the command: `vagrant plugin install vagrant-vbguest`
  * This takes care a warning message from Vagrant about not being able to mount VirtualBox shared drives
* Configure Vagrant Box memory to use at least 2 GB

## Inside Vagrant Box Steps

* Change hostname of the system to include the course number and your initials
* Configure `.bashrc` for PATH variables
  * Add: `export JAVA_HOME=/usr`
  * Add: `export HADOOP_HOME=/home/vagrant/hadoop-2.10.1`
  * Add: `export SPARK_HOME=/home/vagrant/spark`
  * Add: ```export HADOOP_CLASSPATH=/usr/lib/jvm/java-8-openjdk-amd64/lib/tools.jar```
  * Add: `export PATH=$PATH:/$HADOOP_HOME/bin:$HADOOP_HOME/sbin:$SPARK_HOME/bin`
* Install MariaDB server
* Install java 8 OpenJDK
  * `sudo apt-get update`
  * `sudo apt-get install openjdk-8-jdk`
* Install R package
  * [https://www.digitalocean.com/community/tutorials/how-to-install-r-on-ubuntu-18-04](https://www.digitalocean.com/community/tutorials/how-to-install-r-on-ubuntu-18-04 "Install R package in Ubuntu")
* Install Spark 3.x
  * [https://www.apache.org/dyn/closer.lua/spark/spark-3.0.1/spark-3.0.1-bin-hadoop2.7.tgz](https://www.apache.org/dyn/closer.lua/spark/spark-3.0.1/spark-3.0.1-bin-hadoop2.7.tgz "Apache Spark Download Link")
  * `wget https://www.apache.org/dyn/closer.lua/spark/spark-3.0.1/spark-3.0.1-bin-hadoop2.7.tgz`
* Install Hadoop 2.10.1
  * [https://apache.claz.org/hadoop/common/hadoop-2.10.1/hadoop-2.10.1.tar.gz](https://apache.claz.org/hadoop/common/hadoop-2.10.1/hadoop-2.10.1.tar.gz "Apache Hadoop Download Link")
  * `wget https://apache.claz.org/hadoop/common/hadoop-2.10.1/hadoop-2.10.1.tar.gz`
* Display memory allocated to VagrantBox
  * ```free --giga```
* Clone your private repository inside of the VirtualBox
  * Display cloned directory with the `ls` command

## Deliverable

* In the document: tooling-assignment-advanced-template.md provide the required screenshots.  Submit the URL to your deliverable to Blackboard
  