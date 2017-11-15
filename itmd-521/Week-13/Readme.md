# Week-13 Cluster Assignment

## Notes

For test 4-15 You will need to recompile your **MaxTemperature** driver class and JAR to modify the following: ```job.setNumReduceTasks(X)``` and set ``` job.setJobName("Max temperature");``` to include your initials:  ```job.setJobName("MT test 1 jrh");```
For test 4-6 You will need modify your MaxTemperature code to account for bad records use the sample code on P.174 of textbook *section 6-12* to include a counter that will output the number of bad records at the end of the job -- place this new code and jar file in  Week-13 -> badrecord folder (include just 1 sample)

MaxTemperature 1999.txt  recompile mt.jar changing job.setJobName name to add your initials 
For Test 1-3
* A-E 1999.txt
* F-N 1991.txt
* O-Z 1994.txt

##  Test 1

* Without combiner, without intermediate compression, and 1 reducers
* Without combiner, without intermediate compression, and 2 reducers
* Without combiner, without intermediate compression, and 4 reducers
* Without combiner, without intermediate compression, and 8 reducers

![*Item 1 Results*](../images/bar-graph2.png "bar graph")

### Answer
Your explanation of the reults of the above graph goes here.  This explanation tells in detail why there are increase or decrease in execution times -- and invovles information from the textbook (not the web or Google) including with page or ebook section citations.   

---

## Test 2

* With combiner, with intermediate compression, and 1 reducers
* With combiner, with intermediate compression, and 2 reducers
* With combiner, with intermediate compression, and 4 reducers
* With combiner, with intermediate compression, and 8 reducers

*Chart goes here*

### Answer
Your explanation of the reults of the above graph goes here.  This explanation tells in detail why there are increase or decrease in execution times -- and invovles information from the textbook (not the web or Google) including with page or ebook section citations.   

---

## Test 3

* With combiner, without intermediate compression, and 1 reducers
* With combiner, without intermediate compression, and 2 reducers
* With combiner, without intermediate compression, and 4 reducers
* With combiner, without intermediate compression, and 8 reducers

*Chart goes here*

### Answer
Your explanation of the reults of the above graph goes here.  This explanation tells in detail why there are increase or decrease in execution times -- and invovles information from the textbook (not the web or Google) including with page or ebook section citations.   

---

## Test 4 

* Repeat test 1 using the datasets located in: ```/user/ncdc/80/``` (Lastname A-K) and  ```/user/ncdc/90/``` (Lastname L-Z) 
* For test 4-6 You will need modify your MaxTemperature code to account for bad records use the sample code on P.174 of textbook *section 6-12* to include a counter that will output the number of bad records at the end of the job -- place this new code and jar file in  Week-13 -> badrecord folder 

---

## Test 5

* Repeat test 2 using the datasets located in: ```/user/ncdc/80/``` (Lastname A-K) and  ```/user/ncdc/90/``` (Lastname L-Z) 
* For test 4-6 You will need modify your MaxTemperature code to account for bad records use the sample code on P.174 of textbook *section 6-12* to include a counter that will output the number of bad records at the end of the job -- place this new code and jar file in  Week-13 -> badrecord folder 

---

## Test 6

* Repeat test 3 using the datasets located in: ```/user/ncdc/80/``` (Lastname A-K) and  ```/user/ncdc/90/``` (Lastname L-Z) 
* For test 4-6 You will need modify your MaxTemperature code to account for bad records use the sample code on P.174 of textbook *section 6-12* to include a counter that will output the number of bad records at the end of the job -- place this new code and jar file in  Week-13 -> badrecord folder 

---

## Test 7 

* Repeat test 1 using the datasets located in: ```/user/ncdc/80-90/```  (ALL students)

---

## Test 8

* Repeat test 2 using the datasets located in: ```/user/ncdc/80-90/```  (ALL students)

---

## Test 9 

* Repeat test 3 using the datasets located in: ```/user/ncdc/80-90/```  (ALL students)

---

## Test 10 

* Repeat test 1 using the dataset and the ```/user/ncdc/256/80-90/``` datasets (ALL students)
   + This increases the default Block Size to 256 mb

---

## Test 11 

* Repeat test 2 using the dataset and the ```/user/ncdc/256/80-90/``` datasets (ALL students)
   + This increases the default Block Size to 256 mb

---

## Test 12

* Repeat test 3 using the dataset and the ```/user/ncdc/256/80-90/``` datasets (ALL students)
   + This increases the default Block Size to 256 mb


---

## Test 13

* Repeat test 1 using the dataset and the ```/user/ncdc/512/80-90/``` datasets (ALL students)
   + This increases the default Block Size to 512 mb

--- 

## Test 14

* Repeat test 2 using the dataset and the ```/user/ncdc/512/80-90/``` datasets (ALL students)
   + This increases the default Block Size to 512 mb

---

## Test 15

* Repeat test 3 using the dataset and the ```/user/ncdc/512/80-90/``` datasets (ALL students)
   + This increases the default Block Size to 512 mb

---

## Conclusion

Write your general conclusion and recommendation for the optimal performance characteristics relating to **intermediate compression**, **compression**, **combiners**, **block size**, and **number of reducers** based on this work load and dataset results (reference your test results above).

