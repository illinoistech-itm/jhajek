# Lab 08

## Objectives

- Integrate Pyspark source code with our cluster
- Demonstrate the use of Jupytr Hub notebooks and our cluster
- Discuss the ability to integrate JDBC based requests into a Big Data Cluster
- Compare with an explanation the execution time of a spark job reading from a Minio Cluster compared to a MySQL database

## Assignment Setup

Using the adjusted setup from Module-09, and based on your assigned dataset, you will execute two comparisons of initial write and load times of two jobs using the Minio Cluster (Object Storage) and MySQL storage.

* A-F use 40.txt
* G-L use 50.txt
* M-S use 60.txt
* T-Z use 40.txt

## Assignment Setup Details

* Read the assigned year value from the `itmd521` bucket into a single DataFrame
* Clean the data with the given cleaning code in the example-code Jupytr Notebook
* Write the contents of the DataFrame to your Minio bucket as a Parquet file
  * Create file name based on the english word representing the decade you are working with
* Write the contents of the DataFrame to your own Database
  * Create a table name based on the english word representing the decade you are working with

## Assignment Part I

Write a Pyspark application to read: 

* The cleaned dataset into a DataFrame from your S3 bucket
* The cleaned dataset into a DataFrame from MySQL table

## Assignment Part II

* Create a Pyspark statement that will split the DataFrame data into two additional Parquet files
  * Based on Longitude and Latitude (Northern and Southern hemisphere)
* Write the two DataFrames out as MySQL tables
* Write the two DataFrames out as Parquet files
  * Name them with the english word of the decade plus `-northern` or -`southern`

### Deliverable

Create a sub-folder named: `module-10` under the `itmd-521` folder. Submit the URL to your code in GitHub

Submit to Canvas the URL to the folder in your GitHub repo. 

Due at May 03rd 11:59 PM
