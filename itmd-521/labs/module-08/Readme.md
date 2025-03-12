# Lab 06

## Objectives

- Integrate Pyspark source code with our cluster
- Demonstrate the use of Jupytr Hub notebooks and our cluster
- Demonstrate the usage of version control for the Spark cluster deployment of code
- Demonstrate the usage of object storage with the Spark cluster integration 

## Assignment Setup

On our `spark-edge` class cluster server, `system26.rice.iit.edu`, connect via SSH and retrieve the contents of the `login.txt` file. In addition, create a new ssh keypair on the `system26.rice.iit.edu` server.

Place the public portion of the new keypair in your GitHub repo. Create and configure a new `config` file (on the spark-edge server). Clone your provided private repo to the `spark-edge` server. Refer to the 03/11 and 03/06. 

See the tutorial documents:

* [Jupytr Notebook Spark Tutorial](https://github.com/illinoistech-itm/jhajek/blob/master/itmd-521/JupyterHub/Readme.md "webpage for Jupytr Notebook Spark Tutorial")
* [Jupytr Hub Running Spark Jobs](https://github.com/illinoistech-itm/jhajek/blob/master/itmd-521/JupyterHub/hub-tutorial.md#running-spark-jobs "webpage for Running Spark Jobs")
* [Complete Jupytr Notebook Spark Cluster example](https://github.com/illinoistech-itm/jhajek/blob/master/itmd-521/JupyterHub/example-hub-applications.ipynb "webpage for complete demo of Notebook")

## Assignment Details

Copy the example notebook code to your local system and push it to your GitHub repo (making the changes where noted). Run the sample code that will take the raw data of 50.txt and write the cleaned dataset to your Minio bucket.

### Screenshot Required

Using this template, provide a screenshot from the Minio consul, inside your bucket showing the written dataset, 50.csv

**Place Screenshot here**

### Deliverable

Create a sub-folder named: `module-08` under the `itmd-521` folder. Place this deliverable with included screenshot there.

Submit to Canvas the URL to the folder in your GitHub repo. 

Due at the **Start of class** March 25th 3:15 PM
