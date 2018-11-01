#!/bin/bash

if [ ! -a ./apache-mahout-distribution-0.13.0.tar.gz ]
then
  wget http://apache.claz.org/mahout/0.13.0/apache-mahout-distribution-0.13.0.tar.gz
  tar -xvzf ./apache-mahout-distribution-0.13.0.tar.gz
  mv -v ./apache-mahout-distribution-0.13.0 ./mahout
  rm -v ./apache-mahout-distribution-0.13.0.tar.gz
fi

if [ ! -a ./spark-2.3.2-bin-hadoop2.7.tgz ]
then
  wget http://apache.cs.utah.edu/spark/spark-2.3.2/spark-2.3.2-bin-hadoop2.7.tgz
  tar -xvzf ./spark-2.3.2-bin-hadoop2.7.tgz
  mv -v ./spark-2.3.2-bin-hadoop2.7 spark
  rm -v ./spark-2.3.2-bin-hadoop2.7.tgz
fi

if [ ! -a ./hadoop-2.8.5.tar.gz ]
then
  wget http://mirrors.advancedhosters.com/apache/hadoop/common/hadoop-2.8.5/hadoop-2.8.5.tar.gz
  tar -xvzf ./hadoop-2.8.5.tar.gz
  rm -v ./hadoop-2.8.5.tar.gz
fi  

if [ ! -a pig-0.17.0.tar.gz ]
then
  wget http://apache.claz.org/pig/pig-0.17.0/pig-0.17.0.tar.gz
  tar -xvzf ./pig-0.17.0.tar.gz
  mv -v ./pig-0.17.0 pig
  rm -v ./pig-0.17.0.tar.gz
fi

if [ ! -a sqoop-1.4.7.bin__hadoop-2.6.0.tar.gz ]
then
  wget http://apache.claz.org/sqoop/1.4.7/sqoop-1.4.7.bin__hadoop-2.6.0.tar.gz
  tar -xvzf sqoop-1.4.7.bin__hadoop-2.6.0.tar.gz
  mv -v ./sqoop-1.4.7.bin__hadoop-2.6.0 sqoop
  rm -v ./sqoop-1.4.7.bin__hadoop-2.6.0.tar.gz
fi
