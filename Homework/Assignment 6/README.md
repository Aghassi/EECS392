## Assignment 6
##### Author: David Aghassi
##### Class: EECS 392

- Add pinch and pan gestures to prior assignment
- Allow user to select an individual when they tap on a pedigree object. Highlight the object when tapped

This is a poor implementation, and could have been done better using the `drawRect` function of `UIView`. Each chart point should have inherited from a `UIView class` that did all the drawing management. It should not be left up to the controller like in this implementation.
