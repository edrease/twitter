//: Playground - noun: a place where people can play

import UIKit

func reverseArrayOrder (array: [AnyObject]) -> [AnyObject] {
  let reversedArray = array.reverse()
  return reversedArray
}

var ninjaTurtles = ["Leonardo", "Raphael", "Donatello", "Michaelangelo"]

let turtles = reverseArrayOrder(ninjaTurtles)

println(turtles)

func reverseHarder (array: [AnyObject]) -> [AnyObject] {
  
  for item in array {
    
  }
  
  return array
}

//Still working on reversing that array manually!

//FizzBuzz

func fizzBuzz() {
  
  for number in 1...100 {
    if (number % 5 == 0) && (number % 3 == 0)  {
      println("FizzBuzzzzz")
    } else if number % 3 == 0 {
      println("Fizz")
    } else if number % 5 == 0 {
      println("Buzz")
    } else {
    println(number)
    }
  }
  
}

fizzBuzz()


//Return number of "hi's" in given String

func returnNumberOfTimeHiAppears (string: String) -> Int {
  var numberOfHi = 0
  for character in string {
    if character == "h" {
      
      ++numberOfHi
    }
  }
  return numberOfHi
}

returnNumberOfTimeHiAppears("how are you heidi the ho?")





