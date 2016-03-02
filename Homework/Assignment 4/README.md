## Assignment 4
##### Author: David Aghassi
##### Class: EECS 392

Download and play a Black Jack app from App Store. Notice the functions that our simple model does not support.

I have loaded the project in BB/Course Documents/Code. You need to further modify the code so you can handle the following:

a  (1pt) Implement the shuffle function. There are different algorithms for shuffling, you can do any one as long as it is correct. You can do so either as a method of the model, or implement it as an Extension to all collection type (I could not find a good document to help you to do so, so this is optional).   

b  (1pt) Allow users to specify the number of decks and a threshold to start a new game with a set of new cards. So the logic is when one game is over, you should continue playing new games as long as the number of remaining cards is greater than the threshold. You should add something to the UI to show the remaining cards.

c   (1pt) Check whether player gets BlackJack initially. If so, declare player win and allow to start a new game.

d   (2pts) using UICollectionView to dynamically generate any number of card views, so that you donot need to have a MaxCard limitation. 