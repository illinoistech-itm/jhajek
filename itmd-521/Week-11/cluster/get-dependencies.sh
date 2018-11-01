#!/bin/bash

##################################################
# Add User customizations below here
##################################################

cat << EOT >> /home/controller/.bashrc 

########## Inserted by Professor Jeremy
export JAVA_HOME=/usr
export HADOOP_HOME=/home/controller/hadoop-2.8.5
export SPARK_HOME=/home/controller/spark
export PIG_HOME=/home/controller/pig
export MAHOUT_HOME=/home/controller/mahout
export SQOOP_HOME=/home/controller/sqoop
export PATH=$PATH:$HADOOP_HOME/bin:$HADOOP_HOME/sbin:$SPARK_HOME/bin:$PIG_HOME/bin:$MAHOUT_HOME/bin:/usr/local/bin
export HADOOP_CLASSPATH=/usr/lib/jvm/java-8-openjdk-amd64/lib/tools.jar:$SQOOP_HOME/sqoop-1.4.7.jar:/home/controller/mysql-connector-java-5.1.44/mysql-connector-java-5.1.44-bin.jar
export HADOOP_USER_CLASSPATH_FIRST=true
export HADOOP_CONF_DIR=$HADOOP_HOME/etc/hadoop
EOT

# http://askubuntu.com/questions/493460/how-to-install-add-apt-repository-using-the-terminal
sudo apt-get update ; sudo apt-get install -y software-properties-common openjdk-8-jdk

sudo apt-get -y install pkgconf wget liblzo2-dev sysstat iotop vim libssl-dev libsnappy-dev libsnappy-java libbz2-dev libgcrypt11-dev zlib1g-dev lzop htop fail2ban
