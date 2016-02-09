//
//  ViewController.swift
//  Blackjack
//
//  Created by David Aghassi on 2/1/16.
//  Copyright © 2016 David Aghassi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  // MARK: Dealer Cards
  @IBOutlet weak var dealerCard1: UIImageView!
  @IBOutlet weak var dealerCard2: UIImageView!
  @IBOutlet weak var dealerCard3: UIImageView!
  @IBOutlet weak var dealerCard4: UIImageView!
  @IBOutlet weak var dealerCard5: UIImageView!

  // MARK: Player Cards
  @IBOutlet weak var playerCard1: UIImageView!
  @IBOutlet weak var playerCard2: UIImageView!
  @IBOutlet weak var playerCard3: UIImageView!
  @IBOutlet weak var playerCard4: UIImageView!
  @IBOutlet weak var playerCard5: UIImageView!
  
  // MARK: Outlets
  @IBOutlet weak var hitButtonOutlet: UIButton!
  @IBOutlet weak var standButtonOutlet: UIButton!
  
  private var dealerCardView = [UIImageView]()
  private var playerCardView = [UIImageView]()
  private var gameModel : BJDGameModel
  
  required init?(coder aDecoder: NSCoder) {
    gameModel = BJDGameModel()
    super.init(coder: aDecoder)
    
    let selector: Selector = "handleNotificationGameDidEnd:"
    NSNotificationCenter.defaultCenter().addObserver(self, selector: selector, name: "BJNotificationGameDidEnd", object: gameModel)
    
  }
  
  func handleNotificationGameDidEnd(notification: NSNotification) {
    
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    dealerCardView = [dealerCard1, dealerCard2, dealerCard3, dealerCard4, dealerCard5]
    playerCardView = [playerCard1, playerCard2, playerCard3, playerCard4, playerCard5]
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    restartGame()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  // MARK: Buttons
  @IBAction func hitButton(sender: UIButton) {
    let card = gameModel.nextPlayerCard()
    card.isFaceUp = true
    renderCards()
    
    //...
    gameModel.updateGameStage()
    
    if gameModel.gameStage == .BJDGameStageDealer {
      playerDealerTurn()
    }
  }
  
  func playerDealerTurn() {
    hitButtonOutlet.enabled = false
    standButtonOutlet.enabled = false
    
    showSecondDealerCard()
  }
  
  func showNextDealerCard() {
    let card = gameModel.nextDealerCard()
    card.isFaceUp = true
    renderCards()
    gameModel.updateGameStage()
    if gameModel.gameStage != .BJDGameStageGameOver {
      let selector : Selector = "showNextDealerCard"
      performSelector(selector, withObject: nil, afterDelay: 0.5)
      //        showNextDealerCard()
    }
  }
  
  func showSecondDealerCard() {
    if let card = gameModel.lastDealerCard() {
      card.isFaceUp = true
      renderCards()
      gameModel.updateGameStage()
      if gameModel.gameStage != .BJDGameStageGameOver {
        let selector : Selector = "showNextDealerCard"
        performSelector(selector, withObject: nil, afterDelay: 0.5)
//        showNextDealerCard()
      }
    }
  }
  
  @IBAction func standButton(sender: UIButton) {
    gameModel.gameStage = .BJDGameStageDealer
    playerDealerTurn()
  }
  
  func restartGame() {
    gameModel.resetGame()
    var card = gameModel.nextPlayerCard()
    card.isFaceUp = true
    card = gameModel.nextPlayerCard()
    card.isFaceUp = true
    
    card = gameModel.nextDealerCard()
    card.isFaceUp = true
    card = gameModel.nextDealerCard()
    
    renderCards()
    hitButtonOutlet.enabled = true
    standButtonOutlet.enabled = true
  }
  
  func renderCards() {
    let maxCard = gameModel.maxPlayerCards
    for i in 0..<maxCard {
      let dealerCV = dealerCardView[i]
      let playerCV = playerCardView[i]
      
      if let dealerCard = gameModel.dealerCardAtIndex(i) {
        dealerCV.hidden = false
        if dealerCard.isFaceUp {
          dealerCV.image = dealerCard.getCardImage()
        }
        else {
          dealerCV.image = UIImage(named: "card-back.png")
        }
      }
      else {
        dealerCV.hidden = true
      }
      
      if let playerCard = gameModel.playerCardAtIndex(i) {
        playerCV.hidden = false
        if playerCard.isFaceUp {
          playerCV.image = playerCard.getCardImage()
        }
        else {
          playerCV.image = UIImage(named: "card-back.png")
        }
      }
      else {
        playerCV.hidden = true
      }
    }
  }

}

