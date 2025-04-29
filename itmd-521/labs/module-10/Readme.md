# Lab 06

## Objectives

- Integrate Pyspark source code with our cluster
- Demonstrate the use of Jupytr Hub notebooks and our cluster
- Discuss the ability to integrate JDBC based requests into a Big Data Cluster
- Compare with an explanation the execution time of a spark job reading from a Minio Cluster compared to a MySQL database

## Assignment Setup

Using the adjusted setup from Module-09, and based on your assigned dataset, you will execute two comparisons of initial write and load times of two jobs using the Minio Cluster (Object Storage) and MySQL storage.

* A-F use 60.txt
* G-L use 70.txt
* M-S use 80.txt
* T-Z use 90.txt

## Assignment Setup Details

* Read the assigned year value from the `itmd521` bucket into a single DataFrame
* Clean the data with the given cleaning code in the example-code Jupytr Notebook
* Write the contents of the DataFrame to your Minio bucket and to your own Database
  * Create a table name based on the english word representing the decade you are working with

## Assignment Setup Part I

* Write a Pyspark application to query the cleaned dataset into a DataFrame from your S3 bucket


### Screenshot Required

Using this template, provide a screenshot of the execution of the `show tables;` command from your database on `system31.rice.iit.edu`

**Place Screenshot here**

### Deliverable

Create a sub-folder named: `module-08` under the `itmd-521` folder. Push this deliverable with included screenshot there.

Submit to Canvas the URL to the folder in your GitHub repo. 

Due at the **Start of class** May 02nd 3:15 PM
