# Tooling Assignment Advanced

## Objectives

* Demonstrate the use of Virtual Machines and discuss how they can extend your PCs capabilities
* Discuss the tools used for x86 based Virtualization and Apple Silicon based Virtualization
* Examine and explain the benefits of adding an abstraction layer on top of Virtualization platforms
* Explain the uses and advantages of the Vagrant platform in relation to virtual machine management

## Outcomes

At the conclusion of this lab you will have investigated using a virtualization platform (x86 VirtualBox and M series Macs with Parallels) and demonstrated the ability to extend your PCs capabilities using a Virtual Machine. You will have implemented a single abstraction layer on top of your virtualization platform. You will have discussed the advantages of using Vagrant and you will have implemented the tool and deployed virtual machine images.

## From your host system

* From the command line (non-admin) execute the command: `vagrant plugin install vagrant-vbguest`
  * This takes care a warning message from Vagrant about not being able to mount VirtualBox shared drives
* Configure Vagrant Box memory to use at least 2 GB

## Inside Vagrant Box Steps

You will need to use the `wget` commandline tool to retrieve installation files for Hadoop and Spark.  You will need to use the `tar` command to extract the tarballs: `tar -xvzf` and the command `sudo apt update` to check for the latest packages and the command: `sudo apt install` to install additional packages like Java and MariaDB. For Alma inux you will need to install additional tools: ```sudo dnf install epel-release vim rsync wget```

* Change hostname of the system to include the course number and your initials
  * Use the command: `sudo hostnamectl set-hostname initials-and-class-number`
* Add these values to your `.bashrc` file located in your Home directory: `/home/vagrant/.bashrc`
  * `export JAVA_HOME=/usr`
  * `export SPARK_HOME=/home/vagrant/spark`
  * `export PYSPARK_PYTHON=python3`
  * `export PATH=$PATH:$SPARK_HOME/bin`
* Install MariaDB server
  * `mariadb-server`
* Install Java 17 OpenJDK
  * `sudo apt update`
  * `sudo apt install openjdk-17-jdk`
* Install R package
  * Ubuntu - use `apt` to install `r-base`
  * AlmaLinux use: `sudo dnf config-manager --set-enabled crb; sudo dnf install R`
* Install Spark 3.5.x (latest 3.5 branch)
  * [https://dlcdn.apache.org/spark/spark-3.5.4/spark-3.5.4-bin-hadoop3.tgz](https://dlcdn.apache.org/spark/spark-3.5.4/spark-3.5.4-bin-hadoop3.tgz "Apache Spark Download Link")
    * `wget https://dlcdn.apache.org/spark/spark-3.5.4/spark-3.5.4-bin-hadoop3.tgz`
    * `tar -xvzf spark-3.5.4-bin-hadoop3.tgz`
    * `mv spark-3.5.4-bin-hadoop3 spark`
  * You will need to have the `git` executable installed

## Summary

Today we learned how to use Vagrant for managing virtual machine artifacts. We learned how to extend our PCs capabilities by enabling us to install additional software.
