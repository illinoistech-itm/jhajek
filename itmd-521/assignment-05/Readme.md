# Assignment 05

## Objectives

- Explore the use of High-Order Functions in Spark SQL
- Explore common DataFrame and SQL Operations
- Create full Spark Applications to accomplish our exploration via the JDBC drivers
- Understand the story of [Little Bobby Tables](https://xkcd.com/327/ "Bobby Tables Cartoon")

## Assignment Setup

On the command line run this `.sql` file to create another database and table with the requisite temperature data. Import this via the command: `sudo mysql < create-database-and-table.sql`.

Then run the command: `sudo mysql < insert-records.sql`

This assignment will require you to create either a Scala or Python application you will run via `spark-submit`, named: `assignment-05.py` or `assignment-05.scala`.

You will need to use the MySQL connector from the previous assignment

- [PySpark JDBC DataReader Documentation](https://spark.apache.org/docs/latest/api/python/reference/api/pyspark.sql.DataFrameReader.jdbc.html "PySpark JDBC DataReader Documentation")
- [DataFrameWriter JDBC API docs](https://spark.apache.org/docs/latest/api/python/reference/api/pyspark.sql.DataFrameWriter.format.html?highlight=format#pyspark.sql.DataFrameWriter.format "DataFrameWriter JDBC API docs")
- [Data Frame Reader JDBC API Docs](https://spark.apache.org/docs/latest/api/python/reference/api/pyspark.sql.DataFrameReader.jdbc.html "Data Frame Reader JDBC API Docs")

## Assignment Details - Part I

- You will create a PySpark application named: `assignment-05.py` or `assignment-05.scala`
  - Create a DataFrame to read the content of the Assignment05 SQL table you just created
  - Create a second DataFrame to select the content of the Assignment05b table you just created
  - Issue a `.show()` to display the content of each DataFrame
  - Create tempViews for each DataFrame and issue a Union() command to join both DataFrames into one
  - Issue the command: `.show()` to display this new unioned content
  - Issue a filter command to find all temperatures above 40 Celsius and create a new column called 'high'.  Use a `.show()` to display the content
  - Using the `reduce()` function to calculate the average Fahrenheit temperature for our datasets -- based on page 144.

## Assignment Details - Part II

- Using the sample code on page 144/145 add this to your spark application to load the sample flight data
- Type up the Joins example from page 148/149 and display the same results as shown in the book

## Assignment Details - Part III

- Follow the example code on page page 152/153 produce the same results as shown for:
  - Add new columns
  - Dropping columns
  - Renaming columns
  - Pivoting

## Final notes

Run the application with the command: `spark-submit --jars ~/spark/jars/mysql-connector-java-8.0.28.jar assignment-05.py`.  You can assume that I have the database and tables already loaded when I run your code.

### Deliverable

- Make sure you have the proper imports, be careful of grabbing extra or uneeded imports
- Once you have the answers, add it via a commit back to your source GitHub repo
- Make sure to commit and push code to GitHub continually.  Assignments that have the entire code submitted with none or little commit history will not be accepted.  Commit and push often.
- Don't share the answers with others.  Your work is individual.

Submit to Blackboard the URL to the folder in your GitHub repo.  I will clone your code and run it to test the functionality.

Due at the **Start of class** March 10th 8:30 am
