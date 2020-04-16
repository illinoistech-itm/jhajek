# ITMD-521 Assignment - Cluster Read & Write

Using this chart, find the dataset you are to use for this assignment

| ID                  | Year |
|---------------------|------|
| aagrawal4           | 2017 |
| dchilkoti           | 2016 |
| pdash               | 2015 |
| ydole               | 2014 |
| tgaikwad            | 2013 |
| rhadagali           | 2012 |
| siqbal8             | 2011 |
| ikirmani            | 2010 |
| djain14             | 2009 |
| djariwala           | 2008 |
| skairamkonda        | 2007 |
| gkuppusamy          | 2006 |
| smathapatigadagayya | 2005 |
| dpalan              | 2004 |
| upatel24            | 2003 |
| vpatel117           | 2002 |
| tpatil3             | 2001 |
| dpoojari            | 2000 |
| pramni              | 1999 |
| jshah96             | 1998 |
| mshah114            | 1997 |
| asingh135           | 1996 |
| stadepalli          | 1995 |
| ptelure             | 1994 |
| cthakkar1           | 1993 |
| itidke              | 1992 |
| jwang206            | 1991 |

## Schema

The data set we are using makes use of these fields:

* WBAN station identifier
* Observation Date
* Observation Hour
* latitude ( / 1000)
* longitude ( / 1000)
* elevation
* wind direction (degrees )
* wind quality code
* SkyCeiling (your choice if 99999 == nulls)
* SkyCeiling quality code
* Visibility
* Visibility Quality Code
* Air Temperature ( Celsius / 10)
* Air Temp Quality Code
* Dew Point
* Dew Point Quality Code
* Atmospheric pressure
* Atmospheric Quality Code

## Phase I - Data Parsing

This phase requires you to read the data year you were assigned.  Each year is stored as part of a decade, requiring you to use Expr or Select statements to find only the year you were assigned.

In addition, these datasets are large ~100 GB so they will take time to execute.  I recommend to test your logic on the dataset from the 1920's (20) as it is only 50 MB.  Each source text file is contained as raw text, each line is a record, and there are no delimiters.

```0088999999949101950123114005+42550-092400SAO  +026599999V02015859008850609649N012800599-00504-00785999999EQDN01```

The columns listed above are delineated by a default column size, and not all of the information will be needed from each record.

The substrings can be accessed via a method such as with a Dataframe named df2:

```bash
df2.withColumn('Weather Station', df2['value'].substr(5, 6)) \
.withColumn('WBAN', df2['value'].substr(11, 5)) \
.withColumn('Observation Date',to_date(df2['value'].substr(16,8), 'yyyyMMdd')) \
.withColumn('Observation Hour', df2['value'].substr(24, 4).cast(IntegerType())) \
.withColumn('Latitude', df2['value'].substr(29, 6).cast('float') / 1000) \
.withColumn('Longitude', df2['value'].substr(35, 7).cast('float') / 1000) \
.withColumn('Elevation', df2['value'].substr(47, 5).cast(IntegerType())) \
.withColumn('Wind Direction', df2['value'].substr(61, 3).cast(IntegerType())) \
.withColumn('WD Quality Code', df2['value'].substr(64, 1).cast(IntegerType())) \
.withColumn('Sky Ceiling Height', df2['value'].substr(71, 5).cast(IntegerType())) \
.withColumn('SC Quality Code', df2['value'].substr(76, 1).cast(IntegerType())) \
.withColumn('Visibility Distance', df2['value'].substr(79, 6).cast(IntegerType())) \
.withColumn('VD Quality Code', df2['value'].substr(86, 1).cast(IntegerType())) \
.withColumn('Air Temperature', df2['value'].substr(88, 5).cast('float') /10) \
.withColumn('AT Quality Code', df2['value'].substr(93, 1).cast(IntegerType())) \
.withColumn('Dew Point', df2['value'].substr(94, 5).cast('float')) \
.withColumn('DP Quality Code', df2['value'].substr(99, 1).cast(IntegerType())) \
.withColumn('Atmospheric Pressure', df2['value'].substr(100, 5).cast('float')/ 10) \
.withColumn('AP Quality Code', df2['value'].substr(105, 1).cast(IntegerType())) \
.drop('value').show(10)
```

### Deliverable

Your goal is three-fold:

1. Write the code that will read the appropriate source file in the Hadoop Cluster, process the raw data, and write the data out as a csv file and parquet file
1. You will encounter bad data that will break the schema, decide what mode you will choose for READ in dealing with bad records and how you will handle **nulls** if necessary
1. Based on the amount of data, understand how to use partitions (page 222-3), number of executors, memory, and other optimizations, such as compression to run the job in the shortest amount of time.

### Location of Sources

* You can see the sources by issuing this Hadoop command from the remote-cluster CLI over the VPN: ```hadoop fs -ls -h /user/controller/ncdc-orig```
* You will find the text files in the HDFS directory: ```hdfs://namenode/user/controller/ncdc-orig``` for your Spark `.read()`
* You can write the results out to: ```hdfs://namenode/output/itmd-521/yyy/0000```for your Spark `.write()`
  * Where `yyy` are your initials and `0000` is the individual year (place both csv and parquet into one year directory) -- naming the file the year plus file type extension.
* The original source files are of type `text` not to be confused with `textFile` in the book.

To get you started:

```python
df2 = spark.read.text("hdfs://namenode/user/controller/ncdc-orig/20.txt")
```

### Notes

The execution times may be upwards of 2/3 hours, so start early and don't wait.  This also requires that your remote cluster virtual machine is up and running.  Each dataset will be different so the results will not be the same as any other persons results.  

When making decision in your code, **CITE** the page and chapter you found the information on in Python comment.  Do not be tempted to go to the internet initially, as all the answers you will need are in your textbook.  The internet can mislead you or present you with deprecated code and lead you down a wrong path. Use the textbook and the [PySpark documentation to provide everything you need](https://spark.apache.org/docs/latest/api/python/pyspark.sql.html "PySpark documentation page").

Each Spark job you submit, use the name option to put your initials in front of the name so that your job can be identified in the YARN job console. ```--name jrh-your-python-file.py```.  You find this console at [http://192.168.1.100:8088](http://192.168.1.100:8088 "YARN console")

## Submission

In your Private GitHub Repo, under the folder itmd-521, create a folder named: **RW-assignment**.  Using the template provided,create a file named: **Readme.md** and fill in all the required values.

In the repo include the source files named:  yyy-read-write-csv-0000.py and yyy-read-write-parquet-0000.py where yyy are your initials and 0000 is the year.

Good Luck.
