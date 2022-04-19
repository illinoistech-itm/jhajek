# Cluster Setup Work

This document will describe some data engineering steps to set up our datasets

## Tasks

* Using the sample code provided in `example-code`, change line 18 to match your initials
  * This will change the job name on [http://192.168.172.23:8080](http://192.168.172.23:8080 "Spark Cluster Manager")
  * Change the output filename (line 45) to be in a bucket with your hawk ID
* Using the sample code provided in `example-code`, name the file: `ncdc.py`
  * Adjust the code to take a bucket and dataset from the commandline
* Adjust the `minio-s3.py` file to be able to write/save to json and parquet files
  * Also add a compression option for json and csv
* Use the these function to write and output file with only 1 partition
  * [coalesce()](https://spark.apache.org/docs/latest/api/python/reference/api/pyspark.sql.DataFrame.coalesce.html "Spark coalesce documentation")
  * [repartition()](https://spark.apache.org/docs/latest/api/python/reference/api/pyspark.sql.DataFrame.repartition.html?highlight=repartition#pyspark-sql-dataframe-repartition "Spark repartition documentation")
* Use this initial command:
  * `spark-submit --master spark://192.168.172.23:7077 --packages "org.apache.hadoop:hadoop-aws:3.2.2" --driver-memory 2G --executor-memory 4G --executor-cores 2 --total-executor-cores 20 ncdc.py`
  * Adjust `driver-memory`, `executor-memory`, and `executor-cores` and take note of execution time
  * [Really good explanation of Spark Executor memory allocation](https://stackoverflow.com/questions/68249294/in-spark-what-is-the-meaning-of-spark-executor-pyspark-memory-configuration-opti#:~:text=Documentation%20explanation%20is%20given%20as%3A%20The%20amount%20of,an%20executor%20will%20be%20limited%20to%20this%20amount. "Spark memory allocation web page")
