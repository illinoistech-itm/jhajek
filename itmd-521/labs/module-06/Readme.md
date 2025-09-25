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

**Note:** do not use the notebook file provided, we want to challenge you to be able to build this yourself.

### DataFrameReader

When reading data you can use the generic `spark.read.format` command, but I recommend to use the domain specific functions.

* DataFrameReader - [parquet](https://spark.apache.org/docs/3.5.6/api/python/reference/pyspark.sql/api/pyspark.sql.DataFrameReader.parquet.html#pyspark.sql.DataFrameReader.parquet "webpage for pyspark api parquet")
* DataFrameReader - [json](https://spark.apache.org/docs/3.5.6/api/python/reference/pyspark.sql/api/pyspark.sql.DataFrameReader.json.html#pyspark.sql.DataFrameReader.json "webpage for pyspark api json")
* DataFrameReader - [csv](https://spark.apache.org/docs/3.5.6/api/python/reference/pyspark.sql/api/pyspark.sql.DataFrameReader.csv.html#pyspark.sql.DataFrameReader.csv "webpage for CSV DataFrameReader")
* DataFrameReader - [jdbc](https://spark.apache.org/docs/3.5.6/api/python/reference/pyspark.sql/api/pyspark.sql.DataFrameReader.jdbc.html#pyspark.sql.DataFrameReader.jdbc "webpage JDBC DataFrameReader")

## Database setup

From your Vagrant Box commandline, make sure your MySQL server is running. Type the command: `sudo systemctl status mysql.service` -- it should report as running.

The next step is to create your database. Run this command from the commandline: `sudo mysql -e "CREATE DATABASE itmd521 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"`

Make sure it worked by issuing the command: `sudo mysql`  then from the MySQL CLI issue: `SHOW DATABASES`, if you see the `itmd521` database then type quit.

The next part is to create a non-root user by issuing the command from the Linux CLI (not from the MySQL commandline). The reason is we want to pass variables into the command -- not hard code credentials. We will all use the same credentials.

Edit the file: `~/.bashrc` by issuing the command: `vim ~/.bashrc`.  Use the command `shift+G` to skip to the end line. Insert a two new lines in the file:

```bash
export USERNAME=controller
export PASSWORD=ilovebunnies
```

Save and exit. **Remember** to source the changes via issuing the command: `. ~/.bashrc`

Now you can issue the command to create a user/password combo in the MySQL server and assign database access.

`sudo mysql -e "GRANT CREATE,SELECT,INSERT,DROP,UPDATE, DELETE,CREATE TEMPORARY TABLES ON itmd521.* TO '$USERNAME'@'127.0.0.1' IDENTIFIED BY '$PASSWORD'";`

Followed by the command: `sudo mysql -e "FLUSH PRIVILEGES;"`

Now you are ready to proceed.

## Assignment Details - Part I

Using the `departuredelays.csv` file, in a single file called `module-06.py` convert the remaining two Spark SQL queries from printed page 87 or page 111 of the PDF into Spark DataFrame APIs.

- Type the remaining Spark SQL examples into your `module-06.py` code, adding comments stating what the text of the printed page is.

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

* As a JSON file 
* JSON using lz4 compression
* As a Parquet file

For all files use `mode` as `overwrite` so that I can run your program and your work will overwrite any previous work. Keep the filename the same, `departuredelays`.

## Assignment Details - Part IV

This section we will be working with the [jdbc](https://spark.apache.org/docs/3.5.6/api/python/reference/pyspark.sql/api/pyspark.sql.DataFrameReader.jdbc.html#pyspark.sql.DataFrameReader.jdbc "webpage JDBC DataFrameReader") Spark integration. Use the PySpark methods -- avoid embedding the direct SQL commands.

```bash
# Use this value to dynamically load the mysql Connector/J jar file at run time
spark-submit --packages com.mysql:mysql-connector-j:9.4.0 ./departuredelays.json
```

* ~~In your MySQL instance from the command line create a `database` named: `module-06` (this step is done manually not in the code).~~
* Read the parquet file you wrote in Part III into a DataFrame 
* Using the DataFrame, select all records that have `ORD` (Chicago O'Hare as `Origin`) writeing the results to a DataFrameWriter named `orddeparturedelays`
* Write the content of the DataFrame: `orddeparturedelays` via JDBC into a **table** in your `itmd-521` database named: `orddeparturedelays` 
* ~~Use a `.show(10)` function to print out the first 10 lines~~

### Deliverable

Create a sub-folder under `labs` named:`module-06` under the `itmd-521` folder. Place all deliverables there.

Submit to Canvas the URL to the folder in your GitHub repo. I will clone your code and run it to test the functionality. I don't need the datasets as I will have them already.

Due at the **Start of class** Oct 1st 1:00 PM
