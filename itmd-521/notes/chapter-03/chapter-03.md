% Spark the Definitive Guide 2nd Edition
% Chapter 03
% A Tour of Spark's Toolset

# A Tour of Spark's Toolset

## Text Book

![*itmd-521 textbook*](images/spark-book.png "Spark TextBook")

## Objectives and Outcomes

- Take a tour of Spark's toolset
- Understand how to run production Spark applications
- Understand type-safe APIs for structured data
- Understand Structured Streaming and Machine Learning
- Understand SparkR and Resilient Distributed DataSets

## Review

So far we have:

- learned about core architecture of Spark
  - learned about executors
  - learned about partitions
  - learned about drivers
- learned about datatypes
  - DataFrames
  - APIs
- learned about transformations
- learned about actions
- learned how to put it together from the Spark CLI

## Spark Overview

![*Figure 3-1 Spark's Toolsets*](images/fig3-1.png "Figure 3-1 Spark Architecture")

## Running Production Applications

- `spark-submit`
  - Different from the interactive shell commands we saw in chapter 02
  - `spark-submit` does one thing: send your code to a cluster for execution
  - Application will run until finished or reports and error
- Types of **cluster managers include**:
  - local system (as threads)
  - [Mesos](http://mesos.apache.org/ "Apache Mesos page")
  - [YARN](https://hadoop.apache.org/docs/r2.9.2/hadoop-yarn/hadoop-yarn-site/YARN.html "Apache YARN page")

## Sample Code

- ```spark-submit --class org.apache.spark.examples.SparkPi --master local ./examples/jar/spark-examples_2.11-2.4.4.jar 10```
  - The file name was changes since we are using version 2.4.4 not 2.2.0
  - The job can also be submitted to a cluster by changing the `--master local` to `--master yarn` or `--master mesos`

## Type-Safe DataSets

- Spark uses multiple languages:
  - Scala, Java, Python, R, and SQL
  - Java and Scala are [statically typed](https://en.wikipedia.org/wiki/Type_system "Static typing wiki page") languages
  - Python and R are not statically typed, but dynamically typed
- How to handle type-safety?
  - Recall that DataFrames (chapter 2) are a distributed collection of objected of type **Row**
  - DataSet API allows you to assign a Java/Scala class to the records within a DataFrame
  - Manipulate that data like a Java ArrayList or Scale Seq
- DataSets can be used as needed
  - DataSets can be cast back into DataFrames
  - Allows for *casting* of data depending on your needs
  - Large applications logic will need/enforce type safety, but data analysis via SQL won't need type safety

## Example code of DataSets

```Scala

case class Flight(DEST_COUNTRY_NAME: String, ORIGEN_COUNTRY_NAME: String, count: BigInt)
val flightsDF = spark.read.parquet("/data/flight-data/parquet/2010-summary.parquet/")
val flights = flightsDF.as[Flight]

```

## Conclusion

- Spark is great
