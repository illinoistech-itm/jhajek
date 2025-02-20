# Module 06

## Objectives

- Understand the structure of Spark SQL queries and how to convert them to PySpark DataFrame API calls
- Understand how to make tempViews from Tables
- Understand how to make queries against tempViews
- Understand how to use the Spark Catalog
- Examine the use of the Spark DataFrameReader and Writer to manipulate file data

## Assignment Setup

- We will be using the departure delays files located at:
  - `~/LearningSparkV2/databricks-datasets/learning-spark-v2/flights`
  - See Python sample below for how to structure commandline input of datasources
  - All Code will be created on your local system, pushed to GitHub, and then pulled to your Vagrant Box
  - You will create one Pyspark file named: `module-06.py`
  - You will continue to load data via a commandline argument passing in the path of the file
  - Use [https://pages.databricks.com/rs/094-YMS-629/images/LearningSpark2.0.pdf](https://pages.databricks.com/rs/094-YMS-629/images/LearningSpark2.0.pdf "webpage for Learning Spark V2 book")

**Note:** do not use the notebook file provided, we want to challenge you to be able to build this yourself.

### DataFrameReader

When reading data you can use the generic `spark.read.format` command, but I recommend to use the domain specific functions.

* DataFrameReader - [parquet](https://spark.apache.org/docs/3.2.0/api/python/reference/api/pyspark.sql.DataFrameReader.parquet.html "webpage for pyspark api parquet")
* DataFrameReader - [json](https://spark.apache.org/docs/3.2.0/api/python/reference/api/pyspark.sql.DataFrameReader.json.html "webpage for pyspark api json")

## Assignment Details - Part I

Using the `departuredelays.csv` file, in a single file called `module-06.py` convert the remaining two Spark SQL queries from printed page 87 or page 111 of the PDF into Spark DataFrame APIs.

- Type the remaining Spark SQL examples into your code

## Assignment Details - Part II

- From page 90-92, PDf 115-117, you will create a Table named `us_delay_flights_tbl` from the `departuredelays.csv`
  - Create a `tempView` of all flights with an origin of Chicago (ORD) and a month/day combo of between 03/01 and 03/15
  - Show the first 5 records of the tempView
  - Use the Spark Catalog to list the columns of table `us_delay_flights_tbl`
- **New** Add this line to your `spark-submit` command to overcome the database already exists error
  - `--conf spark.sql.catalogImplementation=hive`
  - Example: `spark-submit --conf spark.sql.catalogImplementation=hive module-06.py ./departuredelays.csv`

## Assignment Details - Part III

Using the file: `learning-spark-v2 > flights > departuredelays.csv`

Read the file into a DataFrame, and apply the appropriate schema (ie first column should be of a Date Type). Using a DataFrameWriter, write the content out:

* As a JSON 
* JSON as lz4
* As a Parquet file

For all files use `mode` as `overwrite` so that I can run your program and your work will overwrite any previous work. Keep the filename the same, `departuredelays`.

## Assignment Details - Part IV

Using the `departuredelays` parquet file you created part III, read the content into a DataFrame, select all records that have `ORD` (Chicago O'Hare as `Origin`) and write the results to a DataFrameWriter named `orddeparturedelays`

* Use a `.show(10)` function to print out the first 10 lines
* Save as type Parquet 

### Deliverable

Create a sub-folder named: `module-06` under the `itmd-521` folder. Place all deliverables there.
Submit to Canvas the URL to the folder in your GitHub repo. I will clone your code and run it to test the functionality. I don't need the datasets as I will have them already.

Submit to Canvas the URL to the folder in your GitHub repo. I will clone your code and run it to test the functionality. I don't need the datasets as I will have them configured in the example-data directory -- path is important.

Due at the **Start of class** February 27th 3:15 PM
