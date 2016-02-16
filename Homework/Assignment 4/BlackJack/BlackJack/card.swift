//
//  card.swift
//  BlackJack
//
//  Created by Jing Li on 2/3/16.
//  Copyright © 2016 CBC. All rights reserved.
//

import Foundation
import UIKit


enum Suit : Int {
  case Club = 0, Spade, Diamond, Heart
  func simpleDescription () -> String{
    switch self{
    case .Club:
      return "club"
    case .Spade:
      return "spade"
    case .Diamond:
      return "diamond"
    case .Heart:
      return "heart"
    }
  }
  
}

class Card {
  var digit = 0
  var suit : Suit = .Club
  var isFaceUp = false
  
  init(suit: Suit, digit: Int){
    self.suit = suit
    self.digit = digit
    isFaceUp = false
  }
  
  func getCardImage() -> UIImage? {
    return UIImage(named: "\(suit.simpleDescription())-\(digit).png")//club-1.png
  }
  
  func isAFaceorTen () -> Bool{
    return digit > 9 ? true : false
  }
  
  func isAce () -> Bool{
    return digit == 1 ? true : false
  }
  
  //static
  class func generateAPackOfCards () -> [Card] {
    var deckOfCards = [Card] ()
    for var i = 0; i<4; i++ {
      for var iDigit = 1; iDigit < 14; iDigit++ {
        if let iSuit = Suit(rawValue: i){
          let card = Card(suit: iSuit, digit: iDigit)
          deckOfCards.append(card)
          
        }
      }
    }
    return deckOfCards
  }
  
}

extension CollectionType {
  /// Return a copy of `self` with its elements shuffled
  func shuffle() -> [Generator.Element] {
    var list = Array(self)
    list.shuffleInPlace()
    return list
  }
}

extension MutableCollectionType where Index == Int {
  /// Shuffle the elements of `self` in-place.
  mutating func shuffleInPlace() {
    // empty and single-element collections don't shuffle
    if count < 2 { return }
    
    for i in 0..<count - 1 {
      let j = Int(arc4random_uniform(UInt32(count - i))) + i
      guard i != j else { continue }
      swap(&self[i], &self[j])
    }
  }
}

enum BJGameStage : Int{
  case BJGameStagePlayer = 0, BJGameStageDealer, BJGameStageGameOver
  
}

class BJDGameModel{
  
  private var cards = [Card]()
  private var playerCards = [Card]()
  private var dealerCards = [Card]()
  var deckSize : Int {
      return self.cards.count
  }
  
  var gameStage : BJGameStage = .BJGameStagePlayer
  let maxPlayerCards = 5
  var didDealerWin = false
  
  
  init(){
    
    resetGame()
  }
  
  func resetGame(){
    self.cards = Card.generateAPackOfCards()
    //shuffle()
    self.cards.shuffleInPlace()
    playerCards = [Card]()
    dealerCards = [Card]()
    gameStage = .BJGameStagePlayer
  }
  
  func nextPlayerCard() -> Card{
    let card = cards.removeFirst()
    playerCards.append(card)
    return card
  }
  
  func nextDealerCard () -> Card{
    let card = cards.removeFirst()
    dealerCards.append(card)
    return card
  }
  
  func playerCardAtIndex(i: Int) -> Card?{
    if i < playerCards.count {
      return playerCards[i]
    }else{
      return nil
    }
  }
  
  func dealerCardAtIndex(i: Int) -> Card?{
    if i < dealerCards.count {
      return dealerCards[i]
    }else{
      return nil
    }
  }
  
  private func areCardsBust(curCards: [Card]) -> Bool{
    var lowestScore = 0
    for card in curCards {
      if card.isAce() {
        lowestScore += 1
      }else if card.isAFaceorTen(){
        lowestScore += 10
      }else{
        lowestScore += card.digit
      }
      
    }
    return lowestScore > 21 ? true : false
  }
  
  func notifyGameDidEnd(){
    //communication back to controller game is over
    let notificationCenter = NSNotificationCenter.defaultCenter()
    
    let str: NSString = "didDealerWin"
    let didDealerWin : NSNumber = self.didDealerWin
    let dict = [ str: didDealerWin]
    
    notificationCenter.postNotificationName("BJNotificationGameDidEnd", object: self, userInfo: dict)
    
  }
  
  private func calculateBestScore (cards : [Card]) -> Int{
    var highestScore = 0
    
    if areCardsBust(cards){
      return highestScore
    }
    
    for card in cards {
      if card.isAce(){
        highestScore += 11
      }else if card.isAFaceorTen(){
        highestScore += 10
      }else{
        highestScore += card.digit
      }
      
    }
    
    while highestScore > 21 {
      highestScore -= 10
    }
    
    return highestScore
    
  }
  private func calculateWinner(){
    let dealerScore = calculateBestScore(dealerCards)
    let playerScore = calculateBestScore(playerCards)
    didDealerWin = dealerScore >= playerScore
  }
  
  func updateGameStage(){
    if gameStage == .BJGameStagePlayer {
      if areCardsBust(playerCards){
        //...
        gameStage = .BJGameStageGameOver
        didDealerWin = true
        notifyGameDidEnd()
      }else if playerCards.count == maxPlayerCards{
        //..
        gameStage = .BJGameStageDealer
        
      }
      
    }else if gameStage == .BJGameStageDealer
    {
      if areCardsBust(dealerCards){
        gameStage = .BJGameStageGameOver
        didDealerWin = false
        notifyGameDidEnd()
      }else if dealerCards.count == maxPlayerCards{
        gameStage = .BJGameStageGameOver
        calculateWinner()
        notifyGameDidEnd()
      }else {
        let dealerScore = calculateBestScore(dealerCards)
        if(dealerScore < 17){
          
        }else{
          let playerScore = calculateBestScore(playerCards)
          if (playerScore > dealerScore){
            
          }else{
            gameStage = .BJGameStageGameOver
            didDealerWin = true
            notifyGameDidEnd()
          }
        }
      }
      
    }else{//game over
      
    }
    
  }
  
  func lastDealerCard() -> Card?{
    return dealerCards.last
  }
  
}