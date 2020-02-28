% Spark the Definitive Guide 2nd Edition
% Chapter 07
% Aggregations

# Aggregations

## Text Book

![*itmd-521 textbook*](images/spark-book.png "Spark TextBook")

## Objectives and Outcomes

- Aggregating is the act of collecting something together
  - It is the cornerstone of big data analytics
- You specify a *key* or *grouping* and an *aggregation function*
  - This function specifies how you should transform one or more columns
- Spark allows us to create the following types of groupings:
  - A *"group by"* specifies one or more keys and one or more aggregations
  - A *"window"* specifies one or more keys and one or more aggregations to transform the value columns
  - A *"grouping set"* specifies you can use aggregations at multiple levels
  - A *"rollup"* specifies one or more keys as well as one or more aggregation functions to transform the value of a column
  - A *"cube"* specifies one or more keys as well as one or more aggregations to transform the value columns

## Review

- So far:
  - We learned how to build expressions using typed data
  - We learned how to use:
  - Booleans
  - Numbers
  - Strings
  - Dates and Timestamps
  - Nulls
  - Complex and user types
  
## Basic Aggregations

- One of the simplest aggregations is `count()` which will count all rows in a DataFrame
  - ```df.count()```{.python}
  - `.count()` is technically an action not a transformation
- Elements of an entire column can be counted as well
  - ```from pyspark.sql.functions import count```{.python}
  - ```df.select(count("StockCode")).show()```{.python}
  - Watch out!  When counting all columns ("*") Spark will count `nulls`, even rows that are all `null`
  - When counting an individual column, Spark will not count `nulls`

## countDistinct

- Sometimes total number is not relevant, only unique number is
  - There is a ```.countDistinct()``` function
  - ```from pyspark.sql.functions import countDistinct```{.python}
  - ```df.select(countDistinct("StockCode")).show()```{.python}
- There is also an ```.approx_count_distinct()```{.python}
  - When working with a large dataset, time, processing power, even energy usage are a consideration
  - There are times when a degree of approximation can be used without an issue
  - ```from pyspark.sql.functions import approx_count_distinct```{.python}
  - ```df.select(approx_count_distinct("StockCode", 0.1)).show()```{.python}
  - ```SELECT approx_count_distinct(StockCode, 0.1) FROM dfTable```{.sql}
  - 0.1 is the estimation error margin
  - Note the results, but note the performance gain

## Simple Aggregations

- You can get the first and last elements of a DataFrame by two obvious elements
  - .first()
  - .last()
- You can extract min and max values using the builtin pyspark sql functions
- You can use the `sum` method to sum the content of a column
  - There is also a `sumDistinct` function that will perform that actions as well
- There is an `avg` function to do an average of a column
  - You can combine this result with an alias to reuse the calculated value later 107
- If you are calculating Average, then you are dealing with *Variance* and *Standard Deviation*
- *Skewness* and *kurtosis* are both measurements of extreme points in your data
  - Skewness measures the asymmetry of your values around the mean
  - Kurtosis measures the tail of data

## More Simple Aggregations

- Some functions compare the interactions of the values in two different columns together
  - *Covariance* and *Correlation*
  - `cov` and `corr`
  - Chapter 6 talked about the [Pearson correlation coefficient](https://en.wikipedia.org/wiki/Pearson_correlation_coefficient "Pearson Correlation coefficient wiki page")
  - Correlation is measured on a -1 to 1 scale
  - The covariance can be taken over a population sample or the entire population of records
  - Page 110


## Conclusion

- Conc goes here

## Questions

- Any questions?
- Read Chapter 08 & 09 and do any exercises in the book.
