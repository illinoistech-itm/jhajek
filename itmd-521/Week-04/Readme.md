# ITMD 521 Spring 2018

## Week 4 assignment

Clone this repo to your system, add this file to a folder named Week-04 (mind the spelling) under ITMD-521 in your own private github repo

### Part I

1) Insert the assigned datasets below into your local hadoop cluster 
  + A-E 1987-half.txt
  + F-R 1988-half.txt
  + S-Z 1989-half.txt
1) Insert the data into this directory structure /user/$USER/ncdc/19XX/  (with XX being your year)
1) Compile the source code in chapter-02 of the text book sample code into a single jar file named: ```mt.jar```
  + Place all your scripts (but not the datafile!) into the Week-04 github folder
1) Run the MaxTemperature class against your dataset
1) Display the content of the part-r-00000  and capture that in a screenshot to be displayed below

### Part II

1) In your Vagrant box, install mysql-server and give it the password: **itmd521**
1) Install and configure the proper mysql-Java connector 
1) Write a script in Python to parse the dataset given you (using schemea in Chapter 02) and insert this data into a database named: **521** and a table named: **records**
  + Assume that the dataset.txt file is in the same directory as the script being executed
1) Write a Java Application that will perform the same funtionality as the MapReduce program to find the Max Temperature in SQL.
1) Provide a ReadMe.md in the Week-04 folder with all requirements, instructions, and assumptions 
  + We will run your code to see if the results are as delvivered.
  + Place all your scripts (but not the datafile!) into the Week-04 github folder
1) take a screenshot of the output 

### Deliverable 1

**Screenshot here**

### Devliverable 2

**ScreenShot here**

