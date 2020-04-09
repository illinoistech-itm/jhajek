# In Python Page 228 of E-book

from pyspark.sql import SparkSession
spark = SparkSession.builder.appName("Demo Spark Python Cluster Program").master("yarn").getOrCreate()
    
df = spark.read.csv("hdfs://192.168.1.100/user/controller/ncdc-parsed-csv/20/part-r-00000").option("inferSchema","true").option("header","true")
df.show(10)
    