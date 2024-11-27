# Module 11

This is the final project for ITMD-521.  This lab assumes that you have completed the sample lecture given on 11/26, refer to video for adjustments to needed to make to your sample code.

## Part One

Create one file named: `lab11p1.ipynb` under the directory `labs` > `module-11` in your private repo. The Notebook will read your 1950's cleaned parquet decade file from Minio and write it out to a JDBC table.

## Part Two

Create one file named: `lab11p2.ipynb` under the directory `labs` > `module-11` in your private repo.

This part you will do some basic analytics using the the native PySpark libraries. You will use two datasets, 60.json compressed from Minio and the 50 JDBC table. You will combine the two into a single DataFrame for analytics.

You will write out a series of csv (uncompressed) files using the `coalesce(1)` function to make them a single partition for the results of the following queries.

Using date ranges, select all records for the month of February for each year in the decade, find the following: You may have to add filters to remove records that have values that are legal but not real -- such as 9999 or anything too low for humans to live. You will have to construct a schema for writing the results. You may want to make use of temp tables to keep smaller sets of data in memory.

1) Count the number of records
1) Average air temperature for month of February 
1) Median air temperature for month of February
1) Standard Deviation of air temperature for month of February
1) Find AVG air temperature per StationID in the month of February

## Deliverable

Submit the URL to your `module-11` folder in GitHub.
