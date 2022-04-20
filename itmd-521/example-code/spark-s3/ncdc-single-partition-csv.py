from pyspark import SparkConf
from pyspark.sql import SparkSession
from pyspark.sql.types import IntegerType
from pyspark.sql.functions import to_date

# Removing hard coded password - using os module to import them
import os
import sys

if __name__ == "__main__":
    if len(sys.argv) != 4:
        print("Usage: ncdc.py <file> <dest> <write format>", file=sys.stderr)
        sys.exit(-1)

    conf = SparkConf()
    conf.set('spark.jars.packages', 'org.apache.hadoop:hadoop-aws:3.2.0')
    conf.set('spark.hadoop.fs.s3a.aws.credentials.provider', 'org.apache.hadoop.fs.s3a.AnonymousAWSCredentialsProvider')
    
    conf.set('spark.hadoop.fs.s3a.access.key', os.getenv('SECRETKEY'))
    conf.set('spark.hadoop.fs.s3a.secret.key', os.getenv('ACCESSKEY'))
    conf.set("spark.hadoop.fs.s3a.endpoint", "http://192.168.172.50:9000")

    decade=sys.argv[1]
    appName="JRH convert " + sys.argv[1] + " to " + sys.argv[3]
    s3src='s3a://itmd521/' + sys.argv[1]
    s3dest='s3a://hajek/' + sys.argv[2]
    writeformat=sys.argv[3]
    spark = SparkSession.builder.appName(appName).config('spark.driver.host','192.168.172.45').config(conf=conf).getOrCreate()

    df = spark.read.csv(s3src)

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
    splitDF.show(5)

    singlePartDF=splitDF.coalesce(1)
    
    singlePartDF.write.format("csv").mode("overwrite").option("header","true").save(s3dest)
    