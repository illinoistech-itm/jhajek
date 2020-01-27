% Spark the Definitive Guide 2nd Edition
% Chapter 01
% Spark Philosophy

# A Gentle Overview

## Text Book

![*itmd-521 textbook*](../images/spark-book.png)

## Preface

- What part of Spark will we cover?
  - High Level Structured APIs
  - DataFrames
  - DataSets
  - SparkQL
  - Structured Streaming
- We will focus in Application development more than operations
- RDDs and DStreams are deprecated and won't be covered

## Overview

## Spark Philosophy

- Spark is a **Unified Computing Engine**
- Spark is a set of libraries for parallel data processing on computer clusters

## Native Language Support

- [Scala](https://en.wikipedia.org/wiki/Scala_\(programming_language\) "Scala programming language wikipedia page")
- Java
- Python
- [R](https://en.wikipedia.org/wiki/R_\(programming_language\) "R programming language wikipedia page")
- SQL

## Architecture

[*Figure 1-1*](../images/fig1-1.png "figure 1-1")

## Breakdown

- A Unified Computing Engine and set of libraries for big data
- Lets break this design down and analyze the parts

## Unified

- Spark offers a **Unified Problem** for Big Data
  - Spark supports data loading (called injesting of data)
  - Spark supports SQL queries
  - Native support of Machine Learning (in memory and iterative data processing)
  - Native support for Streaming Computation (realtime data such as [kafka](https://kafka.apache.org "Kafka apache web page")
- All of these things are included in the standard library of Spark
  - You get this all in one place

