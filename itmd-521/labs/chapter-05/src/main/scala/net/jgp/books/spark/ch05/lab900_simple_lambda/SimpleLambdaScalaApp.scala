package net.jgp.books.spark.ch05.lab900_simple_lambda

/**
  * Simple Java's Lambda like logic Scala App.
  *
  *
  * @author rambabu.posa
  */
object SimpleLambdaScalaApp {

  def main(args: Array[String]): Unit = {
    // a few French first names that can be composed with Jean
    val frenchFirstNameList = List("Georges", "Claude", "Philippe", "Pierre", "François", "Michel",
        "Bernard", "Guillaume", "André", "Christophe", "Luc", "Louis")

    frenchFirstNameList.foreach{name =>
      println(name + " and Jean-" + name + " are different French first names!")
    }

   println("-----")

    frenchFirstNameList.foreach(name => {
      def foo(name: String) = {
        var message: String = name + " and Jean-"
        message += name
        message += " are different French first names!"
        println(message)
      }

      foo(name)
    })

  }

}
