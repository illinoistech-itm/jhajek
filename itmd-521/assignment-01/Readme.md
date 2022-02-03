# Assignment 01

## Assignment Setup

- Using the Divy bike rental data provided by the professor - in the jhajek sample code repo
  - Using Python create a Spark Application and SparkSession object named Spark
- In your private repo add the following data types to the `.gitignore` file
  - *.csv
  - *.txt
  - *.json
  - `example-data/` to ignore the entire folder called example-data

## Assignment Details

- In your local Git Repo, create a folder named **assignment-01** under the `itmd-521` folder.  Create a sub-folder named `exmaple-data` and an application named `assignment-01.py`
  - Create three data frames reading the `Divvy_Trips_2015-Q1.csv` from your local system
  - First **infer the schema**
  - Second programmatically use **StructFields** to create and attach a schema
  - Third attach a schema via a DDL
  - After each read operation include the function [printSchema()](https://spark.apache.org/docs/latest/api/python/reference/api/pyspark.sql.DataFrame.printSchema.html "pyspark printschema web page")
  - From the first DataFrame, save the data back to disk in the folder `example-data` and name the parquet file **divy-2015**
- Now create another DataFrame in your application and read the Parquet file just created into a DataFrame

## Assignment Details Continued

- You will run some Transformations and Actions
  - Use a `select` function to select Gender
  - If your last name starts with A-K select female, L-Z select male
  - GroupBy the field `station to`
  - Issue a show function displaying 10 records of the DataFrame (up to page 62 in the text book)
- Repeat the above steps and create a file named: `assignment-01.scala`
  - Compile and test the code using the sbt compiler

### Deliverable

Submit to Blackboard the URL to the folder in your GitHub repo.  I will clone your code and run it to test the functionality. I don't need the datasets as I will have them configured in the example-data directory -- path is important.

Due at the **Start of class** February 10th 8:30 am
