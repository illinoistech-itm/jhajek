# ITMD 521 Final Project

This will be the description and deliverable for the final project for ITMD 521

## General Notes

* All commits and code must be placed in the private repo assigned at the beginning of the semester
  * Under the folder: `itmd-521` > `final`
  * Include a **Readme.md** file in the `final` directory with instructions and commands to run each of your scripts
  * Create a sub-folder: `part-one`, `part-two`, `part-three`, `part-four`
  * In each sub-folder provide the PySpark `.py` files to accomplish the requirements
  * Create a Readme.md with the results (screenshot), if applicable for the output of a section
  * I will run this to check your work and compare output
* Clone/pull you code to the spark edge server account you were given access to
* Clone via SSH key - as demonstrated in the video prepared 04/19

* Make use of any of the sample code provided in the [jhajek repo](https://github.com/illinoistech-itm/jhajek/tree/master/itmd-521/example-code "jhajek sample code repo")
* Make extensive use of the [PySpark API documentation](https://spark.apache.org/docs/latest/api/python/index.html "PySpark API documentation") and the textbook

### Part One

The first part of the assignment you will be doing data engineering by converting raw text records, parsing them and saving them in many different formats in our Minio Object storage system.

* Use the raw data set you were assigned
* Use this syntax for each job run, for example:
  * ```spark-submit --master spark://192.168.172.23:7077 --packages "org.apache.hadoop:hadoop-aws:3.2.2" --driver-memory 10G --executor-memory 10G --executor-cores 2 ncdc.py 20.txt 20.csv csv```
* Using the sample code create a PySpark application to parse the raw datasource assigned into 5 edited outputs and name the results the same prefix as the source (20.txt becomes 20.csv for example)
  * csv
  * json
  * csv with lz4 compression
  * parquet
  * csv with a single partition (need to adjust filename to not overwrite the first csv requirement)
    * Name this for example:  20-single-part.csv

### Part Two

This part you will read the datasets you created back into your PySpark application and create schemas where necessary.

* Read your partitioned .csv into a DataFrame named: `csvdf`
  * Create a schema based on the sample given in the jhajek sample code, `minio-csv.py`
  * Show the first 10 records and print the schema
* Read your partitioned .json into a DataFrame named: `jsondf`
  * Create a schema based on the sample given in the jhajek sample code, `minio-csv.py`
  * Show the first 10 records and print the schema
* Read your partitioned .parquet into a DataFrame named: `parquetdf`
  * Show the first 10 records and print the schema
* Connect to the MariaDB server located at `192.168.172.31`
  * Connect to the database `ncdc` and table `fifties`
  * Show the first 10 records and print the schema
  * Username: worker
  * Password: cluster
* MySQL Connector/J is located at:  `--jars /opt/spark/jars/mysql-connector-java-8.0.28.jar`
* Connect using the parameters like this:

```python
(DF.read.format("jdbc").option("url","jdbc:mysql://192.168.172.31:3306/ncdc").option("driver","com.mysql.cj.jdbc.Driver").option("dbtable","fifties").option("user","worker").option("password", "cluster").load())
```

### Part-Three

In this section you will execute the same command 3 times and modify run time parameters and make note of the execution times and explain what the adjustments did. To do this create a PySpark application to read your prescribed decade .parquet file data and find all of the weather station ids that have registered days (count) of visibility less than 200 per year.

Using these parameters:

* `--driver-memory`
* `--executor-memory`
* `--executor-cores`
* `--total-executor-cores`

* First run
  * `--driver-memory 2G --executor-memory 4G --executor-cores 1 --total-executor-cores 20`
  * Your Expectation:
  * Your results/runtime:
* Second run
  * `--driver-memory 10G --executor-memory 12G --executor-cores 2`
  * Your Expectation:
  * Your results/runtime:
* Third run
  * `--driver-memory 4G --executor-memory 4G --executor-cores 2 --total-executor-cores 40`
  * Your Expectation:
  * Your results/runtime:

### Part Four

This part you will do some basic analytics using the Spark SQL or the native PySpark libraries. You will use the assigned dataset that you have already processed into the parquet format (load the .parquet file).  Use the Spark optimizations discussed in the previous section to optimize task run time -- resist the temptation to assign all cluster resources - use the first run options as a baseline

* Using date ranges, select all records for the month of February for each year in the decade, find the following:
  * Count the number of records
  * Average air temperature
  * Median air temperature
  * Standard Deviation of air temperature
* Using the entire decade dataset, find the following:
  * The weather station ID that has the lowest recorded temperature per year
  * The weather station ID that has the highest recorded temperature per year
  * You may have to add filters to remove records that have values that are legal but not real -- such as 9999

### Final Note

These jobs might take a while to process, potentially hours--**Don't wait!**.  You can execute jobs and add them to the queue -- when resources free up, your job will execute.  You can submit a job to execute without having to keep your computer open all the time by using the `nohup` command, put `nohup` in front of your command and a `&` at the end will background and allow you to disconnect from the spark edge server (not hang up).

```nohup spark-submit --master spark://192.168.172.23:7077 --packages "org.apache.hadoop:hadoop-aws:3.2.2" --driver-memory 2G --executor-memory 4G --executor-cores 1 ncdc-single-partition-csv.py 50.txt 50.csv csv &```

## Due Date and Finals Presentation

* Submit the URL to your GitHub account to Blackboard by 11:59 pm, Saturday 04/30
  * Worth 80 points
* Thursday May 5th, during the scheduled final exam period you will demonstrate the results of `part-three` and give a verbal explanation (Use the textbook as your source for explanations)
  * Worth 20 points
