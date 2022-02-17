# Assignment 03

## Objectives

- Understand the structure of Spark SQL queries and how to convert them to PySpark DataFrame API calls
- Understand how to make tempViews from Tables
- Understand how to make queries against tempViews
- Understand how to use the Spark Catalog

## Assignment Setup

- We will be using the departuredelays file located at:
  - `~/LearningSparkV2/databricks-datasets/learning-spark-v2/flights`
  - Copy this file to your Home directory ( ~ ) we will set all our code paths there
  - See Python sample below for how to structure commandline input of datasources
  - Note do not use the notebook file provided, we want to challenge you to be able to build this yourself
  - All Code will be created on your local system, pushed to GitHub, and then pulled to your Vagrant Box
  - We will create one file named: assignment-03.py
  - You can use Scala if you want

```python
# From MnMCount sample on page 36
    if len(sys.argv) != 2:
        print("Usage: Please input the file name and its path as an argument <file>", file=sys.stderr)
        sys.exit(-1)
    spark = (SparkSession.builder.appName("Assignment-XX").getOrCreate())
    data_file = sys.argv[1]

# Add additonal .option() as needed
# Adjsut format as needed
df = spark.read.format("csv").load(data_file)

```

## Assignment Details - Part I

Using the departuredelays.csv file, in a single file called assignment-03.py convert the remaining two Spark SQL queries from page 87 into Spark DataFrame APIs

- Type the remaining Spark SQL examples on page 87 into your code
- Run it to show the results limit 10 records
- Then type the corresponding PySpark DataFrame API below to compare answers
- The code must run and show the desired results

## Assignment Details - Part II

- From page 90-92, you will create a Table named `us_delay_flights_tbl` from the departuredelay.csv
  - Create a `tempView` of all flights with an origin of Chicago (ORD)
  - Show the first 5 records of the tempView
  - Use the Spark Catalog to list the columns of the tempView

### Deliverable

- Once you have the answers, add it via a commit back to your source code.
- Make sure to commit and push code to GitHub continually.  Assignments that have the entire code submitted with none or little commit history will not be accepted.  Commit and push often.
- Don't share the answers with others.  Your work is individual.

Submit to Blackboard the URL to the folder in your GitHub repo.  I will clone your code and run it to test the functionality. I don't need the datasets as I will have them configured in the example-data directory -- path is important.

Due at the **Start of class** February 24th 8:30 am
