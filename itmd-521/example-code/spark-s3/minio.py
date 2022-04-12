from pyspark import SparkConf
from pyspark.sql import SparkSession
 
conf = SparkConf()
conf.set('spark.jars.packages', 'org.apache.hadoop:hadoop-aws:3.2.0')
conf.set('spark.hadoop.fs.s3a.aws.credentials.provider', 'org.apache.hadoop.fs.s3a.AnonymousAWSCredentialsProvider')
 
conf.set('spark.hadoop.fs.s3a.access.key', "spark521")
conf.set('spark.hadoop.fs.s3a.secret.key', "79a93eda-ba02-11ec-8a4c-54ee75516ff6")
conf.set("spark.hadoop.fs.s3a.endpoint", "http://192.168.172.50:9000")

spark = SparkSession.builder.config(conf=conf).getOrCreate()
 
df = spark.read.csv('s3a://itmd521/40.txt', inferSchema=True)

df.printSchema()

df.show(5)
