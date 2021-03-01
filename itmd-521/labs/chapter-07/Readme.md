# ITMD-521 IT-D 872 Chapter-07 Lab

You will copy this template file to your own private GitHub repo provided.  Under your itmd-521 folder you will create a sub-folder named: **labs**.  Under that folder create a sub-folder named: **chapter-03**.  In that folder place this Readme.md

## Objectives

- Demonstrate creating dataframe from various file formats
- Demonstrate the advantages of "BigData" data types vs conventional text based types
- Discuss the the application of compression and its advantages in dealing with large files

## Your name goes here

### Lab

You will write one Spark application, in Java or Python that will load the sample data given from the NCDC for the decade of 1920s:

1) Parquet file (they are compressed by default)
1) Singleline lz4 compressed json
1) Singleline snappy compressed json
1) CSV snappy compressed
1) Json multiline (located in data directory, named 20m.json)
1) CSV non-compressed

For each of the six actions listed, in your program you will need to:

- Print the screen which item you are printing
- Print the schema for each dataframe
- Print the count and display the the number of records for each dataframe

#### Lab Screenshot

Place screenshot of a successful execution output of the results here:

#### Building Instructions

Place and instructions or assumptions needed to run your code and repeat the results here

### Deliverable

In your private repo you push the single Java or Python file you have written, and the sample data, and this Readme.md file to the directory under your private GitHub repo: labs > chapter-07.  

Submit the URL to this page to Blackboard as your deliverable
