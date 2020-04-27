# ITMD-521 Assignment - Cluster Analysis

Using this chart, find the dataset you are to use for this assignment and the Book and the [PySpark Documentation](https://spark.apache.org/docs/latest/api/python/index.html "Link to Pyspark 2.4.5 documentation website")

## Phase I - Data Parsing

This phase will make use of the two single-year data files you created (csv and parquet) in the previous assignment and will use a variation of the code you created for the previous assignment.  Any output files in HDFS should be saved with the same file name (just change the extension from .py to .csv and .parquet)

## Question 1

* Using the single-year file you created as an artifact of the last assignment, read the content and produce a new output file that has the following:
  * One without any values of `99999` in the field **AirTemperature** -- name the file `yyy-0000-valid-records-temp.py`
    * An additional Dataframe written to a file that has three columns: the total record count, the bad record count, and the percentage (bad/total) -- name the file `yyy-0000-records-count-temp.py`
  * One without any values of `99999` in **AtmosphericPressure** -- name the file `yyy-0000-valid-records-press.py`
    * An additional Dataframe written to a file that has three columns: the total record count, the bad record count, and the percentage (bad/total) -- name the file `yyy-0000-valid-records-count-press.py`

## Question 2

Note that the range of temperatures on earth are: 115 degrees Fahrenheit (46 C) at the hottest to minus 100 degrees (-73 C). Filter results to only include values in this range.

* Retrieve the minimum and maximum **AirTemperature** for each of the 12 months for the year you were assigned to (Dataframe structure of your choice) and write this to a file -- name the file `yyy-0000-min-max-airtemp.py`
  * Briefly explain in a paragraph with references, what happens to execution time when you reduce the shuffle partitions from the default of 200 to 20 when re-executing the job above?
* Retrieve the minimum and maximum **AirTemperature** for each of the 12 months for the *decade* you were assigned to (example: 1995 then 90.txt) (Dataframe structure of your choice) and write this to a file -- name the file `yyy-00-min-max-airtemp.py`

## Question 3

* Using the ```.partitionBy``` partition your year's data by Month and write this to a file (parquet only) -- name the file `yyy-0000-partitionby.py`
* Rewrite your csv output file from last assignment using `lz4` as the compression method and lz4 for JSON output (but don't overwrite the csv) -- name the file the same as the original, the lz4 will be added by default to the file name -- name the file `yyy-0000-lz4.py`

## Question 4

* Using the method, `.repartition`, using your code from the first assignment, with lz4 compression enabled in csv, write out your files again this time use 1, 50, and 200 partitions.   Create *six* Python scripts to do the following, 3 to write the files with new partition sizes, 3 to read them back in.
* Read each file - note the job execution time on the HDFS Cluster Manager (192.168.1.100:8088) taking a screen shot of just your job
  * Compare the execution times and explain why or why not there are any significant differences
* Repeat the steps above this time for everyone using the first five years of the decade (90-95 or 2000-2005)
  * Compare the execution times and explain why or why not there are any significant differences
* Name the files:
  * `yyy-0000-partition-one.py`
  * `yyy-0000-partition-fifty.py`
  * `yyy-0000-partition-two-hundred.py`
  * `yyy-00-partition-one.py`
  * `yyy-00-partition-fifty.py`
  * `yyy-00-partition-two-hundred.py`  

### Deliverable

Your goal is three-fold:

1. Demonstrate your ability to read data from files and work with Data of various types (Chapter 6)
1. Clean the datasets to make sure they have usable records in them
1. Based on the amount of data, understand how executors and partitions work and be able to explain them from the source code

### Notes

The execution times may be upwards of 2/3 hours, so start early and don't wait.  This also requires that your remote cluster virtual machine is up and running.  Each dataset will be different so the results will not be the same as any other persons results.  

When making decision in your code, **CITE** the page and chapter you found the information on in Python comment.  Do not be tempted to go to the internet initially, as all the answers you will need are in your textbook.  The internet can mislead you or present you with deprecated code and lead you down a wrong path. Use the textbook and the [PySpark documentation to provide everything you need](https://spark.apache.org/docs/latest/api/python/pyspark.sql.html "PySpark documentation page").

Each Spark job you submit, use the name option to put your initials in front of the name so that your job can be identified in the YARN job console. ```--name jrh-your-python-file.py```.  You find this console at [http://192.168.1.100:8088](http://192.168.1.100:8088 "YARN console")

## Submission

In your Private GitHub Repo, under the folder itmd-521, create a folder named: **Analysis-Assignment**.  Using the **template.md** provided, create a file named: **Readme.md** and fill in all the required values.

Good Luck.
