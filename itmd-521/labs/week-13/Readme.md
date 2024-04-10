# Week 13 Lab

This is the lab for week 13 demonstrating cluster integration

## Objectives

* Understand how to create Spark Sessions
* Explain the functionality of Executors, Executors Memory, and Executor Cores
* Demonstrate PySpark application integration with S3 cluster
* Demonstrate the performance impact of using multiple partitions and compression within partitions
* Demonstrate basic SQL statistics usage within PySpark

## Outcomes

At the conclusion of the lab you will have experienced writing an end-to-end PySpark application reading and storing data from an S3 Object Store (Minio). You will have experienced writing PySpark basic statistics functions.

### Datasets to use

Based on your **lastname** you will use a different raw dataset that is located in the itmd-521 bucket for each of the parts of the lab.

* A-F use 60.txt
* G-L use 70.txt
* M-S use 80.txt
* T-Z use 90.txt

## Part One - Spark Edge Account Setups

For this portion of the lab you will need to configure your account on the Spark-Edge server. This requires you to generate a new `ed25519` keypair, register this key with GitHub, setup your `config` for ssh cloning and clone your provided repo to the Spark-Edge server. The point is that you are going to work locally on your Windows or Mac system and push changes to GitHub then `git pull` those changes to the Spark-Edge server for execution.

Include ScreenShot of `ls` command of your home directory on Spark-Edge server showing cloned repo.

You need to set your `SECRETKEY` and `ACCESSKEY` in your `.bashrc` file and import then into your PySpark files, no hard-coding of secrets.

## Part Two - Data Engineering 

The raw data records look like this:
`0088999999949101950123114005+42550-092400SAO  +026599999V02015859008850609649N012800599-00504-00785999999EQDN01 00000JPWTH 1QNNG11 1 00200K11 1 00018L11 1 00800N11 1 00000S11 1 00023W11 1 54017`

The schema is found by using this Python code to find the substrings and give titles to each category...

```python
splitDF = df.withColumn('WeatherStation', df['_c0'].substr(5, 6)) \
.withColumn('WBAN', df['_c0'].substr(11, 5)) \
.withColumn('ObservationDate',to_date(df['_c0'].substr(16,8), 'yyyyMMdd')) \
.withColumn('ObservationHour', df['_c0'].substr(24, 4).cast(IntegerType())) \
.withColumn('Latitude', df['_c0'].substr(29, 6).cast('float') / 1000) \
.withColumn('Longitude', df['_c0'].substr(35, 7).cast('float') / 1000) \
.withColumn('Elevation', df['_c0'].substr(47, 5).cast(IntegerType())) \
.withColumn('WindDirection', df['_c0'].substr(61, 3).cast(IntegerType())) \
.withColumn('WDQualityCode', df['_c0'].substr(64, 1).cast(IntegerType())) \
.withColumn('SkyCeilingHeight', df['_c0'].substr(71, 5).cast(IntegerType())) \
.withColumn('SCQualityCode', df['_c0'].substr(76, 1).cast(IntegerType())) \
.withColumn('VisibilityDistance', df['_c0'].substr(79, 6).cast(IntegerType())) \
.withColumn('VDQualityCode', df['_c0'].substr(86, 1).cast(IntegerType())) \
.withColumn('AirTemperature', df['_c0'].substr(88, 5).cast('float') /10) \
.withColumn('ATQualityCode', df['_c0'].substr(93, 1).cast(IntegerType())) \
.withColumn('DewPoint', df['_c0'].substr(94, 5).cast('float')) \
.withColumn('DPQualityCode', df['_c0'].substr(99, 1).cast(IntegerType())) \
.withColumn('AtmosphericPressure', df['_c0'].substr(100, 5).cast('float')/ 10) \
.withColumn('APQualityCode', df['_c0'].substr(105, 1).cast(IntegerType())).drop('_c0')
```

Using the sample code provided to you in the `minios3.py` file - make sure you have the latest version, we added two additional lines to speedup object/partition writing in Minio.

#### Modify AppName

Modify the value in the `appName` function. Use your HAWKID (not the @hawk part) and try to be specific on what part of the assignment you are running.

```spark = SparkSession.builder.appName("JRH convert 50.txt to csv").config('spark.driver.host','spark-edge.service.consul').config(conf=conf).getOrCreate()```

### Part Two deliverable

* Create a CSV file of the *cleaned* data
  * Name the file: 50-uncompressed.csv (where 50 is the decade you were assigned)
* Create a CSV using `lz4` compression
  * Name the file: 50-compressed.csv (where 50 is the decade you were assigned)
* Using the `coalese()` function, write the CSV down to a single partition
  * [Pyspark coalese()](https://spark.apache.org/docs/latest/api/python/reference/pyspark.sql/api/pyspark.sql.functions.coalesce.html "website for pyspark coalese function")
  * Name the file: 50.csv (where 50 is the decade you were assigned)
* Create a Parquet file
  * Name the file: 50.parquet (where 50 is the decade you were assigned)
* Write/Save these to your Minio Bucket

### Part Three deliverable

Depending on your decade find the required Pyspark functions to execute and execute them. Use the cleaned dataset you previously generated. Do not use AI/GPT or copy and paste from the internet. Follow the instructions exactly in regards to valid and invalid records

#### A-F

Using your assigned dataset, find the Average temperature per month per year. Write these results out as a Parquet file named: `part-three.parquet`. Make use of Pyspark functions covered in the `Learning Spark v2` book as well as the Pyspark documentation.  Comment your code to explain how and why you are using it. **Do not strip out** any invalid records.

Take only 12 records (only the first year of the decade) and write this to csv file named `part-three.csv`

#### G-L

Using your assigned dataset, find the Average temperature per month per year. You will need to **strip out** any temperature values that are outside of the human survival range (invalid integers). Write these results out as a Parquet file named: `part-three.parquet`. Make use of Pyspark functions covered in the `Learning Spark v2` book as well as the Pyspark documentation. Do not use AI/GPT or copy and paste from the internet. Comment your code to explain how and why you are using it.

Take only 12 records (only the first year of the decade) and write this to csv file named `part-three.csv`

#### M-S

Using your assigned dataset, find the Average temperature per month per year. Then find the standard deviation of each temperature over the course of the decade per month. Write these results out as a Parquet file named: `part-three.parquet`. Make use of Pyspark functions covered in the `Learning Spark v2` book as well as the Pyspark documentation. Do not use AI/GPT or copy and paste from the internet. Comment your code to explain how and why you are using it. **Do not strip out** invalid temperature values.

Take only 12 records (the month and standard deviations) and write this to csv file named `part-three.csv`

#### T-Z

Using your assigned dataset, find the Average temperature per month per year. Then find the standard deviation of each temperature over the course of the decade per month. Write these results out as a Parquet file named: `part-three.parquet`. Make use of Pyspark functions covered in the `Learning Spark v2` book as well as the Pyspark documentation. Do not use AI/GPT or copy and paste from the internet. Comment your code to explain how and why you are using it. **Strip out** invalid Temperature records. 

Take only 12 records (the month and standard deviations) and write this to csv file named `part-three.csv`

## Deliverable

* For section 05 due Wednesday the 17th 1:50 PM - meaning the final submission is due at that time.
* For section 01,02, 03 due Thursday the 18th 3:15 PM - meaning the final submission is due at that time.

Push your Pyspark script or scripts to a file named `week-13` and submit the URL to that file to Blackboard.
