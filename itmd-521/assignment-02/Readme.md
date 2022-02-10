# Assignment 02

## Objectives

- Demonstrate the knowledge of constructing end-to-end DataFrame and Dataset Spark applications
- Demonstrate working code and knowledge of statistics
- Understand and utilize Pyspark and Spark Scala API Documentation

## Assignment Setup

- Using the file `sf-fire-calls.csv`, file write a Pyspark application that answers the seven questions on Page 68 of the Text Book under the header **End-to-End DataFrame Examples**
  - Note do not use the notebook file provided, we want to challenge you to be able to build this yourself
  - All work will be done in your Vagrant Box

## Assignment Details - Part I

- Create a Pyspark application named: assignment-02.py
  - In that application code add seven comments (# pound sign) that types out the question from the text book
  - The schema is provided in the textbook on the preceding pages
  - Provide code to answer the questions below each header
  - You can provide a single "read" of the source code at the top of the file into a DataFrame -- each question does not require a read()
  - Run the source code via Spark-Submit on your Vagrant Box
  - Once you have the answer to the question, go back and add a source code comment with the answer under the question
  - Sample code is available in the book LearningSparkV2 sample code
    - `~/LearningSparkV2/databricks-datasets/learning-spark-v2/sf-fire-calls.csv`
  - Make sure to commit and push code to GitHub continually.  Assignments that have the entire code submitted with none or little commit history will not be accepted.  Commit and push often.
  - Don't share the answers with others.  Your work is individual.

## Assignment Details - Part II

- Create a Spark Scala application named assignment-02.scala
  - The data is available under the LearningSparkV2 book example code
    - LearningSparkV2 > databricks-datasets > learning-spark-v2 > iot-devices > iot_devices.json
  - This is a json file, schema is provided in the textbook on the preceding pages
  - Create the proper build.sbt and additional src scaffolding
  - Answer the 4 questions on page 74 under the header: **End-to_end Dataset example**
  - In your source code add a comment stating the question and provide the code below to answer the question
  - Compile your jar file via the `sbt` command
  - Run the jar file via the `spark-submit` command
  - Once you have the answers, add it via a comment back to your source code.
  - Make sure to commit and push code to GitHub continually.  Assignments that have the entire code submitted with none or little commit history will not be accepted.  Commit and push often.
  - Don't share the answers with others.  Your work is individual.

### Deliverable

Submit to Blackboard the URL to the folder in your GitHub repo.  I will clone your code and run it to test the functionality. I don't need the datasets as I will have them configured in the example-data directory -- path is important.

Due at the **Start of class** February 17th 8:30 am
