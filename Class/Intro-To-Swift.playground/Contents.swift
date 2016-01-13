//: ## Basic Types
//: `: String` - This is a type of string
//:
//: This type is inferred
var str : String = "Hello, playground"

//: This is the equivelent of saying `: Int`
var num = 70

//: Define a constant
let constant = "This, is a constant"

//: You must always assign a value to a variable before using it
//:
//: `var str: String`  is not valid

//: Using string interpolation, you can pass integers into a new string
let apples = 3
let appleSummary = "There are \(apples) apples"

//: ## Optional Values
//:
//: Optional is a variable that may or may not have a value.
//: This is denoted by a `?`
let optionalInt : Int? = 9

//: Because of this property, you can define variables without initializing them
let optionalStr : String? = "Not nil"

//: You need to use the `!` to unwrap the optional. You only do this if you are sure the underlying value is not `nil`. This can be dangerous.
let actualStr : String = optionalStr!

//: `Int?` is a different type from `Int`, which is why it is important to watch your optionals. You can assign an optional that is nil to another value that you don't specify the type for.
//:
//: eg - `let optionalValue = optionalStr`
//:
//: Everything in Swift is an optional because we can't assume anything. So if you do `Int(myString)`, it will be an optional int. If the string is not a number, it becomes `nil`

//: ## Arrays
//: You can let the compiler infer the array type, or you can explicitly tell it the type
var inferredArray = [ 1, 2, 3, 4]   // This is an integer array
var explicitArray : [Int] = [1, 2, 3, 4]    //This is an integer array that we say is only integers

//: You can also create an empty array of a certain type
var emptyArray = [String]()

//: ## Tuples
//:
//: Good for returning multiple values from a function. More lightweight than arrays

var t = (number: 1, string: "First")
print(t.number)
//: You can also use the index
print(t.0)

