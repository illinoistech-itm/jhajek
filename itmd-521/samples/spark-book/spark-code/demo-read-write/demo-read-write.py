# In Python Page 228 of E-book
from __future__ import print_function

from pyspark.sql import SparkSession
spark = SparkSession.builder.appName("Demo Spark Python Cluster Program").getOrCreate()
 
df = spark.read.format("csv").option("inferSchema","true").option("header","true").load("hdfs://namenode/user/controller/ncdc-parsed-csv/20/part-r-00000")
print(df.show(10))

# https://spark.apache.org/docs/latest/api/python/pyspark.sql.html#pyspark.sql.DataFrame.withColumnRenamed
dfnew = df.withColumnRenamed(' windDirection', 'windDirection')

dfnew.write.format("parquet").mode("overwrite").save("hdfs://namenode/output/jrh/20-show-10.parquet")
