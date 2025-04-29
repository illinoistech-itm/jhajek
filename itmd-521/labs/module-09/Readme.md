# Lab 07

## Objectives

- Integrate Pyspark source code with our cluster
- Demonstrate the use of Jupytr Hub notebooks and our cluster
- Discuss the ability to integrate JDBC based requests into a Big Data Cluster
- Demonstrate the usage of object storage with the Spark cluster integration 

## Assignment Setup

* Using Jupytr Hub: adjust your `Internal IP for S3 cluster proxy` code to read:
```python
# Internal IP for S3 cluster proxy
conf.set("spark.hadoop.fs.s3a.endpoint", "http://infra-minio-proxy-vm0.service.consul")
```

* Add Connector/J package to the `spark.jars.packages`
```python
conf.set('spark.jars.packages', 'org.apache.hadoop:hadoop-aws:3.2.3')
```

## Assignment Details

* Read the file: `20.txt` from the `itmd521` bucket and write it to your MySQL database to a table named: `twenty`
```python
# Syntax to WRITE out dataframe to MySQL server from Module 7 assignment
# Replace "hajek" variable with your HAWKID, otherwise the database doesn't know where to create the table

(splitDF.write.format("jdbc").option("url","jdbc:mysql://infra-database-vm0.service.consul:3306/hajek").option("driver","com.mysql.cj.jdbc.Driver").option("dbtable","twenty").option("user",mysqlaccesskey).option("password",mysqlsecretkey).save())
```

### Screenshot Required

Using this template, provide a screenshot of the execution of the `show tables;` command from your database on `system31.rice.iit.edu`

**Place Screenshot here**

### Deliverable

Create a sub-folder named: `module-09` under the `itmd-521` folder. Push this deliverable with included screenshot there.

Submit to Canvas the URL to the folder in your GitHub repo. 

Due at the **Start of class** May 02nd 3:15 PM
