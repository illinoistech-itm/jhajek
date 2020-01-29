% Spark the Definitive Guide 2nd Edition
% Chapter 02
% A Gentle Introduction to Spark

# A Gentle Overview

## Text Book

![*itmd-521 textbook*](images/spark-book.png "Spark TextBook")

## Spark's Basic Architecture 22

- Single Computers work pretty well
- Powerful
- But only one machine
- This limits what can be done
- Single machines don't have the necessary power or the parallel ability
- Multiple computers alone are not enough -- you need a framework to control the data
  - To schedule data movement and data processing

## Spark Cluster Manager

- Spark has its won software based cluster manager.  
- Configurable out of the box
  - Simple config file denoting if the node is a slave or master
- Spark can also use existing cluster managers:
  - YARN from Hadoop 2.x/3.x
- [Mesos](https://mesos.apache.org "Apache mesos web site")
  - Cluster scheduler created by Twitter
  - Still in use, we won't focus on Mesos in this class
- We will work initially with the built in Spark cluster manager
- YARN later in the semester when we move to cluster work

## Core Architecture

![*Spark Core Architecture*](images/fig-2-1.png "Spark Core Architecture Diagram")

## Spark Applications

- What makes up a Spark application?
  - Magic
- It is two things
  - A single **driver process** (like a main process in Java or Python)
  - A **set** of *executor processes* 

## More Application

- A Driver runs the Spark Applications main() function
- This process sits on a node in the cluster
  - Remember Spark is always assumed to be an 2+ node cluster with an additional master node
- The Main function does 3 things:
  - Maintain information about the running process
  - Respond a user's program or input
  - Analyzing, distributing, and scheduling work across the executor processes
- Driver process is essential to the running of the application (can't crash!)

## Executors

- Responsible for carrying out the work that the Driver assigns them
- Executor then is responsible for two things:
  - Executing the code assigned by the Driver
  - Reporting the state of the execution back to the driver node 

## Architecture

![*Spark Core Architecture*](images/fig-2-1.png "Spark Core Architecture Diagram")

## Conclusion

- Spark is great
