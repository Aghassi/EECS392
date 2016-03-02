## Assignment 5
##### Author: David Aghassi
##### Class: EECS 392

1. (1pt) Briefly go over the following guides from Xcode documentation, (search the titles using google)

Cocoa Touch competencies: Model-View-Controller
View Programming Guide for iOS
View Controller Programming Guide for iOS
Drawing and Printing Guide for iOS
Quartz 2D Programming guide
Auto Layout Guide
Collection View Programming Guide for iOS

2. (3pts) Redo your assignment 1, problem 4. This time you need to 1) adding necessary constraints so that your app can run on different devices (iPhones and iPads), and all the UI elements position well in both portrait and landscape model. 2) in your implementation of address, you should separate the address into four different fields: street address, city, state and zip code. Use UIPickerView to implement the “state” field. 3) Use Date Picker to allow users to choose Purchase Date. Because of small screen of iPhone, both pickers will only show up when users need to pick the values.   

3. (1pts) You are given a fixed pedigree structure shown below.

 
1   1   0  0  1  1
1   2   0  0  2  0
1   3   0  0  1  0
1   4   1  2  2  1
1   5   3  4  2  1
1   6   3  4  1  0
 
 
Each line represents an individual. The columns are: familyID, individualID, fatherID, motherID, gender (1: male, 2:female), affected status(1: affected, 0:not). You need to create a data model/class for this and draw the pedigree on your view.

A pedigree figure is like the one below (not corresponding to the one you need to draw in your homework). Circles for females, squares for males, black/filled one for affected, open one for normal. Child nodes are placed under parent nodes.  