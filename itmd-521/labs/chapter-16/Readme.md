# ITMD-521 IT-D 872 Chapter-16 Lab

You will copy this template file to your own private GitHub repo provided.  Under your itmd-521 folder you will create a sub-folder named: **labs**.  Under that folder create a sub-folder named: **chapter-16**.  In that folder place this Readme.md

## Objectives

- Demonstrate the use of caching in relation to Spark applications
- Explain and Discuss the use of caching and its performance impacts for Spark applications
- Demonstrate the use of partitioning in relation to Spark applications
- Explain and Discuss the use of partitioning and its performance impacts for Spark applications
- Demonstrate the use of executors and executor memory usage in relation to Spark applications
- Explain and Discuss the use of executors and executor memory usage and its performance impacts for Spark applications

## Your name goes here

### Lab

You will write one Spark application, in Java or Python that will work with the sample NCDC data provided

- The application will include these steps, place a screenshot of the output under each item.  
- Include a discrete source code file for each of the parts listed below and instructions in an **install.md** file.
- For the `SparkSession.builder.appName` use:
  - `HAWKID - lab chapter 16`  - not Anumber, for example: `ppatel108`  
- You will reuse the Parquet dataset that you wrote out in the last step of lab 6 as your input data
- You will reuse the code logic from Part 1 of lab chapter 11
- Use the this resource allocation:
  - `--driver-cores 1 --total-executor-cores 4 --num-executors 4  --driver-memory 4g --executor-memory 4g`

### Part I

Reusing the logic (only) from part I of chapter 11 lab:

- Load the Parquet dataset that you wrote out in the last step of lab 6 as your input data
  - You can bypass any formatting and parsing steps as the Parquet file format has the schema already in place
- Rerun your part I chapter 11 code on this new dataset
  - Take note of the execution time from [http://192.168.172.23:8080](http://192.168.172.23:8080 "Spark execution time")
  - Place screenshot (of just yours) here, noting the execution time
  - Keep the variables the same: `--driver-cores 1 --total-executor-cores 4 --num-executors 4  --driver-memory 4g --executor-memory 4g`
  - .show(20) to the screen
  - No need to write or save the results out to a file, a we are interested in calculation times

### Part II

- Load the Parquet dataset that you wrote out in the last step of lab 6 as your input data
- On your dataframe, execute a `.cache()` command after completing the previous steps
  - [https://spark.apache.org/docs/latest/api/python/reference/api/pyspark.sql.DataFrame.cache.html?highlight=cache](https://spark.apache.org/docs/latest/api/python/reference/api/pyspark.sql.DataFrame.cache.html?highlight=cache "Spark Cache Command")
- Repeat the above steps and place screenshot (of just yours) here, noting the execution time
  - Based on Chapter 16, explain the cache function and if it had a positive or negative impact on execution time, and why.
- Explain here...

### Part III

- Load the Parquet dataset that you wrote out in the last step of lab 6 as your input data
- On your dataframe, execute a `.cache()` command after completing the previous steps
- Use the `.repartition()` function to repartition your data frame
  - [https://spark.apache.org/docs/latest/api/python/reference/api/pyspark.sql.DataFrame.repartition.html?highlight=repartition](https://spark.apache.org/docs/latest/api/python/reference/api/pyspark.sql.DataFrame.repartition.html?highlight=repartition "repartition API")
  - Chose which Column to partition by, Weather_Station or Observation_date - example `.repartition("month")`
  - Add code to count the number of partitions that are present after the repartition
  - Execute the logic you used for Chapter 11 part I
  - Rerun you chapter 11 part I code after the repartition
  - Place screenshot (of just yours) here, noting the execution time
- Explain why you chose the column you did and the impact on performance relative to the last execution time from part I

### Part IV

- Load the Parquet dataset that you wrote out in the last step of lab 6 as your input data
- On your dataframe, execute a `.cache()` command after completing the previous steps
- Repeat the steps above, this time add an integer to force the number of partitions
  - Once for 8 partitions: `.repartition(8, "month")`
  - Execute the logic you used for Chapter 11 part I
  - Place screenshot (of just yours) here, noting the execution time
- Explain the impact of limiting partitions in the difference between the execution times and how changing the number of partitions effected these numbers

### Part V

- Load the Parquet dataset that you wrote out in the last step of lab 6 as your input data
- On your dataframe, execute a `.cache()` command after completing the previous steps
- Repeat the steps above, this time add an integer to force the number of partitions
  - Once for 32 partitions: `.repartition(32, "month")`
  - Execute the logic you used for Chapter 11 part I
  - Place screenshot (of just yours) here, noting the execution time
- Explain the impact of limiting partitions in the difference between the execution times and how changing the number of partitions effected these numbers

### Part VI

- Load the Parquet dataset that you wrote out in the last step of lab 6 as your input data
- On your dataframe, execute a `.cache()` command after completing the previous steps
  - Execute the logic you used for Chapter 11 part I
  - Use the below parameters:
    - `--driver-cores 1 --driver-memory 4g --num-executors 8 --executor-memory 4g`
  - Take notice of differences in execution time
- Explain any differences when the number of executors is increased to 8

### Part VII

- Load the Parquet dataset that you wrote out in the last step of lab 6 as your input data
- On your dataframe, execute a `.cache()` command after completing the previous steps
  - Execute the logic you used for Chapter 11 part I
  - Use the below parameters:
    - `--driver-cores 1 --driver-memory 4g --num-executors 32 --executor-memory 4g`
  - Take notice of differences in execution time
- Explain any differences when the number of executors is increased to 8  

### Notes

Official Documentation:

- [https://spark.apache.org/docs/3.0.2/api/python/pyspark.sql.html](https://spark.apache.org/docs/3.0.2/api/python/pyspark.sql.html "pyspark SQL official documentation)
- [https://spark.apache.org/docs/3.0.2/api/java/index.html](https://spark.apache.org/docs/3.0.2/api/java/index.html "spark java official documentation")
  - .cache()
  - .partition()
  - coalesce()

### Building Instructions

Place and instructions or assumptions needed to run your code in the `install.md` file.

### Deliverable

In your private repo push the Java or Python code you have written, any jars, the Readme.md and install.md document to the directory under your private GitHub repo: itmd-521 > labs > chapter-16.  

Submit the URL to this page to Blackboard as your deliverable.
