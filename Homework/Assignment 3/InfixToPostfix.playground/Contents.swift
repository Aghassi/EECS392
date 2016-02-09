//: Playground - noun: a place where people can play

import Foundation

// Represents the value/weight of the operator on the stack
enum Operators: Int {
  case Carrot = 4
  case MultiplyOrDivide = 3
  case AddOrSubtract = 2
  case Parens = 0
}

class AssociatedOperatorValue {
  var op: Character
  var weight = 0
  
  init(op: Character, value: Operators) {
    self.op = op
    self.weight = value.rawValue
  }
}

func infixToPostFix(infix: String) -> String {
  var postfix = ""
  var stack = [AssociatedOperatorValue]()
  
  for char in infix.characters {
    print(char)
    if char == "^" {
      let element = AssociatedOperatorValue(op: char, value: .Carrot)
      // highest priority
      let newValues = insertAndRemoveFromStack(stack, element: element, postfix: postfix)
      stack = newValues.0
      postfix = newValues.1
    }
    else if char == "*" || char == "/" {
      // lowest
      let element = AssociatedOperatorValue(op: char, value: .MultiplyOrDivide)
      let newValues = insertAndRemoveFromStack(stack, element: element, postfix: postfix)
      stack = newValues.0
      postfix = newValues.1
    }
    else if char == "+" || char == "-" {
      // lowest
      let element = AssociatedOperatorValue(op: char, value: .AddOrSubtract)
      let newValues = insertAndRemoveFromStack(stack, element: element, postfix: postfix)
      stack = newValues.0
      postfix = newValues.1
    }
    else if char == "(" || char == ")" {
      // lowest
      let element = AssociatedOperatorValue(op: char, value: .Parens)
      let newValues = insertAndRemoveFromStack(stack, element: element, postfix: postfix)
      stack = newValues.0
      postfix = newValues.1

    }
    else {
      // we have a letter
      postfix.append(char)
    }
    print(postfix)
  }
  
  while stack.count > 0 {
    let element = stack.removeLast()
    postfix = postfix + "\(element.op)"
  }
  
  return postfix
}

/**
 Manages the stack of operators
 
 - Parameters:
    - stack: The stack to be modified and returned
    - element: The current operator and its associated weight value
    - postfix: The current postfix string being built
 
 - returns: A tuple that contains the new `stack` and new `postfix`
 */
func insertAndRemoveFromStack(var stack: [AssociatedOperatorValue], element: AssociatedOperatorValue, var postfix: String) -> ([AssociatedOperatorValue], String){
  if stack.count == 0 {
    stack.append(element)
  }
  else {
    if let last = stack.last {
      var currentLast = last
      // only keep popping if the weight is higher than the current weight
      while currentLast.weight >= element.weight && element.weight != 0 {
        let removeValue = stack.removeLast()
        postfix = postfix + "\(removeValue.op)"
        
        guard let newLast = stack.last else {
          stack.append(element)
          return (stack, postfix)
        }
        currentLast = newLast
      }
      
      // finding matching parenthesis
      while element.op == ")" && currentLast.weight != 0 {
        let removeValue = stack.removeLast()
        postfix = postfix + "\(removeValue.op)"
        
        guard let newLast = stack.last else {
          stack.append(element)
          return (stack, postfix)
        }
        currentLast = newLast
      }
      
      while currentLast.weight == 0 {
        stack.removeLast()
        
        guard let newLast = stack.last else {
          return (stack, postfix)
        }
        currentLast = newLast
      }
      
      stack.append(element)
    }
  }

  return (stack, postfix)
}


// I'll be honest, I started this monday night, so I did the best I could given the time. I know for a fact this is a really poorly done implementation, and doesn't work quite right. But hey, we all have those. At least it works right inthe base case I have. 
infixToPostFix("a+b*c-d")
infixToPostFix("5+((1+2)×4)–3")