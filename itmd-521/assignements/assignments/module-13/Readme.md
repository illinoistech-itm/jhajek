# Module 13

This project you will apply your Data Engineering methods and strategies to accomplish queries across a cluster in optimal an fashion.

## Part One

Create a file named: `lab13p1.ipynb` under the directory `labs` > `module-13` in your private repo. The Notebook will read your 1960s **cleaned parquet decade** file from Minio.

This part you will do some basic analytics using the the native PySpark libraries on this DataFrame.

You will write out a series of csv (uncompressed) files using the `coalesce(1)` or `.repartition` functions to make them a single partition for the results of the following queries.

Using date ranges, select all records for the month of February for each year in the decade, find the following: You may have to add filters to remove records that have values that are legal but not real -- such as 9999 or anything too low for humans to live. You will have to construct a schema for writing the results. You may want to make use of temp tables to keep smaller sets of data in memory. You will need to write out the results to a different object but can use one `.ipynb` file.

* Count the number of records total
  * `countp1.csv`
* Average air temperature for month of February for each year
  * `tempp1.csv`
* Median air temperature for month of February for each year
  * `medianp1.csv`
* Standard Deviation of air temperature for month of February for each year
  * `stddevp1.csv`
* Find AVG air temperature per StationID in the month of February for each year
  * `perstationairtempp1.csv`

## Part Two

Create a file named: `lab13p2.ipynb` under the directory `labs` > `module-13`. You will repeat the above requirements using two of your cleaned datasets, 50 and 60. Combine both DataFrames into a single DataFrame for analytics -- look at using any optimization techniques, such as temp tables, that we have discussed this semester.  Adjust the .csv output names to `p2` in place of the `pl` postfix.

## Deliverable

Submit the URL to your `module-13` folder in GitHub.
