#!/bin/bash

# Retreive Spark 3.5.1
wget https://archive.apache.org/dist/spark/spark-3.5.1/spark-3.5.1-bin-hadoop3.tgz

mv ./spark-3.5.1-bin-hadoop3.tgz /home/controller/spark-3.5.1-bin-hadoop3.tgz
sudo chown -R controller:controller /home/controller/spark-3.5.1-bin-hadoop3.tgz

cd /home/controller

tar -xvzf /home/controller/spark-3.5.1-bin-hadoop3.tgz
mv /home/controller/spark-3.5.1-bin-hadoop3 /home/controller/spark


cat << EOF >> /home/controller/.bashrc
export SPARK_HOME=/home/controller/spark
export SPARK_WORKER_DIR=/datapool1/worker-dir
export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/snap/bin:$SPARK_HOME/bin:$SPARK_HOME/sbin
export PYSPARK_PYTHON=python3

EOF