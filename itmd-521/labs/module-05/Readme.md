# Module-05 Lab

## Objectives

- Demonstrate the knowledge of constructing end-to-end DataFrame and Dataset Spark applications
- Demonstrate working code and knowledge of statistics
- Understand and utilize Pyspark API Documentation

## Assignment Setup

- We will be working the LearningSpark book chapter 3 starting on page 54/78 printed page/pdf
- Use the file `sf-fire-calls.csv` from the sample code
- Write a Pyspark application that answers the seven questions on Page 68/92 (printed page/pdf) of the Text Book under the header **End-to-End DataFrame Examples** 
- Databricks has released the textbook as a free online version
  - [https://pages.databricks.com/rs/094-YMS-629/images/LearningSpark2.0.pdf](https://pages.databricks.com/rs/094-YMS-629/images/LearningSpark2.0.pdf "web page free databricks version of learning spark) 
  - **Note** do not use the notebook file provided, we want to challenge you to be able to build this yourself

## Assignment Details - Part I

- Create a Pyspark application named: `module-05.py`
  - In that application code add seven comments (# pound sign) that type out the questions from the text book
  - The schema is provided in the textbook on the preceding pages
  - Provide code to answer the questions below each header
  - You can provide a single "read" of the source code at the top of the file into a DataFrame -- each question does not require a read()
  - Run the source code via Spark-Submit on your Vagrant Box
  - Sample code is available in the book LearningSparkV2 sample code
    - `~/LearningSparkV2/databricks-datasets/learning-spark-v2/sf-fire-calls.csv`
    - Like the MnMcount code -- take the dataset input as a commandline variable
    - Do not hardcode the dataset
  - Make sure to commit and push code to GitHub continually 
    - Assignments that have the entire code submitted with none or little commit history will not be accepted
    - Commit and push often.
  - Don't share the answers with others! Your work is individual.

### Deliverable

Create a sub-folder under `labs` named: `module-05` under the `itmd-521` folder. Place all deliverables there. But not the dataset.

Submit to Canvas the URL to the folder in your GitHub repo. I will clone your code and run it to test the functionality. I don't need the datasets as I will have them already.
