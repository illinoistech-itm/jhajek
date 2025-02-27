# Lab 05

## Objectives

- Integrate SQL databases with PySpark Applications
- Deploy SQL table data to Spark DataFrames
- Demonstrate the ability to use Partitions with DataFrames
- Demonstrating the importing of data to MySQL

## Assignment Setup

- We will be using the dataset provided by MySQL in our Vagrant Box:
  - [https://dev.mysql.com/doc/employee/en/](https://dev.mysql.com/doc/employee/en/ "Webpage for MySQL sample dataset")
  - Using PySpark to write code to interface a DataFrame with a MySQL table
  - All Code will be created on your local system, pushed to GitHub, and then pulled to your Vagrant Box
  - You will create one Pyspark file named: `module-07.py`
 
### DataFrameReader

When reading data you can use the generic `spark.read.format` command, but I recommend to use the domain specific functions.

* DataFrameReader - [parquet](https://spark.apache.org/docs/3.2.0/api/python/reference/api/pyspark.sql.DataFrameReader.parquet.html "webpage for pyspark api parquet")
* DataFrameReader - [json](https://spark.apache.org/docs/3.2.0/api/python/reference/api/pyspark.sql.DataFrameReader.json.html "webpage for pyspark api json")
* DataFrameReader - [JDBC](https://spark.apache.org/docs/latest/api/python/reference/pyspark.sql/api/pyspark.sql.DataFrameReader.jdbc.html "Webpage for pyspark API JDBC")
  * [Data Source Options](https://spark.apache.org/docs/latest/sql-data-sources-jdbc.html#data-source-option "webpage for Pyspark API JDBC dataframe reader data source options")
* Command to retrieve the Connector/J package

```
from pyspark import SparkConf
conf = SparkConf()
conf.set('mysql:mysql-connector-java:8.0.33')

spark = SparkSession.builder.appName("Your App Name").config(conf=conf).getOrCreate()
```

## Assignment Details - Part I

Create a non-root MySQL database user giving your self `CRUD` permissions, along with `CREATE TABLE`. Assign a username of `worker` and password of `cluster`. 

Using the [schema of the sample database](https://dev.mysql.com/doc/employee/en/sakila-structure.html "webpage with MySQL sample database schema") you will create DataFrames for each of the 6 tables 

## Assignment Details - Part II

You will use the concepts of Joins on printed Page 148 and PDF Page 172 to make a Join to get all employee records with salaries. Save that result out to a Parquet file. 

Using PySpark read the created Parquet file and write it back to the MySQL database. Use the recommended guidelines on printed page 130/PDF page 155 for the value of the .numPartitions()` write the PySpark code for writing via JDBC. 

### Deliverable

Create a sub-folder named: `module-07` under the `itmd-521` folder. Place all deliverables there.

Submit to Canvas the URL to the folder in your GitHub repo. I will clone your code and run it to test the functionality. I don't need the datasets as I will have them already.

Submit to Canvas the URL to the folder in your GitHub repo. I will clone your code and run it to test the functionality. I don't need the datasets as I will have them configured in the example-data directory -- path is important.

Due at the **Start of class** March 6th 3:15 PM
