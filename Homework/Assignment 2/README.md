## Assignment 2
##### Author: David Aghassi
##### Class: EECS 392

1. create a function that take a string defined on {1, 2, 3, 4, 5, 6, 7, 8, 9} as input, return the number of digits that are odd, even and divisible by 3

2. Write a variadic function (function with variable number of parameters) called cat(), its first parameter is a string/char serving as a delimiter, followed by any number of intergers. It returns a string that concaternate all the digits but separated by the delimiter. The default value of the first parameter is " ". For example: if you call print(cat(joiner:":", nums: 1,2,3,4,5,6,7,8,9)), output should be 1:2:3:4:5:6:7:8:9 if you call print(cat(nums: 1,2,3,4,5)), out put should be 1 2 3 4 5

3. The Fibonacci numbers is a series of numbers that can be defined recursively, i.e., n(1)=1, n(2)=1, n(i+1) = n(i) + n(i-1) for i>=2. Given an integer n>=1, Implement an efficient algorithm/function to calcuate the n^{th} Fibonacci number. Your algorithm should be able to calculate n=90.

4  Create a structure to store the information of a student. The structure needs to be able to store the following information: Student ID (`String`) Student Name (`String`) Date of birth (DOB). DOB itself is also a struture containing the year, month, and day. Add a computed property named age to the student structure so that you can obtain the age of a student. Create an instance of the structure and print out the age of the student.

5 Create a `Vehicle` class that contains the following properties: model, doors, color – either red, blue, or white,  wheels. Create a subclass of `Vehicle` named `MotorVehicle`. Add an additional property to it named licensePlate. Create a subclass of `Vehicle` named `Bicycle`. Create a subclass of `MotorVehicle` named Car. Create the following initializers: an initializer that sets doors to 2, an initializer that initializes the model, doors, color, and wheels, a convenience initializer that initializes licensePlate and calls the initializer that initializes the model, doors, color, and wheels.