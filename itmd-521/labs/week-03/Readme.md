# Lab 01

For ITMD 521, Big Data Technologies, week-04, lab-01, chapter-02

## Objectives

* Deploy and Discuss the structure of a Spark Application
* Compare and Contrast the difference between a PySpark and Scala Spark Application
* Explain the concept of File Paths and explain how they are used to load data into a Spark Cluster

## Outcomes

At the completion of this lab you will have compiled a significant Spark application and learned of the structure of a Spark Application. You will have dealth with file paths and how to load data into a Spark Cluster (local) for Data Analysis.

### Requirements

Type the code in Chapter 02 of the Learning Spark V2 book for both the Python and Scala version of the mnmcount. Compile and run on your local Spark Cluster (Vagrant Box) and take the required screenshots listed in the following sections. 

Work on your local system MacOS or Windows and push your code to GitHub, then in your Vagrant Box (Ubuntu Linux) pull your code changes and run the code.

You will also need access to the [Learning Spark V2 sample code data files](https://github.com/databricks/LearningSparkV2.git "webpage class sample code"). In your Vagratn Box clone the repo: `https://github.com/databricks/LearningSparkV2.git` 

### Lab 01

You are to take the sample code listed in Chapter 02, the MnMCount for both Python and Scala, in the case of Scala, you are to use the SBT tool to build and run the application (see Monday slides for info to install SBT). You will capture the entire screen of output, the key content will look something like this:

```
+-----+------+----------+
|State| Color|sum(Count)|
+-----+------+----------+
|   CA|Yellow|    100956|
|   CA| Brown|     95762|
|   CA| Green|     93505|
|   CA|   Red|     91527|
|   CA|Orange|     90311|
|   CA|  Blue|     89123|
+-----+------+----------+
```

Make sure the `vagrant@your-initials` is in the screenshot

### PySpark ScreenShot

Place PySpark screenshot here

### SBT build Output Screenshot

Place screenshot here

### Spark Scala ScreenShot

Place Scala screenshot here

## Deliverables

Using this template, under the `itmd-521` directory in your local repository, create a sub-directory named `labs`. Under that create another subdirectory named `week-03` and place this Readme.md file in that directory along with a folder for images.

You also need to include your python and scala code and the `build.sbt` file. Push the code to your remote GitHub repo and submit the URL to this location in Blackboard.

Do not push any data files into your GitHub repo
