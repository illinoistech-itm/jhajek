# Assignment 04

## Objectives

- Configure the MySQL connecter/J plugin for use with Spark
- Understand how Spark interacts with RDBMS via JDBC
- Understand the process to read and write database tables via Spark
- Explore how to convert SQL tables to different file formats
- Understand the story of [Little Bobby Tables](https://xkcd.com/327/ "Bobby Tables Cartoon")

## Assignment Setup

This assignment will require the MySQL server you installed on your Vagrant Box. There are additional items needed:

- Clone the sample Employee database repository
  - `git clone git@github.com:datacharmer/test_db.git`
- Import the employees.sql file to build the database, tables, and insert the sample data
  - `sudo mysql < employees.sql`
  - Import the provided `create-user.sql` script as well to create a non-root user
- Retrieve the latest JDBC driver for MySQL `8.0.x.jar` and add it to your `~/spark/jars` directory
- The database contains about 300,000 employee records with 2.8 million salary entries.

You will make extensive use of the textbook and these documentation pages -- **avoid** the internet as your first option and instead go to the API Documentation.

- [PySpark JDBC DataReader Documentation](https://spark.apache.org/docs/latest/api/python/reference/pyspark.sql/api/pyspark.sql.DataFrameReader.jdbc.html "PySpark JDBC DataReader Documentation")
- [DataFrameWriter JDBC API docs](https://spark.apache.org/docs/latest/api/python/reference/pyspark.sql/api/pyspark.sql.DataFrameWriter.jdbc.html "DataFrameWriter JDBC API docs")

## Assignment Details - Part I

- You will create a PySpark application named: `assignment_04.py`
  - Read the `employees` table into a DataFrame
  - Display the count of the number of records in the DF
  - Display the schema of the Employees Table from the DF
- Create a DataFrame of the top 10,000 employee salaries (sort DESC) from the `salaries` table
  - Write the DataFrame back to database to a new table called: `aces`
- Write the DataFrame out to the local system as a CSV and save it to local system using snappy compression (see the CSV chart in Chapter 04)
- Use Native Pyspark file methods

## Assignment Details - Part II

- Create a `JDBC` read without using the `dbtables` option, instead use a query directly to select from the `titles` table where employees title equals `Senior Engineer`
  - Create a PySpark query to add to the prior step's DataFrame a temp column stating if the senior engineer employee is still with the company (to_date = 9999-01-01) and has left (to_date value will be less than today's date)
  - Use the values: current || left
- Issue a count of how many senior engineers have left and how many are current
- Create a PySpark SQL table of just the Senior Engineers information that have left the company
- Create a PySpark SQL tempView of just the Senior Engineers information that have left the company
- Create a PySpark DataFrame of just the Senior Engineers information that have left the company
  - Write each of the three prior options back to the database using the DataFrame Writer (save) function creating a table named: ~~`left-table`~~ `left_table`, ~~`left-tempview`~~ `left_tempview`, and ~~`left-df`~~ `left_df` respectively
- Repeat the previous command that writes the DataFrame to the database, but set the mode type to `errorifexists` -- take a screenshot of the error message generated and place it here

## Assignment Details - Part III

- Connect to Mariadb CLI from the Linux CLI (not from PySpark)
  - Issue the SQL commands to display the description of the tables created in Part II to show that the data has been written back to the database.  Take a screenshot of the output of the SQL DESCRIBE command
  - `aces`
  - ~~`left-table`~~ `left_table`
  - ~~`left-tempview`~~ `left_tempview`
  - ~~`left-df`~~ `left_df`

Example will look something like this:

```mysql

MariaDB [employees]> describe employees;
+------------+---------------+------+-----+---------+-------+
| Field      | Type          | Null | Key | Default | Extra |
+------------+---------------+------+-----+---------+-------+
| emp_no     | int(11)       | NO   | PRI | NULL    |       |
| birth_date | date          | NO   |     | NULL    |       |
| first_name | varchar(14)   | NO   |     | NULL    |       |
| last_name  | varchar(16)   | NO   |     | NULL    |       |
| gender     | enum('M','F') | NO   |     | NULL    |       |
| hire_date  | date          | NO   |     | NULL    |       |
+------------+---------------+------+-----+---------+-------+
6 rows in set (0.009 sec)
```

## Final notes

Run the application with the command: `spark-submit --jars ~/spark/jars/mysql-connector-java-8.3.0.jar assignment_04.py ....`. You can assume that I have the database and tables already loaded when I run your code.

### Deliverable

Create a sub-folder named: `labs` > `week-09` under the `itmd-521` folder. Place all deliverables there.
Submit to Blackboard the URL to the folder in your GitHub repo.  I will clone your code and run it to test the functionality. I don't need the datasets as I will have them already.

- Make sure you have the proper imports, be careful of grabbing extra or uneeded imports
- Once you have the answers, add it via a commit back to your source GitHub repo
- Make sure to commit and push code to GitHub continually.  Assignments that have the entire code submitted with none or little commit history will not be accepted.  Commit and push often.
- Don't share the answers with others.  Your work is individual.

Submit to Blackboard the URL to the folder in your GitHub repo.  I will clone your code and run it to test the functionality.

#### Section 05

Due at the **Start of class** March 20th 1:50 pm

#### Section 01, 02, 03

Due at the **Start of class** March 21st 3:15 pm
