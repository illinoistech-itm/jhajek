% Spark the Definitive Guide 2nd Edition
% Chapter 16
% Developing Spark Applications

# Developing Spark Applications

## Text Book

![*itmd-521 textbook*](images/spark-book.png "Spark TextBook")

## Objectives and Outcomes

- Learn and understand how to develop a stand alone Spark Application
- Learn and understand how to deploy a stand alone Spark Application on a cluster
- Understand how to use a Spark Template
- Understand how to structure your Spark application
- Focus on writing Python applications

## Writing a Python Application 227

- Writing Cluster apps is the same as writing a normal Python application
- [YARN cluster options](https://spark.apache.org/docs/latest/running-on-yarn.html "YARN cluster options")
  - ```spark-submit --class org.apache.spark.examples.SparkPi --master yarn --deploy-mode cluster --driver-memory 4g --executor-memory 2g --executor-cores 1  --queue thequeue $SPARK_HOME/examples/jars/spark-examples*.jar 10```{.python}
  - driver memory
    - How much memory the executor process is allowed to consume - default is 512m
  - num-executors
    - the default number is 2
  - executor-memory
    - How much memory the executor process is allowed to consume - default is 1G
  - driver-cores
    - Number of CPU cores dedicated to the driver process
    - 1 by default
  - executor-cores
    - Default 1 one CPU core in YARN mode
    - All cores if in Local mode
  - queue
    - name of the queue to submit to on YARN
    - This can be important if there is resource scheduling turned on by default

## Configure Properties

- All options can be defined in a configuration file is $SPARK_HOME/conf
  - These values will be read and processed at run time, no need to declare them
- Properties can be declared in the code
- Properties can be declared dynamically at runtime by declaring on the command line
- For a cluster you can set machine specific values by configuring the conf files of each node
  - Lets take a look at the sample conf files located in your $SPARK_HOME directory

## Conclusion

- We covered how to compile a Python Spark application
- We covered applciation, Spark, and environment variables for execution on the cluster

## Questions

- Any questions?
- See Second Advanced tooling documentation
