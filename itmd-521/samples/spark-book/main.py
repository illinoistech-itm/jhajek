from __future__ import print_function

if __name__ == '__main__':

    from pyspark.sql import SparkSession

    spark = SparkSession.builder \
        .appName("Word Count") \
        .getOrCreate()

    print(spark.range(5000).where("id > 500").selectExpr("sum(id)").collect())