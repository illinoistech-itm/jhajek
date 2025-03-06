# JupyterHub Test
All test's and their contents are derived from itmd-521 week-13 cluster assignment.Please proceed with the test's in the given order and **please take screenshots of all the outputs**

### ***Please stop your spark session with `spark.stop()`  after completing the test's.***

### Creating a Spark Session 
Run the below snippet of code in a cell to create a spark session on the spark master with connection to the Minio Bucket.

```
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

spark = SparkSession.builder.appName("Your App Name")\
    .config('spark.driver.host','spark-edge.service.consul').config(conf=conf).getOrCreate()
```
The above code will create a new spark session with the configurations required to connect to S3 bucket. You can add your own configurations as need with `conf.set()`.

This configuration `conf.setMaster("spark://sm.service.consul:7077")` is the one that sends the jobs to the cluster, without this line the spark job will run on local compute.

Since, we are not lauching our session from the user terminal the notebook does not have access to the environment variables present in user's `.bashrc`. So, in order to get around this and not to hard code the passwords, the below block of code is used.

```
try:
    creds_file = (open(f"/home/{os.getenv('USER')}/creds.txt", "r")).read().strip().split(",")
    accesskey,secretkey = creds_file[0],creds_file[1]
except:
    print("File not found, you can't access minio")
    accesskey,secretkey = "",""
```

In the `try` block we are trying to open the `creds.txt` file that's present in the user's home folder and read the contents of it into two varibales `accesskey` and `secretkey` these variables are then used in S3 auth configuration.

Now, you can make use of the `SparkSession` object created in this case `spark`, in the forthcoming cells to run the spark jobs.

Once you create a session spark master will ***treat it as a job and assigns resources***. You need to stop the session as shown below to create a new session or once your job is completed.

```
spark.stop()
```
**It is recommended that you restart the kernel once you stop the session before starting a new session by clicking restart kernel situtated right of stop button (or) from kernel menu, as it clears all the cached variables.**

### ***Note: You must stop your session before closing the notebook with `spark.stop()`, if you didn't have any spark jobs running. This helps to free up resources assigned to your job, such that other jobs in the queue can make use of them!!!!!!!!*** 

## Logs

The default log level is "WARN".If you want more clearer logs as seen in terminal, then after creating the session run the below lines in a new cell.

```
sc = spark.sparkContext
sc.setLogLevel("INFO")
```

## Test 1 - Reading From MinIO

In this Test, you will try to read a file from the minio bucket, do some transformations and display the results. 

### Reading and Displaying Results

Run the below snippet of code in a new cell

```
from pyspark.sql.types import *
from pyspark.sql.functions import *


df = spark.read.csv('s3a://itmd521/50.txt')

splitDF = df.withColumn('WeatherStation', df['_c0'].substr(5, 6)) \
.withColumn('WBAN', df['_c0'].substr(11, 5)) \
.withColumn('ObservationDate',to_date(df['_c0'].substr(16,8), 'yyyyMMdd')) \
.withColumn('ObservationHour', df['_c0'].substr(24, 4).cast(IntegerType())) \
.withColumn('Latitude', df['_c0'].substr(29, 6).cast('float') / 1000) \
.withColumn('Longitude', df['_c0'].substr(35, 7).cast('float') / 1000) \
.withColumn('Elevation', df['_c0'].substr(47, 5).cast(IntegerType())) \
.withColumn('WindDirection', df['_c0'].substr(61, 3).cast(IntegerType())) \
.withColumn('WDQualityCode', df['_c0'].substr(64, 1).cast(IntegerType())) \
.withColumn('SkyCeilingHeight', df['_c0'].substr(71, 5).cast(IntegerType())) \
.withColumn('SCQualityCode', df['_c0'].substr(76, 1).cast(IntegerType())) \
.withColumn('VisibilityDistance', df['_c0'].substr(79, 6).cast(IntegerType())) \
.withColumn('VDQualityCode', df['_c0'].substr(86, 1).cast(IntegerType())) \
.withColumn('AirTemperature', df['_c0'].substr(88, 5).cast('float') /10) \
.withColumn('ATQualityCode', df['_c0'].substr(93, 1).cast(IntegerType())) \
.withColumn('DewPoint', df['_c0'].substr(94, 5).cast('float')) \
.withColumn('DPQualityCode', df['_c0'].substr(99, 1).cast(IntegerType())) \
.withColumn('AtmosphericPressure', df['_c0'].substr(100, 5).cast('float')/ 10) \
.withColumn('APQualityCode', df['_c0'].substr(105, 1).cast(IntegerType())).drop('_c0')

splitDF.printSchema()
splitDF.show()
```
In another cell, run the following code

```
avg_df = splitDF.select(month(col('ObservationDate')).alias('Month'),year(col('ObservationDate')).alias('Year'),col('AirTemperature').alias('Temperature'))\
             .groupBy('Month','Year').agg(avg('Temperature'),stddev('Temperature')).orderBy('Year','Month')

avg_df.show()
```

## Test 2 - Writing to MinIO
    
***Proceed with Test-2 only after running Test-1***

In this test, you will try to write the `splitDF` as a csv file to your minio bucket.

```
splitDF.coalesce(1).write.mode("overwrite").option("header","true").csv("s3a://yourbucketname/hubtest1.csv")
```
## Test 3 - %%Capture (No-Hup)

As, we are not submitting the job's via terminal there is no way to use no hup directly. To get around this issue, we will use `%%capture` magic to capture the output.

Run the below code in a new cell. `%%capture test` has been added in the first line.

***After, running the below cell of code immideatly save the notebook, put your computer to sleep (or) shutdown and come back later when you think your job might be completed.***

```
%%capture test
avg_df = splitDF.select(month(col('ObservationDate')).alias('Month'),year(col('ObservationDate')).alias('Year'),col('AirTemperature').alias('Temperature'))\
             .groupBy('Month','Year').agg(avg('Temperature'),stddev('Temperature')).orderBy('Year','Month')

avg_df.show()
```

Now, open the JupyterHub and your notebook, check your output by calling `test` as shown below.

```
test()
```

## Test 4 - Spark Dynamic Allocation

The default form of resource allocation is  static resource allocation i.e resources are assigned when start the session, and removed after your session is stopped/killed. 

Spark has inbuilt method called dynamic allocation which allocates resources based on the actual job and automatically removes the assigned resources once the job is finished. 

Your session will remain active until it was stopped/killed but no resources will be assigned until you run a job. So, even if someone forgets to stop the session without any job running the spark won't assign the resources.

This test will helps us to compare both static and dynamic allocation.


**Before proceeding with this test if you have an existing spark session stop it with `spark.stop()` and restart the kernel.**

Creating a new spark session with dynamic allocation enabled with the below snippet of code.

```
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

conf.set("spark.dynamicAllocation.enabled","true")
conf.set("spark.dynamicAllocation.shuffleTracking.enabled","true")

spark = SparkSession.builder.appName("Your App Name")\
    .config('spark.driver.host','spark-edge.service.consul').config(conf=conf).getOrCreate()

```
The config lines `conf.set("spark.dynamicAllocation.enabled","true")` and `conf.set("spark.dynamicAllocation.shuffleTracking.enabled","true")` will tell the spark to enable dynamic allocation.

**Now repeat test's 1,2,3 and observe how spark is allocating resources for each test.**


### ***Note: You must stop your session before closing the notebook with `spark.stop()`, if you didn't have any spark jobs running. This helps to free up resources assigned to your job, such that other jobs in the queue can make use of them.***
----------------------------
