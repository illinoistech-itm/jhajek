from pyspark import SparkConf
from pyspark.sql import SparkSession
 
conf = SparkConf()
conf.set('spark.jars.packages', 'org.apache.hadoop:hadoop-aws:3.2.0')
conf.set('spark.hadoop.fs.s3a.aws.credentials.provider', 'org.apache.hadoop.fs.s3a.AnonymousAWSCredentialsProvider')
 
conf.set('spark.hadoop.fs.s3a.access.key', "spark521")
conf.set('spark.hadoop.fs.s3a.secret.key', "79a93eda-ba02-11ec-8a4c-54ee75516ff6")

spark = SparkSession.builder.config(conf=conf).getOrCreate()
 
df = spark.read.csv('s3a://192.168.172.50:9000/itmd521/sf-fire-calls.csv', inferSchema=True)

df.printSchema()
