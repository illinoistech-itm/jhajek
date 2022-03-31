from pyspark.sql import SparkSession
from pyspark.sql.functions import *
from pyspark.sql.streaming import *

spark =  spark = (SparkSession
        .builder
        .appName("SocketListener")
        .getOrCreate())

lines = (spark.readStream.format("socket").option("host", "192.168.33.100").option("port",3000).load())

words = lines.select(split(col("value"),"\\s").alias("word"))
counts = words.groupBy("word").count()
#checkpointDir =""

streamingQuery = (counts.writeStream.format("console").outputMode("complete").trigger(processingTime="1 second").start())

streamingQuery.awaitTermination()