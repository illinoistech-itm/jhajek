import sys

from pyspark.sql import SparkSession

spark = (SparkSession
         .builder
         .appName("PythonMnMCount")
         .getOrCreate())

mnm_file = sys.argv[1]

mnm_df = (spark.read.format("csv").option("header","true").option("inferSchema","true").load(mnm_file))

