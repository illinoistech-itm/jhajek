# Week 11 Lab and Questions

Week 11 lab and questions in a join document

## Objectives

* Demonstrate and explain the concepts of INNER JOINS
* Demonstrate and explain the concepts of WHERE clause queries

## Outcomes

At the conclusion of this lab and lecture you will have taken word problems and deciphered the correct SQL statements using JOINS and WHERE clauses to create the correct query and retrieve the correct data.

### Assignment

Using the 10 questions located in the `week-11-lab-and-questions.sql` file, answer them writing the correct SQL syntax and copy the output of the command into a multiline comment.

For example this would be an appropriate answer

```sql
-- What command will show the schema of the staff table?

DESCRIBE STAFF;

/*
+-------------+----------------------+------+-----+---------------------+-------------------------------+
| Field       | Type                 | Null | Key | Default             | Extra                         |
+-------------+----------------------+------+-----+---------------------+-------------------------------+
| staff_id    | tinyint(3) unsigned  | NO   | PRI | NULL                | auto_increment                |
| first_name  | varchar(45)          | NO   |     | NULL                |                               |
| last_name   | varchar(45)          | NO   |     | NULL                |                               |
| address_id  | smallint(5) unsigned | NO   | MUL | NULL                |                               |
| picture     | blob                 | YES  |     | NULL                |                               |
| email       | varchar(50)          | YES  |     | NULL                |                               |
| store_id    | tinyint(3) unsigned  | NO   | MUL | NULL                |                               |
| active      | tinyint(1)           | NO   |     | 1                   |                               |
| username    | varchar(16)          | NO   |     | NULL                |                               |
| password    | varchar(40)          | YES  |     | NULL                |                               |
| last_update | timestamp            | NO   |     | current_timestamp() | on update current_timestamp() |
+-------------+----------------------+------+-----+---------------------+-------------------------------+
11 rows in set (0.001 sec)
*/
```

### Deliverable

In your private repo for the class, under the `itmd-321` folder > `week-11` push all the changes to `week-11-lab-and-questions.sql`.  Note this must be valid SQL so run it on your own system first to check

Due Date: Wednesday April 5th 1:45 PM

Discord channel is open.