from pyspark import SparkConf
from pyspark.sql import SparkSession
from pyspark.sql.types import IntegerType
from pyspark.sql.functions import to_date

conf = SparkConf()
conf.set('spark.jars.packages', 'org.apache.hadoop:hadoop-aws:3.2.0')
conf.set('spark.hadoop.fs.s3a.aws.credentials.provider', 'org.apache.hadoop.fs.s3a.AnonymousAWSCredentialsProvider')
 
conf.set('spark.hadoop.fs.s3a.access.key', "spark521")
conf.set('spark.hadoop.fs.s3a.secret.key', "79a93eda-ba02-11ec-8a4c-54ee75516ff6")
conf.set("spark.hadoop.fs.s3a.endpoint", "http://192.168.172.50:9000")

spark = SparkSession.builder.appName("JRH convert 30.txt to csv").config(conf=conf).getOrCreate()
 
df = spark.read.csv('s3a://itmd521/30.txt')

df.withColumn('WeatherStation', df['value'].substr(5, 6)) \
.withColumn('WBAN', df['value'].substr(11, 5)) \
.withColumn('ObservationDate',to_date(df['value'].substr(16,8), 'yyyyMMdd')) \
.withColumn('ObservationHour', df['value'].substr(24, 4).cast(IntegerType())) \
.withColumn('Latitude', df['value'].substr(29, 6).cast('float') / 1000) \
.withColumn('Longitude', df['value'].substr(35, 7).cast('float') / 1000) \
.withColumn('Elevation', df['value'].substr(47, 5).cast(IntegerType())) \
.withColumn('WindDirection', df['value'].substr(61, 3).cast(IntegerType())) \
.withColumn('WDQualityCode', df['value'].substr(64, 1).cast(IntegerType())) \
.withColumn('SkyCeilingHeight', df['value'].substr(71, 5).cast(IntegerType())) \
.withColumn('SCQualityCode', df['value'].substr(76, 1).cast(IntegerType())) \
.withColumn('VisibilityDistance', df['value'].substr(79, 6).cast(IntegerType())) \
.withColumn('VDQualityCode', df['value'].substr(86, 1).cast(IntegerType())) \
.withColumn('AirTemperature', df['value'].substr(88, 5).cast('float') /10) \
.withColumn('ATQualityCode', df['value'].substr(93, 1).cast(IntegerType())) \
.withColumn('DewPoint', df['value'].substr(94, 5).cast('float')) \
.withColumn('DPQualityCode', df['value'].substr(99, 1).cast(IntegerType())) \
.withColumn('AtmosphericPressure', df['value'].substr(100, 5).cast('float')/ 10) \
.withColumn('APQualityCode', df['value'].substr(105, 1).cast(IntegerType())) \
.drop('value').write.format("csv").mode("overwrite").option("header","true").save("s3a://itmd521/30.csv")

df.printSchema()
df.show(5)