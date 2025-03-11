# Spark Dynamic Allocation

The default form of resource allocation is  static resource allocation i.e resources are assigned when start the session, and removed after your session is stopped/killed. 

Spark has inbuilt method called dynamic allocation which allocates resources based on the actual job and automatically removes the assigned resources once the job is finished. 

Your session will remain active until it was stopped/killed but no resources will be assigned until you run a job. So, even if someone forgets to stop the session without any job running the spark won't assign the resources.

This test will helps us to compare both static and dynamic allocation.

**Before proceeding with this test if you have an existing spark session stop it with `spark.stop()` and restart the kernel.**

Creating a new spark session with dynamic allocation enabled with the below snippet of code.

```python
from pyspark import SparkConf
from pyspark.sql import SparkSession

# Removing hard coded password - using os module & open to import them from creds.txt file

import os
import sys

try:
    creds_file = (open(f"/home/{os.getenv('USER')}/creds.txt", "r")).read().strip().split(",")
    accesskey,secretkey = creds_file[0],creds_file[1]
except:
    print("File not found, you can't access minio")
    accesskey,secretkey = "",""

conf = SparkConf()
conf.set('spark.jars.packages', 'org.apache.hadoop:hadoop-aws:3.2.3')
conf.set('spark.hadoop.fs.s3a.aws.credentials.provider', 'org.apache.hadoop.fs.s3a.SimpleAWSCredentialsProvider')

conf.set('spark.hadoop.fs.s3a.access.key', accesskey)
conf.set('spark.hadoop.fs.s3a.secret.key', secretkey)
# Configure these settings
# https://medium.com/@dineshvarma.guduru/reading-and-writing-data-from-to-minio-using-spark-8371aefa96d2
conf.set("spark.hadoop.fs.s3a.path.style.access", "true")
conf.set("spark.hadoop.fs.s3a.impl", "org.apache.hadoop.fs.s3a.S3AFileSystem")
# https://github.com/minio/training/blob/main/spark/taxi-data-writes.py
# https://spot.io/blog/improve-apache-spark-performance-with-the-s3-magic-committer/
conf.set('spark.hadoop.fs.s3a.committer.magic.enabled','true')
conf.set('spark.hadoop.fs.s3a.committer.name','magic')
# Internal IP for S3 cluster proxy
conf.set("spark.hadoop.fs.s3a.endpoint", "http://system54.rice.iit.edu")
# Send jobs to the Spark Cluster
conf.setMaster("spark://sm.service.consul:7077")
#Set driver and executor memory
conf.set("spark.driver.memory","4g")
conf.set("spark.executor.memory","4g")

conf.set("spark.dynamicAllocation.enabled","true")
conf.set("spark.dynamicAllocation.shuffleTracking.enabled","true")

spark = SparkSession.builder.appName("Your App Name")\
    .config('spark.driver.host','spark-edge.service.consul').config(conf=conf).getOrCreate()

```
The config lines `conf.set("spark.dynamicAllocation.enabled","true")` and `conf.set("spark.dynamicAllocation.shuffleTracking.enabled","true")` will tell the spark to enable dynamic allocation.

**Now repeat test's 1,2,3 and observe how spark is allocating resources for each test.**

***Note: You must stop your session before closing the notebook with `spark.stop()`, if you didn't have any spark jobs running. This helps to free up resources assigned to your job, such that other jobs in the queue can make use of them.***'
'