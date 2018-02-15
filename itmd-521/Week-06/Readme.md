# ITMD 521 Spring 2018

## Week 6 assignment

### Objectives 

* Learn to setup install and configure latest release of Sqoop 
* Learn to install and use the Mysql Connector/J platform 
* Configure and execute a Sqoop import command 
* Configure and run a combined Hadoop/Sqoop job  

### Outcomes 

At the conclusion of this lab you will have gained experience installing, configuring, and executing Sqoop on top of a Hadoop cluster.   You will understand the nature of Sqoop’s connection to mysql as well as how to create a combined Hadoop/Sqoop job to execute importing and analysis in a single command. 

### Part I

Assuming the completion of week 05 homework and a working Sqoop instance and the running of the sample code from chapter 15 MaxWidgitID.java.  You are to use the same syntax to create a Sqoop application that will run the Sqoop import and the MapReduce code in a single class.  

1) If your last name is A-K The single mode for widget name category 
1) If your last name L-Z The average price for each widget 
1) Place a screenshot of the results (using the year you were assigned) in deliverable 1.

### Part II 



### Deliverable Instructions

 

### Deliverable 1



### Deliverable 2




ITMD 521 – Week 11 Sqoop Assignment 
Objectives • Learn to setup install and configure latest release of Sqoop • Learn to install and use the Mysql Connector/J platform • Configure and execute a Sqoop import command • Configure and run a combined Hadoop/Sqoop job  
Outcomes 
  At the conclusion of this lab you will have gained experience installing, configuring, and executing Sqoop on top of a Hadoop cluster.   You will understand the nature of Sqoop’s connection to mysql as well as how to create a combined Hadoop/Sqoop job to execute importing and analysis in a single command. 
Background 
 Using Chapter 15 of the book, you must create and follow the examples given and generate the same result.  Create a folder named Week-11 in your Github account and include all necessary code and ReadMe.md to explain how to run the application.  Use root and password itmd521 for mysql. 
Deliverable 
1. (Assume the mysql database is already installed with username root and password itmd521) a. Create a .sql script named create.sql that will create the database hadoopguide, table widgets, and follow the schema given in the book. 2. Include a script named step-3.*  step-2.* that will generate 5000 records (based on the 4 sample items given in the text) and INSERT this into the widgets table. 3. Include a shell script named: step-3.sh that will execute the Sqoop import as given by the text book 4. Repeat step 3 - Include a shell script named step-4.sh that only import record 1000-3000 for an sqoop import 5. Run the MaxWidgetID.java file as detailed under the heading “Working with Imported data”  a.  Place this result into your ReadMe.md file 6. Modify the MaxWidgetID.java file to find a. If your last name is A-K The single mode for widget name category b. If your last name L-Z The average price for each widget i. Place the results and output file in your ReadMe.md file ii. Include the part-r-00000 file in your Github folder 
Grading 
Item 6 is worth 10 points (all or nothing) 
2 points each for each of the remaining items 
Due Date:  Saturday November 11th