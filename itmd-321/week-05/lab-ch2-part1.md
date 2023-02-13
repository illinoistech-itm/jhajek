# Lab - Chapter 02

Lab exercise covering week-05 chapter 02 - part I.

## Objectives

* Analyze requirements for creating relational database tables from business requirements
* Discuss logic and methodology for creating relationships between tables

## Outcomes

At the conclusion of this assignment you will have taken business requirements and created a relational model to accurately represent the business requirements.

## Lab Exercises

Using Chapter 2 (P. 124 in the Kindle Book) Titled: `Working with Microsoft Access`, we will be creating the database and the relationships, keys, and constraints mentioned in the exercise using MySQL.

Using the MySQL workbench and with your Ubuntu Jammy Linux box turned on, connect via the MySQL Workbench and you will begin to create the Database, or Schema, the tables, the keys, relations, and constraints.

Create a schema named: `WP`

Create the tables with the proper relations as follows.

* DEPARTMENT (<ins>DepartmentName</ins>), BudgetCode, OfficeNumber,  DepartmentPhone)  
* EMPLOYEE (<ins>EmployeeNumber</ins>, FirstName, LastName, *Department*, Position,  Supervisor, OfficePhone, EmailAddress)  
* PROJECT (<ins>ProjectID</ins>, ProjectName, *Department*, MaxHours, StartDate, EndDate)  
* ASSIGNMENT (*<ins>ProjectID</ins>*, *<ins>EmployeeNumber</ins>*, HoursWorked)  

Create the proper relations, tables, primary and foreign keys, and constraints based on the above syntax.

Use the book Figures 2.27, 2.29, and 2.31 for the schmeas of each table.

Use the book Figures for 2.28 and 2.30 for inserting WP PROJECT Table data and WP DEPARTMENT Table data. Reference the live demo from 02/06 Blackboard Recording near the end of class.

From the `Administration` Tab in MySQL workbench, select `Export Data` and select `Export to Self-Contained File` 
 
Final deliverable - export the entire database to an SQL file and place that file into week-05 directory. 

Kroenke, David M.; Auer, David J.; Vandenberg, Scott L.; Vandenberg, Scott L.; Yoder, Robert C.; Yoder, Robert C.. Database Concepts (p. 124). Pearson Education. Kindle Edition. 