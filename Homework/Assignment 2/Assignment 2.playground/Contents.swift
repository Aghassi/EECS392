//: Playground - noun: a place where people can play

import UIKit
import Swift

// MARK: 1
/**
1. create a function that take a string defined on {1, 2, 3, 4, 5, 6, 7, 8, 9} as input, return the number of digits that are odd, even and divisible by 3

- parameters stingInput: A string of numbers
- returns: Tuple
*/
func calculateOddEvenDivThree(numbers: String) -> (even: Int, odd: Int, divThree: Int) {
  var even = 0
  var odd = 0
  var divThree = 0
  
  for number in numbers.characters {
    // check the optional
    guard let intNumber = Int(String(number)) else {
      return ( 0, 0, 0)
    }
    
    // calculate each
    if isEven(intNumber) {
      even++
    }
    else if isOdd(intNumber) {
      odd++
    }
    
    if isDivisibleByThree(intNumber) {
      divThree++
    }
  }
  
  return (even, odd, divThree)
}

func isEven(number: Int) -> Bool {
  return (number % 2) == 0
}

func isOdd(number: Int) -> Bool {
  return (number % 2) != 0
}

func isDivisibleByThree(number: Int) -> Bool {
  return (number % 3) == 0
}

let number = "123456789"
calculateOddEvenDivThree(number)

// MARK: 2
/**
2. Write a variadic function (function with variable number of parameters) called cat(), its first parameter is a string/char serving as a delimiter, followed by any number of intergers. It returns a string that concaternate all the digits but separated by the delimiter. The default value of the first parameter is " ". For example: if you call print(cat(joiner:":", nums: 1,2,3,4,5,6,7,8,9)), output should be 1:2:3:4:5:6:7:8:9 if you call print(cat(nums: 1,2,3,4,5)), out put should be 1 2 3 4 5
*/

func cat(delimiter: Character = " ", numbers: Int... ) -> String {
  var delimitedString: String = ""
  
  for number in numbers {
    delimitedString.appendContentsOf("\(number)")
    delimitedString.append(delimiter)
  }
  delimitedString = String(delimitedString.characters.dropLast(1))
  
  return delimitedString
}

print(cat(":", numbers: 1,2,3,4,5,6,7,8,9))
print(cat(numbers: 1,2,3,4,5))


// MARK: 3
/**
3. The Fibonacci numbers is a series of numbers that can be defined recursively, i.e., n(1)=1, n(2)=1, n(i+1) = n(i) + n(i-1) for i>=2. Given an integer n>=1, Implement an efficient algorithm/function to calcuate the n^{th} Fibonacci number. Your algorithm should be able to calculate n=90.
*/
// I found this here http://blog.scottlogic.com/2014/06/26/swift-sequences.html
/**
Pretty much what we end up doing is overriding the `SequenceType` protocol by extending it. We implement our own type here so we have to override the defaults of the protocal. SequenceType requires a `GeneratorType`, which we also override. We set it so that, when you sequence the variable in a for in loop, we can keep state and use the `.next()` function to calculate the next output given the prior output
*/
class Fibonacci : SequenceType {
  typealias GeneratorType = FibonacciGenerator
  
  func generate() -> FibonacciGenerator {
    return FibonacciGenerator()
  }
}

class FibonacciGenerator : GeneratorType {
  var current = 0, nextValue = 1
  
  typealias Element = Int
  
  func next() -> Int? {
    let ret = current
    current = nextValue
    nextValue = nextValue + ret
    return ret
  }
}

let fib = Fibonacci().generate()
let n = 20
var computed = 0
for _ in 1..<n {
  guard let fib = fib.next() else {
    break
  }
  computed = fib
}
print(computed)


// MARK: 4
/**
4  Create a structure to store the information of a student. The structure needs to be able to store the following information: Student ID (String) Student Name (String) Date of birth (DOB). DOB itself is also a struture containing the year, month, and day. Add a computed property named age to the student structure so that you can obtain the age of a student. Create an instance of the structure and print out the age of the student.
*/

struct DOB {
  // TODO: This should actualy make sure the year/month/day is limited to 4/2/2 characters respectively
  var year, month, day: Int
}

struct Student {
  var studentID, name: String
  var dob: DOB
  var age : Int {
    // calculates the age by taking the difference between this year and the one in the DOB
    let date = NSDate()
    let calendar = NSCalendar.currentCalendar()
    let year = calendar.component(.Year, fromDate: date)
    return year - dob.year
  }
}

let bobDOB = DOB(year: 1993, month: 08, day: 01)
var student = Student(studentID: "BobEvans", name: "Bob", dob: bobDOB)
print(student.age)


// MARK: 5
/**
5 Create a Vehicle class that contains the following properties: model, doors, color – either red, blue, or white,  wheels. Create a subclass of Vehicle named MotorVehicle. Add an additional property to it named licensePlate. Create a subclass of Vehicle named Bicycle. Create a subclass of MotorVehicle named Car. Create the following initializers: an initializer that sets doors to 2, an initializer that initializes the model, doors, color, and wheels, a convenience initializer that initializes licensePlate and calls the initializer that initializes the model, doors, color, and wheels.
*/

// I would make this a protocol if this wasn't homework
class Vehicle {
  var model: String = "Ford"
  var color: String = "Blue"
  var doors: Int = 4
  var wheels: Int = 4
  
  /**
   Initializes the vehicle with the given model. Colors, doors and wheels have default values of blue, 4, and 4 respecively.
   
   - parameter model: The string representation of the model of the car
   */
  init(model: String) {
    self.model = model
  }
  
}

class MotorVehicle: Vehicle {
  var licensePlate: String = ""
}

class Bicycle: Vehicle {
  
  /**
   Overrides base initializer, and sets the doors and wheels to 0 and 2 respectively. Default color is blue.
   
   - parameter model: The string representation of the model of the car
   */
  override init(model: String) {
    super.init(model: model)
    self.doors = 0
    self.wheels = 2
  }
}

class Car: MotorVehicle {
  
  /**
   Overrides the base initializer. Calls the super initializer, and sets the doors to 2
   
   - parameter model: The string representation of the model of the car
   */
  override init(model: String) {
    super.init(model: model)
    self.doors = 2
  }
  
  /**
   Creates a car of the given model and color, plus the doors and wheels specified.
   
   - Parameters:
      - model: The string representation of the model of the car
      - color: The string representation of the color of the car
      - doors: The number of the doors on the car
      - wheels: The number of the wheels on the car
   */
  init(model: String, color: String, doors: Int, wheels: Int) {
    super.init(model: model)
    self.color = color
    self.doors = doors
    self.wheels = wheels
  }
  
  /**
   Creates a blue ford with 4 doors and 4 wheels with the given license plate
   
   - parameter licensePlate: The string represenation of the given licensePlate
   */
  convenience init(licensePlate: String) {
    self.init(model: "Ford", color: "blue", doors: 4, wheels: 4)
    self.licensePlate = licensePlate
  }
}
