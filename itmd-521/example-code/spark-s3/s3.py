from pyspark import SparkConf
from pyspark.sql import SparkSession
 
conf = SparkConf()
conf.set('spark.jars.packages', 'org.apache.hadoop:hadoop-aws:3.2.0')
conf.set('spark.hadoop.fs.s3a.aws.credentials.provider', 'org.apache.hadoop.fs.s3a.AnonymousAWSCredentialsProvider')
 
spark = SparkSession.builder.config(conf=conf).getOrCreate()
 
df = spark.read.csv('s3a://noaa-ghcn-pds/csv/2020.csv', inferSchema=True)

df.printSchema()
