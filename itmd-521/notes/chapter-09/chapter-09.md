% Spark the Definitive Guide 2nd Edition
% Chapter 09
% Data Sources

# Data Sources

## Text Book

![*itmd-521 textbook*](images/spark-book.png "Spark TextBook")

## Objectives and Outcomes

- Introduce and understand the 6 core data sources available to Spark
- Introduce and understand community-created data sources for Spark (3rd Party)
- Introduce and understand the ability to read and write to these 6 core data sources
- Understand tooling needed to configure Virtual Machines for Remote Cluster access via VPN

## What to do with data

- The goal of this chapter is to give you the ability to read and write from Spark's core data sources and know enough to understand what you should look for in a data type.
  
## Six Core Data Sources (1-3)

- [CSV](https://en.wikipedia.org/wiki/Comma-separated_values "CSV Wikipedia Page Link")
  - A comma-separated values (CSV) file is a delimited text file that uses a comma to separate values.
- [JSON](https://www.json.org/json-en.html "JSON.org website")
  - JSON (JavaScript Object Notation) is a lightweight data-interchange format. It is easy for humans to read and write. It is easy for machines to parse and generate. It is based on a subset of the JavaScript Programming Language Standard ECMA-262 3rd Edition - December 1999. JSON is a text format that is completely language independent but uses conventions that are familiar to programmers
- [Parquet](http://parquet.apache.org/documentation/latest/ "Parquet file format description web page")
  - Apache Parquet is a columnar storage format available to any project in the Hadoop ecosystem, regardless of the choice of data processing framework, data model or programming language.
  - [Columnar Storage](http://en.wikipedia.org/wiki/Column-oriented_DBMS "columnar storage")

## Six Core Data Sources Continued (4-6)

- [ORC](https://orc.apache.org/ "Apache ORC project page")
  - The smallest, fastest columnar storage for Hadoop workloads.
- [JDBC/ODBC](https://en.wikipedia.org/wiki/Open_Database_Connectivity "ODBC wikipedia description page")
  - Open Database Connectivity (ODBC) is a standard application programming interface (API) for accessing database management systems (DBMS)
- Plain-Text files
  - Simplest and most universal data format, also the slowest and most inefficient.

## Additional Community Data Sources

- [Cassandra](https://cassandra.apache.org "Cassandra introduction webpage")
  - The Apache Cassandra database is the right choice when you need scalability and high availability without compromising performance. Linear scalability and proven fault-tolerance on commodity hardware or cloud infrastructure make it the perfect platform for mission-critical data. Cassandra's support for replicating across multiple datacenters is best-in-class, providing lower latency for your users and the peace of mind of knowing that you can survive regional outages.
- Google Spreadsheets
  - [spark google spreadsheets](https://spark-packages.org/package/potix2/spark-google-spreadsheets "Package to connect Spark to Google spreadsheets")
- [MongoDB](https://www.mongodb.com/ "MongoDB company website")
  - MongoDB is a general purpose, document-based, distributed database built for modern application developers and for the cloud era.
  - [mongo-spark package](https://spark-packages.org/package/mongodb/mongo-spark "Spark Package for MongoDB")
- [AWS Redshift](https://aws.amazon.com/redshift/ "AWS Redshift description website")
  - AWS Enterprise grade Data Warehouse project
  - [spark-redshift package](https://spark-packages.org/?q=Redshift "Spark Redshift third party package link")
- XML
  - Yes it exists.

## Conclusion

- We walked through...

## Questions

- Any questions?
- Read Chapter 15 & 16 and do any exercises in the book.
