# In Python Page 228 of E-book
from __future__ import print_function

from pyspark.sql import SparkSession
spark = SparkSession.builder.appName("Demo Spark Python Cluster Program").getOrCreate()
 
df = spark.read.format("csv").option("inferSchema","true").option("header","true").load("hdfs://192.168.1.100/user/controller/ncdc-parsed-csv/20/part-r-00000")
#df = spark.read.csv("hdfs://192.168.1.100/user/controller/ncdc-parsed-csv/20/part-r-00000").option("inferSchema","true").option("header","true")
print(df.show(10))
    