import sys

from pyspark.sql import SparkSession

spark = (SparkSession
         .builder
         .appName("PythonMnMCount")
         .getOrCreate())

mnm_file = sys.argv[1]

mnm_df = (spark.read.format("csv").option("header","true").option("inferSchema","true").load(mnm_file))

count_mnm_df = (mnm_df
                .select("State","Color","Count")
                .groupBy("State","Color")
                .sum("Count")
                .orderBy("sum(Count)", ascending=False))

count_mnm_df.show(n=10, truncated=False)

spark.stop()
