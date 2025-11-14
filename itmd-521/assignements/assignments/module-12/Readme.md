# Module 12

This is the Data Engineering Lab.

## Objectives

* Apply the concepts of Data Engineering
* Explore the concepts of running Data jobs on a cluster
* Explore using large datasets
* Compare and contrast file types usage on a cluster

## Outcomes

In this lab you will begin to apply the concepts we have covered in the Data Engineering and Learning Spark books. You will begin to use increasingly larger raw text datasets and begin to clean the data.

## Part One

Using the sample code provided as a basis, you will create a series of `.ipynb` files under the directory `labs` > `module-12` in your private repo. There will be on file per item listed below.  Example, `lab00.ipynb`, `lab10.ipynb`, etc, etc.  Do not make one file to do all the reads -- you need separate files.

1) 00.txt
1) 10.txt
1) 20.txt
1) 30.txt
1) 40.txt
1) 50.txt
1) 60.txt
1) 70.txt
1) 80.txt
1) 90.txt
1) 200.txt
1) ~~210.txt~~ 201.txt

In each file you will use the provided parsing code to separate out the field data and save that data into a DataFrame.

Before writing data back to the Minio Block storage you have two tasks that can be done using the PySpark API:

1) Place NULLs in the fields that have 99999 or +9999 as values. These are missing values according to the PDF in Canvas.

2) Remove records that have missing or Air Temperature values that are above or below the human liveable range.

## Deliverable

Write the content of this filtered DatatFrame to your Minio bucket, there will be one written as a CSV, one as a Parquet, and one as a CSV using LZ4 compression.

Submit the URL of your Bucket containing the finished DataFrames.

**NOTE** the datasets get increasingly large and will take a long time, multiple days. Submit the work onto the queue early.
