% Spark the Definitive Guide 2nd Edition
% Chapter 09
% Data Sources

# Data Sources

## Text Book

![*itmd-521 textbook*](images/spark-book.png "Spark TextBook")

## Objectives and Outcomes

- Introduce and understand the 6 core data sources available to Spark
- Introduce and understand community-created data sources for Spark (3rd Party)
- Introduce and understand the ability to read and write to these 6 core data sources
- Understand and be able to explain the Read API Structure
- Understand tooling needed to configure Virtual Machines for Remote Cluster access via VPN

## What to do with data - 131

- The goal of this chapter is to give you the ability to read and write from Spark's core data sources
- And to know enough to understand what you should look for in a third party data source
- To achieve this we will focus on the core concepts that you need to be able to recognize and understand

## Six Core Data Sources (1-3)

- [CSV](https://en.wikipedia.org/wiki/Comma-separated_values "CSV Wikipedia Page Link")
  - A comma-separated values (CSV) file is a delimited text file that uses a comma to separate values.
- [JSON](https://www.json.org/json-en.html "JSON.org website")
  - JSON (JavaScript Object Notation) is a lightweight data-interchange format. It is easy for humans to read and write. It is easy for machines to parse and generate. It is based on a subset of the JavaScript Programming Language Standard ECMA-262 3rd Edition - December 1999. JSON is a text format that is completely language independent but uses conventions that are familiar to programmers
- [Parquet](http://parquet.apache.org/documentation/latest/ "Parquet file format description web page")
  - Apache Parquet is a columnar storage format available to any project in the Hadoop ecosystem, regardless of the choice of data processing framework, data model or programming language.
  - [Columnar Storage](http://en.wikipedia.org/wiki/Column-oriented_DBMS "columnar storage")

## Six Core Data Sources Continued (4-6)

- [ORC](https://orc.apache.org/ "Apache ORC project page")
  - The smallest, fastest columnar storage for Hadoop workloads.
- [JDBC/ODBC](https://en.wikipedia.org/wiki/Open_Database_Connectivity "ODBC wikipedia description page")
  - Open Database Connectivity (ODBC) is a standard application programming interface (API) for accessing database management systems (DBMS)
- Plain-Text files
  - Simplest and most universal data format, also the slowest and most inefficient.

## Additional Community Data Sources

- [Cassandra](https://cassandra.apache.org "Cassandra introduction webpage")
  - The Apache Cassandra database is the right choice when you need scalability and high availability without compromising performance. Linear scalability and proven fault-tolerance on commodity hardware or cloud infrastructure make it the perfect platform for mission-critical data. Cassandra's support for replicating across multiple datacenters is best-in-class, providing lower latency for your users and the peace of mind of knowing that you can survive regional outages.
- Google Spreadsheets
  - [spark google spreadsheets](https://spark-packages.org/package/potix2/spark-google-spreadsheets "Package to connect Spark to Google spreadsheets")
- [MongoDB](https://www.mongodb.com/ "MongoDB company website")
  - MongoDB is a general purpose, document-based, distributed database built for modern application developers and for the cloud era.
  - [mongo-spark package](https://spark-packages.org/package/mongodb/mongo-spark "Spark Package for MongoDB")
- [AWS Redshift](https://aws.amazon.com/redshift/ "AWS Redshift description website")
  - AWS Enterprise grade Data Warehouse project
  - [spark-redshift package](https://spark-packages.org/?q=Redshift "Spark Redshift third party package link")

## Read API Structure

- The core structure for reading data is as follows:
  - ```DataFrameReader.format(...).option("key","value").schema(...).load()```
- By default `format` is optional.
- Spark uses the [Apache Parquet](http://parquet.apache.org/ "Apache Parquet columnar data storage format website") format by default.
- The `option` section lets you set key/value pairs to parameterize how you will read data
- The `schema` is optional

## Basics of Reading Data

- The `DataFrameReader` class is the foundation for reading data in Spark
  - We access it via the ```spark.read``` method
  - ```spark.read.format("csv").option("mode", "FAILFAST").option("inferSchema", "true").option("path", "path/to/file(s)").schema(someSchema).load()```{.python}
- So far all of our example data has been perfect in structure
  - This unfortunately is not always the real-world case
- So what does Spark do when it comes across mal-formed data?
  - 3 modes:
    - ```permissive```: sets all fields to *null* and puts corrupted records into a **\_corrupt\_record** field. This is the **default**
    - ```dropMalformed```: drops the row containing malformed records
    - ```failFast```: job fails immediately upon encountering malformed records
  - When might be the ideal time for each of these modes?

## Basics of Writing Data

- The foundations of writing data is similar to reading it
  - Instead of ```DataFrameReader``` we have a ```DataFrameWriter```
  - Where we read values into a DataFrame, we now write them from a DataFrame into an output source: ```dataframe.write```{.python}
  - Write operations specify three values:
    - format
    - a series of options
    - and the save mode

```python
dataframe.write.format("csv")
.option("mode","OVERWRITE")
.option("dateFormat", "yyy-MM-dd")
.option("path", "path/to/file(s)")
.save()
```

## Save Modes

- What if Spark finds data already located at the save location?
  - 4 save modes
    - `Append`
    - `Overwrite`
    - `errorIfExists`
    - `Ignore` - ignore the DataFrame operation
  - The default is `errorIfExists`
  - Why would this be the default?

## CSV

- Stands for comma-separated values
  - Common text file format
  - Each line represents a single record
  - Commas separate each field within a record
- Text/CSV is great to work with as it is a universal interchange format
  - Problem is its unstructured
  - What if there are commas inside of field value?
  - What if there are nulls?  How to you represent them?
- See the challenges?
  - How does/can Spark handle this sort of uncertainty?

## CSV Options

- Refer to the table in the book 9.3 CSV data source options.
  - Page 133/134 in ebook format
  - To begin to read a CSV file: ```spark.read.format("csv")```{.python}
  - We can begin to set options on the CSV read
    - ```.option("header","true")```{.python}
    - ```.option("mode","FAILFAST")```{.python}
    - ```.option("inferSchema","true")```{.python}
    - ```.load("some/path/to/file.csv")```{.python}
- What happens if we try to load a file that doesn't exist?  When/how will the Spark job fail?
- Spark can be used to modify CSV options
  - Read a CSV file in, change the separator, make it a TAB and save the file out as a TSV - 136

## JSON Files

- If you are not familiar with JSON you need to be now
  - This is a text interchange format
    - that uses punctuation
    - key/value pair formats to set up a common way to relate text data elements
    - Like a binary object would, but its in text
    - Making parsing universal
  - Two types of JSON
    - Single line delimited, records stops at the end of the line
    - multi-line which is easier for the human to read, but takes more physical lines/space
    - A single option allows you to inform Spark what you are dealing with
  - There are constraints to think about when writing data
  - As opposed to CSV, JSON gives you assumptions about your data types
    - Text can be compressed for reduced storage and extracted on the fly - Table 9.4

## Parquet Files

- Open Source Apache Foundation based column-oriented data store that provides a variety of storage optimizations
  - Built in column based compression
    - Reduced storage space and column based access
  - Default file type designed to work well with Spark
  - Write data out to Parquet for data storage due to efficiency gains over JSON and CSV
  - Parquet can support complex data types in fields
    - CSV can't
  - Parquet enforces its own schema when storing/writing data, so very few read options
  - Schema built into Parquet, no need to inferSchema
  - ```spark.read.format("parquet").load("2010-summary.parquet").show(5)```{.python}
  - Data can be compressed on write - Table 9.5 Options

## ORC Files

- To understand [ORC](https://orc.apache.org/docs/ "Apache ORC about website") file format we need to understand Apache HIVE
  - The [Apache Hive™](https://cwiki.apache.org/confluence/display/HIVE "Apache HIVE background website") data warehouse software facilitates reading, writing, and managing large datasets
  - Residing in distributed storage and queried using SQL syntax
    - Tools to enable easy access to data via SQL, thus enabling data warehousing tasks such as extract/transform/load (ETL), reporting, and data analysis.
    - A mechanism to impose structure on a variety of data formats
    - HIVE was created by Facebook and later donated to the Apache Foundation
  - ORC was an improvement on HIVE running on top of Hadoop and HDFS
  - Adding features of columnar based access, compression, and optimized for large streaming reads
  - Similar to Parquet in that the schema is built into the file type.

## SQL ODBC/JDBC

- Tons of data is still stored in Databases
  - Whether Relational Databases are meant to be long-term storage achieves is another thing!
  - Most databases can be accessed via an ODBC/JDBC driver to establish a connection in Spark
  - This is good because Spark doesn't have to store a copy the data
  - We will need a proper JAR file to allow the JDBC connectivity
    - Even though our code is in Python, we compile down to bytecode that runs on the JVM
    - Sample application is on Page 143-147

## Unstructured Text Files

- Spark allows you to read in plain-text files
  - Each line in the file becomes a record in the DataFrame
  - Its up to you to transform it accordingly
    - Parse Log files
    - Text for NLP
    - Column delimited files--files without delimiters, but columns defined by size
    - Look on Blackboard at the sample files I provided from NCDC

## Advanced I/O Concepts

- How does a file get written out?
  - You will notice that when we executed write commands we didn't get a single file written out.  Why?
  - It has to do with the parallelism of the files that we write by controlling the *partitions* prior to writing
  - It also has to do with the nature of some file types
    - Some are naturally splitable
    - Splitable files can optimize storage (put small pieces all across a cluster)
  - What about compression?
    - Some compression schemes are splitable, some are not (block vs stream)
- If a large file is a single file, multiple executors cannot read from the same file at the same time
  - But they can read from multiple files in a folder in parallel
  - Each file will be come a *partition* in a DataFrame read by available executors in parallel

## Writing Data in Parallel and Partitioning

- The number of files written is dependent upon the number of *partitions* the DataFrame has at the time you write out the data
  - We specify a "file" but it is actually a number of files
  - Example Code:
  - ```csvFile.repartition.write.format.("csv").save("/multi.csv")```{.python}
  - What is the output? Try it and see.
- **Partitioning** allows you to control what data is stored where
  - When you write to a partitioned directory you can encode a column as a folder
  - What does this gain you?
    - You now can read in only relevant data instead of entire tables, reducing query and search time
    - Supported by all Spark file types
    - Optimize by column save it out as a Parquet file.  What optimization do we gain?  150

## Bucketing

- Partitioning is one of the easiest optimizations
  - Another is Bucketing
- Bucketing is another approach to control the data that is specifically written to each file
  - Like a bucket in reality, Spark bucketing keeps the data you want together to save disk shuffle and retrieval time
  - More efficient than just partitioning
  - See and run example on page 150
  - Only supported on Spark managed tables
- Managing file size
  - The number of output files is a derivative of the number of partitions
  - There is now a ```maxRecoredPerFile``` option where you can define a value for a write operation
  - Allowing you to optimize or standardize

## Conclusion

- We walked through the six core data-sources.
- We walked through the various read and write options for these six datatypes
- We covered reading and writing data in parallel
- We explained partitioning and bucketing in relation to writing data

## Questions

- Any questions?
- For next time, read Chapter 15 & 16 and do any exercises in the book.
