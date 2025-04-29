# Lab-06

For ITMD 521, Big Data Technologies, module-08, lab-06

## Objectives

* Video record your learnings from the lab
* Answer the questions to explain your work briefly

## Outcomes

* At the completion of this video recording part of Lab 01, you will have compiled a significant Spark application with an explanation of how the code works. You will have translated Pyspark code to SQl and English explaining what a query accomplishes.

## Pre-reqs

For this portion of the assignment you will need to have software installed on your computer to be able to screen record, record audio, and record your web cam to produce and explanation video for your homework submission. The recommended software is [OBS Studio](https://obsproject.com/download "webpage for OBS Project") which is used by many podcasters and streamers to produce videos. As long as you can meet all three requirements for this portion, you are free to use other software.

## Deliverable Requirements

Upon completing the lab, record a video not less than 2 minutes and not more than 5, to explain your work and output based on the questions listed below. Upload the video to Canvas. Double check your video before uploading to see if the audio and screen recording is done correctly.

* Make sure to introduce yourself and tell us which section you are in (briefly)
* Do not read a prepared statement (we can see the reflection of the document in your eyes as they move across the screen.)
* Demonstrate and explain the code that answers the question posed
  * Have the answers ready -- no need to run the code in the video
  * In addition in part two briefly explain the answer to this question: Explain the difference between an managed and unmanaged table in your own words

### Question

Explain what each of these three lines in this query from the example demo code accomplished and why.

```python
# How to hold output even after the Jupytr Hub web page closes
### If the job submitted takes some time to run we can generally use nohup to redirect the output without having us to keep the ssh session alive. As, we are not submitting the job's via terminal there is no way to use no hup directly. To get around this issue, we will use `%%capture` magic to capture the output.

### Run the below code in a new cell. `%%capture myapp` has been added in the first line. (Replace `myapp` with a better name.)

%%capture myapp
avg_df = splitDF.select(month(col('ObservationDate')).alias('Month'),year(col('ObservationDate')).alias('Year'),col('AirTemperature').alias('Temperature'))\
             .groupBy('Month','Year').agg(avg('Temperature'),stddev('Temperature')).orderBy('Year','Month')

avg_df.show(10)
```
