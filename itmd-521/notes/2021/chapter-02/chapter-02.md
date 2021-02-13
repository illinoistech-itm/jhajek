% Spark in Action: Second Edition
% Chapter 02
% Architecture and Flow

# Architecture and Flow

## Text Book

![*itmd-521 textbook*](images/Spark-In-Action-V2.png "Spark In Action Book Cover Image")

## Scientist Tech Help

![*Scientist Tech Help*](images/scientist_tech_help.png "Scientist Tech Help Cartoon")

## Objectives

- Building a mental model of Spark for a typical use case
- Understanding the associated code (Python and Java)
- Exploring the general architecture of a Spark application
- Understanding the flow of data

# Review

- What are the 4 steps involved in Data Engineering?
- What step is the Data Scientist generally focused on?
- What is a DataFrame?
- What 5 languages does Spark support out of the box?

## Typical Use Case

- We will walk through a scenario that involves distributed loading
  - A CSV file
  - a small operation
  - saving the results back to a database
  - PostgreSQL or Apache Derby
  - See Appendix F in the book for RDBMS installation help

## 2.1 Building a mental model

- How would we build an application to:
  - Ingest columns from a CSV file
  - Modify the data
  - Store the results to an RDBMS
  - You will need to install PostgreSQL (Pronounced Postgress) in your class Virtual Machine
    - `sudo apt-get update` then `sudo apt-get install postgresql`
  - In the `README.md` in the chapter 02 source code there is instruction on how to create the user and tables for this lab

## Figure 2-1

![*Figure 2.1*](images/figure2-1.png "Mental Model of typical Spark task")

## Installation of PostgreSQL

![*Create a Table in PostegreSQL*](images/postgresql.png "How to create a Table in PostegreSQL")

## Summary

- Summary goes here

## Next Steps

- Next steps here
