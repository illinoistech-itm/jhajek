# ITMD-521 IT-D 872 Chapter-11 Lab

You will copy this template file to your own private GitHub repo provided.  Under your itmd-521 folder you will create a sub-folder named: **labs**.  Under that folder create a sub-folder named: **chapter-11**.  In that folder place this Readme.md

## Objectives

- Demonstrate Spark native distributed SQL commands
- Demonstrate loading and transforming of data
- Demonstrate saving and writing of results to hdfs

## Your name goes here

### Lab

You will write one Spark application, in Java or Python that will work with the sample NCDC data provided 

- The application will include these steps, place a screenshot of the output under each item.  
- Include a single source code file and instructions in an **install.md** file.
- For the `SparkSession.builder.appName` use:
  - `HAWKID - lab chapter 11`
- A-K use 70-80/70-80.txt L-Z last name use 80-90/80-90.txt for your source file

## Schema and Partial Sample

```python
# This is a partial example to show you the schema of the NCDC dataset
# Though this is a partial Python example you can use Java as well -- your choice
# A-K use 70-80/70-80.txt L-Z lastname use 80-90/80-90.txt

df2 = spark.read.text("hdfs://namenode/user/controller/ncdc/raw/20/20.txt")

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
.drop('value')
```

### Part I

- Parse the **entire** initially assigned text file
  - Load from original source txt (70-80 or 80-90)
  - Reuse Schema created in last assignment
  - Create a dataframe that will:
    - Calculate and display: The AVG air temperature per month per year
    - Calculate and display: Min and Max air temperature per-month per-year
    - Group by WeatherStation and sort by Longitude (Ascending)
    - Create any additional columns needed to satisfy these requirement and drop all uneeded columns
    - You can use the date_format function to retrieve any part of the date
      - [https://spark.apache.org/docs/3.0.2/api/python/pyspark.sql.html#pyspark.sql.functions.date_format](Retrieve Date portions without splitting strings using: `date_format`)
  - Write the dataframe back to hdfs as a csv (with no headers) and a parquet file to the location: `.save("hdfs://namenode/user/controller/output/your-hawk-id-here/00/save-file-name")`  (00 is whichever dataset you were assigned to)
  - Drop uneeded columns and create new columns as needed
  - Make use of official documentation and chapter 11 -- using the spark native SQL commands (though you can write this in SQL in your head, Don't embed any SQL. Directly translate it to native commands, example: df.select("WeatherStation")
    - Note that filter() is an alias for where()  
    - [https://spark.apache.org/docs/3.0.2/api/python/pyspark.sql.html#pyspark.sql.DataFrame.filter](https://spark.apache.org/docs/3.0.2/api/python/pyspark.sql.html#pyspark.sql.DataFrame.filter "pyspark documentation for SQL")
  - Place Screenshot of the output of the command: `.show(15)` of your constructed dataframe

### Part II

- Using the initial dataframe already created from the raw text source in part one:
  - Create an additional dataframe that will:
    - Calculate and display: Showing AVG temperature per month per year and calculate the standard deviation of the 20 years of averages
    - Group by WeatherStation and sort by Longitude (Ascending)
    - Create any additional columns needed to satisfy these requirement and drop all uneeded columns
    - You can use the date_format function to retrieve any part of the date
      - [https://spark.apache.org/docs/3.0.2/api/python/pyspark.sql.html#pyspark.sql.functions.date_format](Retrieve Date portions without splitting strings using: `date_format`)
  - Write the dataframe back to hdfs as a csv (with no headers) and a parquet file to the location: `.save("hdfs://namenode/user/controller/output/your-hawk-id-here/00/save-file-action")`  (00 is whichever dataset you were assigned to)
  - Drop uneeded columns and create new columns as needed
  - Make use of official documentation and chapter 11 -- using the spark native SQL commands (though you can write this in SQL in your head, Don't embed any SQL. Directly translate it to native commands, example: df.select("WeatherStation")
    - Note that filter() is an alias for where()  
  - Place Screenshot of the output of the command: `.show(15)` of your constructed dataframe

### Notes

Official Documentation:

- [https://spark.apache.org/docs/3.0.2/api/python/pyspark.sql.html](https://spark.apache.org/docs/3.0.2/api/python/pyspark.sql.html "pyspark SQL official documentation)
- [https://spark.apache.org/docs/3.0.2/api/java/index.html](https://spark.apache.org/docs/3.0.2/api/java/index.html "spark java official documentation")
  - Look at `org.apache.spark.sql`
    - functions
    - Columns
- You should submit one spark code file, but for testing you can test each portion as a separate piece of code--no need to rerun a long standing job if the first part already works

### Building Instructions

Place and instructions or assumptions needed to run your code in the `install.md` file. When running your jobs, you can background the jobs using the following syntax:

```bash
# Run the jobs with these parameters
nohup spark-submit --master spark://namenode:7077 --driver-cores 1 --total-executor-cores 4 --num-executors 4  --driver-memory 4g --executor-memory 4g demo-read-write-json-compression-lz4.py &
```

### Deliverable

In your private repo push the Java or Python code you have written, any jars, the Readme.md and install.md document to the directory under your private GitHub repo: itmd-521 > labs > chapter-11.  

Submit the URL to this page to Blackboard as your deliverable.
