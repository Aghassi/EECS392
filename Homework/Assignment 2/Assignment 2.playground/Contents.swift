//: Playground - noun: a place where people can play

import UIKit
import Swift

// MARK: 1


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
let n = 10
for _ in 1..<n {
  print(String(fib.next()))
}
