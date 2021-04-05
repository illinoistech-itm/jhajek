package net.jgp.books.spark.ch05.lab200_pi_compute_cluster;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import org.apache.spark.api.java.function.MapFunction;
import org.apache.spark.api.java.function.ReduceFunction;
import org.apache.spark.sql.Dataset;
import org.apache.spark.sql.Encoders;
import org.apache.spark.sql.Row;
import org.apache.spark.sql.SparkSession;

/**
 * Compute Pi on a cluster.
 * 
 * It is not recommended to run this application from the IDE.
 * 
 * @author jgp
 */
public class PiComputeClusterApp implements Serializable {
  private static final long serialVersionUID = -1546L;
  private static long counter = 0;

  /**
   * Mapper class, creates the map of dots
   * 
   * @author jgp
   */
  private final class DartMapper
      implements MapFunction<Row, Integer> {
    private static final long serialVersionUID = 38446L;

    @Override
    public Integer call(Row r) throws Exception {
      double x = Math.random() * 2 - 1;
      double y = Math.random() * 2 - 1;
      counter++;
      if (counter % 1000 == 0) {
        System.out.println("" + counter + " operations done so far");
      }
      return (x * x + y * y <= 1) ? 1 : 0;
    }
  }

  /**
   * Reducer class, reduces the map of dots
   * 
   * @author jgp
   */
  private final class DartReducer implements ReduceFunction<Integer> {
    private static final long serialVersionUID = 12859L;

    @Override
    public Integer call(Integer x, Integer y) {
      return x + y;
    }
  }

  /**
   * main() is your entry point to the application.
   * 
   * @param args
   */
  public static void main(String[] args) {
    PiComputeClusterApp app = new PiComputeClusterApp();
    app.start(10);
  }

  /**
   * The processing code.
   */
  private void start(int slices) {
    int numberOfThrows = 100000 * slices;
    System.out.println("About to throw " + numberOfThrows
        + " darts, ready? Stay away from the target!");

    long t0 = System.currentTimeMillis();
    SparkSession spark = SparkSession
        .builder()
        .appName("JavaSparkPi on a cluster")
        .master("spark://un:7077")
        .config("spark.executor.memory", "4g")
        // Uncomment the next block if you want to run your application from
        // the IDE - note that you will have to deploy the jar first to
        // *every* worker. Spark can share a jar from which it is launched -
        // either via spark-submit or via a direct connection, but if you
        // run this application from the IDE, it will not know what to do.
        /*
         * .config("spark.jars",
         * "/home/jgp/.m2/repository/net/jgp/books/sparkWithJava-chapter05/1.0.0-SNAPSHOT/sparkWithJava-chapter05-1.0.0-SNAPSHOT.jar")
         */
        .getOrCreate();

    long t1 = System.currentTimeMillis();
    System.out.println("Session initialized in " + (t1 - t0) + " ms");

    List<Integer> l = new ArrayList<>(numberOfThrows);
    for (int i = 0; i < numberOfThrows; i++) {
      l.add(i);
    }
    Dataset<Row> incrementalDf = spark
        .createDataset(l, Encoders.INT())
        .toDF();

    long t2 = System.currentTimeMillis();
    System.out.println("Initial dataframe built in " + (t2 - t1) + " ms");

    Dataset<Integer> dartsDs = incrementalDf
        .map(new DartMapper(), Encoders.INT());

    long t3 = System.currentTimeMillis();
    System.out.println("Throwing darts done in " + (t3 - t2) + " ms");

    int dartsInCircle = dartsDs.reduce(new DartReducer());
    long t4 = System.currentTimeMillis();
    System.out.println("Analyzing result in " + (t4 - t3) + " ms");

    System.out
        .println("Pi is roughly " + 4.0 * dartsInCircle / numberOfThrows);

    spark.stop();
  }
}
