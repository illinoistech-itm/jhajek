package net.jgp.books.spark.ch05.lab900_simple_lambda;

import java.util.Arrays;
import java.util.List;

public class SimpleLambdaApp {

  public static void main(String[] args) {
    // a few French first names that can be composed with Jean
    List<String> frenchFirstNameList = Arrays.asList("Georges", "Claude",
        "Philippe", "Pierre", "François", "Michel", "Bernard", "Guillaume",
        "André", "Christophe", "Luc", "Louis");

    frenchFirstNameList.forEach(
        name -> System.out.println(name + " and Jean-" + name
            + " are different French first names!"));

    System.out.println("-----");

    frenchFirstNameList.forEach(
        name -> {
          String message = name + " and Jean-";
          message += name;
          message += " are different French first names!";
          System.out.println(message);
        });
  }
}
