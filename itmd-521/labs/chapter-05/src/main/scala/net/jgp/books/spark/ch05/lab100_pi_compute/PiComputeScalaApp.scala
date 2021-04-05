package net.jgp.books.spark.ch05.lab100_pi_compute

import java.util.ArrayList
import org.apache.spark.api.java.function.{MapFunction, ReduceFunction}
import org.apache.spark.sql.{Encoders, Row, SparkSession}

/**
  * Computes Pi.
  *
  * @author rambabu.posa
  */
object PiComputeScalaApp {

  private var counter = 0

  /**
    * Mapper class, creates the map of dots
    *
    * @author rambabu.posa
    */
  @SerialVersionUID(38446L)
  final private class DartMapper extends MapFunction[Row, Integer] {
    @throws[Exception]
    override def call(r: Row): Integer = {
      val x = Math.random * 2 - 1
      val y = Math.random * 2 - 1
      counter += 1
      if (counter % 100000 == 0)
        println("" + counter + " darts thrown so far")
      if (x * x + y * y <= 1) 1
      else 0
    }
  }

  /**
    * Reducer class, reduces the map of dots
    *
    * @author rambabu.posa
    */
  @SerialVersionUID(12859L)
  final private class DartReducer extends ReduceFunction[Integer] {
    override def call(x: Integer, y: Integer): Integer = x + y
  }

  /**
    * main() is your entry point to the application.
    *
    * @param args
    */
  def main(args: Array[String]): Unit = {

    val slices = 10
    val numberOfThrows = 100000 * slices
    println("About to throw " + numberOfThrows + " darts, ready? Stay away from the target!")

    val t0 = System.currentTimeMillis
    val spark = SparkSession.builder
                            .appName("Spark Pi")
                            .master("local[*]")
                            .getOrCreate

    val t1 = System.currentTimeMillis
    println("Session initialized in " + (t1 - t0) + " ms")

    val numList = new ArrayList[Integer](numberOfThrows)

    // For  Spark Encoder implicits
    import spark.implicits._

    for(i <- 1.to(numberOfThrows))
      numList.add(i)

    val incrementalDf = spark.createDataset(numList).toDF

    val t2 = System.currentTimeMillis
    println("Initial dataframe built in " + (t2 - t1) + " ms")

    val dartsDs = incrementalDf.map(new DartMapper, Encoders.INT)

    val t3 = System.currentTimeMillis
    println("Throwing darts done in " + (t3 - t2) + " ms")

    val dartsInCircle = dartsDs.reduce(new DartReducer)
    val t4 = System.currentTimeMillis
    println("Analyzing result in " + (t4 - t3) + " ms")

    println("Pi is roughly " + 4.0 * dartsInCircle / numberOfThrows)

    spark.stop()

  }

}
