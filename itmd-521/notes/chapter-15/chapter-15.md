% Spark the Definitive Guide 2nd Edition
% Chapter 15
% How Spark Runs on a Cluster

# How Spark Runs on a Cluster

## Text Book

![*itmd-521 textbook*](images/spark-book.png "Spark TextBook")

## Objectives and Outcomes

- Introduce and discuss what happens when Spark executes code
- Understand the architecture and components of a Spark Application
- Understand and discuss Spark pipelining
- Understand the requirements to run a Spark Application (leaning into chapter 16)

## Review - 214

- Thus far we have...
  - Focused on Spark's properties as a programming interface
  - Discussed how the structured APIs take a logical operation
  - Break it into a logical plan
  - Convert that to a physical plan that consists of RDD operations
  - Executes them across a cluster of machines
- Learned the 6 core filetypes and their pros and cons

## The Architecture of a Spark Application

- Some review from the mid-term:
- The Spark driver
  - The controller of the execution of a Spark Application
  - Maintains all of the state of the Spark cluster
  - It must interface with the cluster manager to get physical resources
  - Ultimately a process for maintaining the state of the application running on the cluster
- Spark Executors
  - These are processes that perform the tasks assigned by the Spark driver
  - Report their state back (success or failure)
  - There can be multiple **executor** processes

## The Architecture of a Spark Application - New Parts

- The Cluster Manager
  - The driver and executors do not exist in a vacuum
  - A cluster manager maintains a cluster of machines that will run your Spark Application
  - A cluster has its own "driver" process and "worker" processes (separate from Spark)
  - These processes are tied to physical machines (cluster nodes)
- When we run a Spark Application we request resources from the cluster manager to run it
  - The cluster manager is responsible for running the underlying computers
  - ![*Figure 15-1. A Cluster Driver*](images/figure-15-1.png "Figure 15-1 A Cluster Driver")

## Execution Modes

- There are [four types of cluster manager types](https://spark.apache.org/docs/latest/ "Spark documentation on cluster types") available (Spark 2.4.5)
  - standalone cluster manager
  - Apache Mesos
  - [Hadoop YARN](https://spark.apache.org/docs/latest/running-on-yarn.html "Apache YARN documentation")
  - Kubernetes
- We will be focusing on Hadoop YARN as that is what we have setup and running already  
- There are three execution modes
  - This is how you tell the Spark application how to distribute your application
  - This gives you the power to determine where the resources are located when you run the application
    - Cluster mode
    - Client mode
    - Local mode
- We will be moving away from the shell (pyspark or spark-shell) and to compiled code for submission to a cluster




## Sample

- sample 1

## Conclusion

- We walked through the six core data-sources.
- We walked through the various read and write options for these six datatypes
- We covered reading and writing data in parallel
- We explained partitioning and bucketing in relation to writing data

## Questions

- Any questions?
- For next time, read Chapter 15 & 16 and do any exercises in the book.
