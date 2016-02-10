//
//  ViewController.swift
//  BlackJack
//
//  Created by Jing Li on 2/1/16.
//  Copyright © 2016 CBC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var dealerCard1: UIImageView!
    @IBOutlet weak var dealerCard2: UIImageView!
    @IBOutlet weak var dealerCard3: UIImageView!
    @IBOutlet weak var dealerCard4: UIImageView!
    @IBOutlet weak var dealerCard5: UIImageView!
    @IBOutlet weak var playerCard1: UIImageView!
    @IBOutlet weak var playerCard2: UIImageView!
    @IBOutlet weak var playerCard3: UIImageView!
    @IBOutlet weak var playerCard4: UIImageView!
    @IBOutlet weak var playerCard5: UIImageView!

    @IBOutlet weak var buttonHit: UIButton!
    @IBOutlet weak var buttonStand: UIButton!
    
    private var dealerCardView = [UIImageView] ()
    private var playerCardView = [UIImageView] ()
    private var gameModel : BJDGameModel
    
    required init?(coder aDecoder: NSCoder) {
        gameModel = BJDGameModel()
        super.init(coder : aDecoder)
        
        let aSelector : Selector = "handleNotificationGameDidEnd:"
        NSNotificationCenter.defaultCenter().addObserver(self, selector: aSelector, name: "BJNotificationGameDidEnd", object: gameModel)
    }
    
    func handleNotificationGameDidEnd(notification: NSNotification){
        if let userInfo : Dictionary = notification.userInfo{
            if let num = userInfo["didDealerWin"] {
                let message = num.boolValue! ? "Dealer won!" : "You won!"
                let alert = UIAlertController(title: "Game Over", message: message, preferredStyle: .Alert)
                let alertAction = UIAlertAction(title: "Play again", style: .Default, handler: ({ (_: UIAlertAction)-> Void in self.restartGame() }))
                alert.addAction(alertAction)
                presentViewController(alert, animated: true, completion: nil)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        dealerCardView = [dealerCard1, dealerCard2, dealerCard3, dealerCard4, dealerCard5 ]
        playerCardView = [playerCard1, playerCard2, playerCard3, playerCard4, playerCard5]
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        restartGame()
    }
    @IBAction func userClickHit(sender: UIButton) {
        let card = gameModel.nextPlayerCard()
        card.isFaceUp = true
        renderCards()
        //...
        gameModel.updateGameStage()
        
        if gameModel.gameStage == .BJGameStageDealer{
            playDealerTurn()
        }
        
    }
    
    func playDealerTurn(){
        buttonHit.enabled = false
        buttonStand.enabled = false
        
        showSecondDealerCard()
        
    }
    
    func showNextDealerCard(){
        let card = gameModel.nextDealerCard()
        card.isFaceUp = true
        renderCards()
        gameModel.updateGameStage()
        if gameModel.gameStage != .BJGameStageGameOver {
            let aSelector : Selector = "showNextDealerCard"
            performSelector(aSelector, withObject: nil, afterDelay: 0.5)
            
            //showNextDealerCard()
        }
    }
    
    func showSecondDealerCard(){
        if let card = gameModel.lastDealerCard(){
            card.isFaceUp = true
            renderCards()
            gameModel.updateGameStage()
            if(gameModel.gameStage != .BJGameStageGameOver){
                let aSelector : Selector = "showNextDealerCard"
                performSelector(aSelector, withObject: nil, afterDelay: 0.5)
                //showNextDealerCard()
            }
        }
    }
    
    
    @IBAction func userClickStand(sender: UIButton) {
        gameModel.gameStage = .BJGameStageDealer
        playDealerTurn()
    }
    
    func restartGame(){
        gameModel.resetGame()
        var card = gameModel.nextPlayerCard()
        card.isFaceUp = true
        card = gameModel.nextPlayerCard()
        card.isFaceUp = true
        
        card = gameModel.nextDealerCard()
        card.isFaceUp = true
        card = gameModel.nextDealerCard()
        
        renderCards()
        
        buttonHit.enabled = true
        buttonStand.enabled = true
      
        // check to see if the player won on the first hand.
        gameModel.updateGameStage()
    }
    
    func renderCards(){
        let maxCard = gameModel.maxPlayerCards
        for  i in 0..<maxCard{
            let dealerCV = dealerCardView[i]
            let playerCV = playerCardView[i]
            
            if let dealerCard = gameModel.dealerCardAtIndex(i){
                dealerCV.hidden = false
                if dealerCard.isFaceUp{
                    dealerCV.image = dealerCard.getCardImage()
                }else{
                    dealerCV.image = UIImage(named: "card-back.png")
                }
            }else{
                dealerCV.hidden = true
            }
            
            if let playerCard = gameModel.playerCardAtIndex(i){
                playerCV.hidden = false
                if playerCard.isFaceUp{
                    playerCV.image = playerCard.getCardImage()
                }else{
                    playerCV.image = UIImage(named: "card-back.png")
                }
            }else{
                playerCV.hidden = true
            }
            
            
        }
    }


}

