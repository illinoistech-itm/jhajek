# In Python Page 228 of E-book
from __future__ import print_function

from pyspark.sql import SparkSession
from pyspark.sql.types import IntegerType
from pyspark.sql.functions import to_date

spark = SparkSession.builder.appName("Demo Spark Python Cluster Program").getOrCreate()
 
df2 = spark.read.text("hdfs://namenode/user/controller/ncdc/raw/00/00.txt")

df2.withColumn('WeatherStation', df2['value'].substr(5, 6)) \
.withColumn('WBAN', df2['value'].substr(11, 5)) \
.withColumn('ObservationDate',to_date(df2['value'].substr(16,8), 'yyyyMMdd')) \
.withColumn('ObservationHour', df2['value'].substr(24, 4).cast(IntegerType())) \
.withColumn('Latitude', df2['value'].substr(29, 6).cast('float') / 1000) \
.withColumn('Longitude', df2['value'].substr(35, 7).cast('float') / 1000) \
.withColumn('Elevation', df2['value'].substr(47, 5).cast(IntegerType())) \
.withColumn('WindDirection', df2['value'].substr(61, 3).cast(IntegerType())) \
.withColumn('WDQualityCode', df2['value'].substr(64, 1).cast(IntegerType())) \
.withColumn('SkyCeilingHeight', df2['value'].substr(71, 5).cast(IntegerType())) \
.withColumn('SCQualityCode', df2['value'].substr(76, 1).cast(IntegerType())) \
.withColumn('VisibilityDistance', df2['value'].substr(79, 6).cast(IntegerType())) \
.withColumn('VDQualityCode', df2['value'].substr(86, 1).cast(IntegerType())) \
.withColumn('AirTemperature', df2['value'].substr(88, 5).cast('float') /10) \
.withColumn('ATQualityCode', df2['value'].substr(93, 1).cast(IntegerType())) \
.withColumn('DewPoint', df2['value'].substr(94, 5).cast('float')) \
.withColumn('DPQualityCode', df2['value'].substr(99, 1).cast(IntegerType())) \
.withColumn('AtmosphericPressure', df2['value'].substr(100, 5).cast('float')/ 10) \
.withColumn('APQualityCode', df2['value'].substr(105, 1).cast(IntegerType())) \
.drop('value').write.format("csv").mode("overwrite").option("header","true").save("hdfs://namenode/user/controller/output/jrh/csv/00/")
