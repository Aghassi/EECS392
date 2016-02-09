//
//  Card.swift
//  Blackjack
//
//  Created by David Aghassi on 2/3/16.
//  Copyright © 2016 David Aghassi. All rights reserved.
//

import Foundation
import UIKit

enum Suit : Int {
  case Club = 0, Spade, Diamond, Heart
  func simpleDescription() -> String {
    switch self {
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
  
  init(suit: Suit, digit: Int) {
    self.suit = suit
    self.digit = digit
  }
  
  func getCardImage() -> UIImage? {
    return UIImage(named: "\(suit.simpleDescription())-\(digit).png") // club-1.png
  }
  
  func isAFaceOrTen() -> Bool {
    return digit > 9 ? true : false
  }
  
  func isAce() -> Bool {
    return digit == 1 ? true : false
  }
  
  // MARK: Static Functions
  class func generateAPackOfCards() -> [Card] {
    var deck = [Card]()
    
    for var i = 0; i < 4; i++ {
      for var iDigit = 1; iDigit < 14; iDigit++ {
        if let iSuit = Suit(rawValue: i){
          let card = Card(suit: iSuit, digit: iDigit)
          deck.append(card)
        }
      }
    }
    
    return deck
  }
}

enum BJGameStage : Int {
  case BJGameStagePlayer = 0, BJDGameStageDealer, BJDGameStageGameOver
}

class BJDGameModel {
  private var cards = [Card]()
  private var playerCards = [Card]()
  private var dealerCards = [Card]()
  
  var gameStage : BJGameStage = .BJGameStagePlayer
  let maxPlayerCards = 5
  var didDealerWin = false
  
  
  init() {
    resetGame()
  }
  
  /**
   Resets the game
   */
  func resetGame() {
    self.cards = Card.generateAPackOfCards()
    // shuffle()
    playerCards = [Card]()
    dealerCards = [Card]()
  }
  
  /**
   Draws a card from the deck
   
   - return: A card to the player
   */
  func nextPlayerCard() -> Card {
    let card = cards.removeFirst()
    playerCards.append(card)
    return card
  }
  
  /**
   Draws a card from the deck
   
   - return: A card to the dealer
   */
  func nextDealerCard() -> Card {
    let card = cards.removeFirst()
    dealerCards.append(card)
    return card
  }
  
  /**
   Returns card at given index, nil if out of bounds
   
   - return: A card given the index
   */
  func playerCardAtIndex(i: Int) -> Card? {
    if i < playerCards.count {
      return playerCards[i]
    }
    else {
      return nil
    }
  }
  
  /**
   Returns card at given index, nil if out of bounds
   
   - return: A card given the index
   */
  func dealerCardAtIndex(i: Int) -> Card? {
    if i < playerCards.count {
      return playerCards[i]
    }
    else {
      return nil
    }
  }
  
  func lastDealerCard() -> Card? {
    return dealerCards.last
  }
  
  private func areCardsBust(currentCards: [Card]) -> Bool {
    var lowestScore = 0
    for card in currentCards {
      if card.isAce() {
        lowestScore += 1
      }
      else if card.isAFaceOrTen() {
        lowestScore += 10
      }
    }
    
    return lowestScore > 21 ? true : false
  }
  
  func notifyGameDidEnd() {
    // communication back to the controller that game is over
    let notificationCenter = NSNotificationCenter.defaultCenter()
    let string : NSString = "didDealerWin"
    let didDealerWin : NSNumber = self.didDealerWin
    let dict = [ string: didDealerWin]
    
    notificationCenter.postNotificationName("NJNotificationGameDidEnd", object: self, userInfo: dict)
  }
  
  private func calculateBestScore(cards: [Card]) -> Int {
    var highScore = 0
    
    if areCardsBust(cards) {
      return highScore
    }
    
    for card in cards {
      if card.isAce() {
        highScore += 11
      }
      else if card.isAFaceOrTen() {
        highScore += 10
      }
      else {
        highScore += card.digit
      }
    }
    
    // deals with potential more than one ace
    while highScore > 21 {
      highScore -= 10
    }
    
    return highScore
  }
  
  private func calculateWinner() {
    let dealerScore = calculateBestScore(dealerCards)
    let playerScore = calculateBestScore(playerCards)
    didDealerWin = dealerScore > playerScore
  }
  
  func updateGameStage() {
    if gameStage == .BJGameStagePlayer {
      if areCardsBust(playerCards) {
        gameStage = .BJDGameStageGameOver
        didDealerWin = true
        notifyGameDidEnd()
      }
      else if playerCards.count == maxPlayerCards {
        
      }
    }
    else if gameStage == .BJDGameStageDealer {
      gameStage = .BJDGameStageDealer
      if areCardsBust(dealerCards) {
        gameStage = .BJDGameStageGameOver
        didDealerWin = false
        notifyGameDidEnd()
      }
      else if dealerCards.count == maxPlayerCards {
        gameStage = .BJDGameStageGameOver
        calculateWinner()
        notifyGameDidEnd()
      }
      else {
        let dealerScore = calculateBestScore(dealerCards)
        if (dealerScore < 17) {
          
        }
        else {
          let playerScore = calculateBestScore(playerCards)
          if (playerScore > dealerScore) {
            
          }
          else {
            gameStage = .BJDGameStageGameOver
            didDealerWin = true
            notifyGameDidEnd()
          }
        }
      }
    }
    else {
      // game over
    }
  }
}