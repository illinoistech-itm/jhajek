import sys
from pyspark.sql import SparkSession
from pyspark.sql.types import *
from pyspark.sql.functions import *
from pyspark.sql.functions import expr

if __name__ == "__main__":
    if(len(sys.argv) != 3):
        print("Usage : file error", sys.stderr)
        sys.exit(-1)
    
    spark = (SparkSession
        .builder
        .appName("week-10")
        .getOrCreate())

    tripdelaysFilePath = sys.argv[1]
    airportsnaFilePath = sys.argv[2]

    # Pyspark DataFrameReaders to ingest datafiles from local system to DataFrame"""
    airports = spark.read.format("csv").options(header = "true", sep="\t").load(airportsnaFilePath)
    departureDelays=spark.read.format("csv").option("header","true").load(tripdelaysFilePath)

    # Adding colums delay and distance and canging the datatype to INT
    departureDelays = (departureDelays
        .withColumn("delay", expr("CAST(delay as INT) as delay"))
        .withColumn("distance", expr("CAST(distance as INT) as distance")))
        
    # Create a temporary view    
    departureDelays.createOrReplaceTempView("departureDelays")
    airports.createOrReplaceTempView("airports")
    
    foo = departureDelays.filter(expr("""origin == 'SEA' AND destination == 'SFO' AND date like '01010%' AND delay > 0"""))
    foo.createOrReplaceTempView("foo") 
    
    spark.sql("SELECT * FROM departureDelays LIMIT 10").show()
    spark.sql("SELECT * FROM airports LIMIT 10").show()
    spark.sql("SELECT * FROM foo").show()

    # Unions
    bar = departureDelays.union(foo)
    bar.createOrReplaceTempView("bar")

    bar.filter(expr("""origin == 'SEA' AND destination == 'SFO'
        AND date LIKE '01010%' AND delay > 0""")).show()

    spark.sql("""SELECT * FROM bar WHERE origin ='SEA' AND destination ='SFO' AND date like '01010%' AND delay > 0""").show()

    #Joins
    foo.join(airports, airports.IATA==foo.origin
    ).select("City","State","date","distance","destination").show()
    
    #In SQL (Joins)
    spark.sql("""
    SELECT a.City, a.State, f.date, f.delay, f.distance, f.destination
        FROM foo f
        JOIN airports a
            ON a.IATA = f.origin
    """).show()


    spark.sql(""" 
    DROP TABLE IF EXISTS departureDelaysWindow
    CREATE TABLE departureDelaysWindow AS 
    SELECT origin, destination, SUM(delay) AS totalDelays
    FROM departureDelays
    WHERE origin IN ('SEA', 'SFO', 'JFK')
    AND destination IN ('SEA', 'SFO', 'JFK', 'DEN', 'ORD', 'LAX', 'ATL')
    GROUP BY origin, destination
    SELECT * FROM departureDelaysWindow
    """).show()
