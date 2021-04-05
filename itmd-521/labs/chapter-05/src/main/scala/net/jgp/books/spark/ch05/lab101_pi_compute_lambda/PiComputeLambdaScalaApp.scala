package net.jgp.books.spark.ch05.lab101_pi_compute_lambda

import java.util.ArrayList
import org.apache.spark.sql.SparkSession

/**
  * Computes Pi.
  *
  * @author rambabu.posa
  */
object PiComputeLambdaScalaApp {
  private var counter:Int = 0

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
      .appName("Spark Pi with Anonymous Functions")
      .master("local[*]")
      .getOrCreate

    val t1 = System.currentTimeMillis
    println("Session initialized in " + (t1 - t0) + " ms")

    val numList = new ArrayList[Integer](numberOfThrows)

    // For  Spark Encoder implicits
    import spark.implicits._

    for (i <- 1.to(numberOfThrows))
      numList.add(i)

    val incrementalDf = spark.createDataset(numList).toDF

    val t2 = System.currentTimeMillis
    println("Initial dataframe built in " + (t2 - t1) + " ms")

    val dotsDs = incrementalDf.map(_ => {
      val x:Double = Math.random * 2 - 1
      val y:Double = Math.random * 2 - 1
      counter += 1
      if (counter % 100000 == 0)
        println("" + counter + " darts thrown so far")
      if (x * x + y * y <= 1) 1
      else 0
    })

    val t3 = System.currentTimeMillis
    println("Throwing darts done in " + (t3 - t2) + " ms")

    val dartsInCircle = dotsDs.reduce((x, y) => x + y)
    val t4 = System.currentTimeMillis
    println("Analyzing result in " + (t4 - t3) + " ms")

    println("Pi is roughly " + 4.0 * dartsInCircle / numberOfThrows)

    spark.stop()

  }
}