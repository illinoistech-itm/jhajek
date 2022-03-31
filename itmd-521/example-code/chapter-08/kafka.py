from pyspark.sql import SparkSession
from pyspark.sql.functions import *
from pyspark.sql.streaming import *

# Link to dependency to build spaprk-submit with kafka dependecy
# https://spark.apache.org/docs/latest/structured-streaming-kafka-integration.html#deploying
spark =  spark = (SparkSession
        .builder
        .appName("Kafka listener")
        .getOrCreate())

inputDF = (spark.readStream.format("kafka").option("kafka.bootstrap.servers","localhost:9092").option("subscribe","quickstart-events").load())
#  .option("startingOffsets", "earliest")

resultDF = inputDF.selectExpr("CAST(key AS STRING)", "CAST(value AS STRING)")
#checkpointDir =""

#streamingQuery = (counts.writeStream.format("console").outputMode("complete").trigger(processingTime="1 second").start())
#streamingQuery = (inputDF.writeStream.format("kafka").option("path","./").trigger(processingTime="20 seconds").start())

streamingQuery = (resultDF.writeStream.outputMode("append").format("console").trigger(processingTime="1 second").start())

streamingQuery.awaitTermination()