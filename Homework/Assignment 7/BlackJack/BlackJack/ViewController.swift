//
//  ViewController.swift
//  BlackJack
//
//  Created by Jing Li on 2/1/16.
//  Copyright © 2016 CBC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  @IBOutlet weak var buttonHit: UIButton!
  @IBOutlet weak var buttonStand: UIButton!
  @IBOutlet weak var deckSize: UILabel!
  
  @IBOutlet weak var collectionView: UICollectionView!
  @IBOutlet weak var playerCollectionView: UICollectionView!
  
  private var dealerCardView = [UIImageView]()
  private var playerCardView = [UIImageView]()
  private var playerLocation = 0;
  private var dealerLocation = 0;
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
    restartGame()
  }

  
  @IBAction func userClickHit(sender: UIButton) {
    if gameModel.isThreshhold() {
      gameModel.gameStage = .BJGameStageDealer
      playDealerTurn()
    }
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
    }
  }
  
  func showSecondDealerCard(){
    let card = gameModel.nextDealerCard()
    card.isFaceUp = true
    renderCards()
    gameModel.updateGameStage()
    if(gameModel.gameStage != .BJGameStageGameOver){
      let aSelector : Selector = "showNextDealerCard"
      performSelector(aSelector, withObject: nil, afterDelay: 0.5)
      //showNextDealerCard()
    }
  }
  
  
  @IBAction func userClickStand(sender: UIButton) {
    gameModel.gameStage = .BJGameStageDealer
    playDealerTurn()
  }
  
  func restartGame(){
    gameModel.resetGame()
    playerCardView.removeAll()
    dealerCardView.removeAll()
    playerLocation = 0
    dealerLocation = 0
    
    var card = gameModel.nextPlayerCard()
    card.isFaceUp = true
    card = gameModel.nextPlayerCard()
    card.isFaceUp = true
    
    card = gameModel.nextDealerCard()
    card.isFaceUp = true
    card = gameModel.nextDealerCard()
    card.isFaceUp = true
    
    renderCards()
    
    buttonHit.enabled = true
    buttonStand.enabled = true
    
    // check to see if the player won on the first hand.
    gameModel.updateGameStage()
  }
  
  
  @IBAction func unwindToGame(unwindSegue: UIStoryboardSegue) {
    if let mainView = unwindSegue.sourceViewController as? SettingsViewController {
      
      if let deckSize = mainView.deckSizeTextField.text {
        if (!deckSize.isEmpty) {
          self.gameModel.numberOfDecks = Int(deckSize)!
        }
        else {
          self.gameModel.numberOfDecks = 1
        }
      }
      
      if let threshholdSize = mainView.threshholdTextField.text {
        if (!threshholdSize.isEmpty) {
          self.gameModel.threshhold = Int(threshholdSize)!
        }
        else {
          self.gameModel.threshhold = 52
        }
      }
      
      restartGame()
    }
  }
  
  @IBAction func cancelButtonUnwind(unwindSegue: UIStoryboardSegue) {
  }


  
  func textChanged(sender:AnyObject) {
    let tf = sender as! UITextField
    // enable OK button only if there is text
    // hold my beer and watch this: how to get a reference to the alert
    var resp : UIResponder! = tf
    while !(resp is UIAlertController) { resp = resp.nextResponder() }
    let alert = resp as! UIAlertController
    alert.actions[0].enabled = (tf.text != "")
  }
  
  func renderCards(){
    if (dealerLocation <= 0) {
      for i in 0..<2 {
        addPlayerCard(i)
        addDealerCard(i)
      }
    }
    else {
      addPlayerCard(playerLocation)
      addDealerCard(dealerLocation)
    }
    deckSize.text = "Remaining Cards: \(gameModel.deckSize)"
  }
  
  private func addDealerCard(index: Int) {
    let dealerCV = UIImageView()
    
    if let dealerCard = gameModel.dealerCardAtIndex(index){
      if dealerCard.isFaceUp{
        dealerCV.image = dealerCard.getCardImage()
      }else{
        dealerCV.image = UIImage(named: "card-back.png")
      }
      
      dealerCardView.append(dealerCV)
      dealerLocation++
    }

    self.collectionView.reloadData()
  }
  
  private func addPlayerCard(index: Int) {
    let playerCV = UIImageView()
    
    if let playerCard = gameModel.playerCardAtIndex(index){
      if playerCard.isFaceUp{
        playerCV.image = playerCard.getCardImage()
      }else{
        playerCV.image = UIImage(named: "card-back.png")
      }
      
      playerCardView.append(playerCV)
      playerLocation++
    }

    self.playerCollectionView.reloadData()
  }
  
}

private let reuseDealerIdentifier = "DealerCell"
private let reusePlayerIdentifier = "PlayerCell"

extension ViewController: UICollectionViewDataSource {
  /*
  // MARK: - Navigation
  
  // In a storyboard-based application, you will often want to do a little preparation before navigation
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
  // Get the new view controller using [segue destinationViewController].
  // Pass the selected object to the new view controller.
  }
  */
  
  // MARK: UICollectionViewDataSource
  
  func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
    // #warning Incomplete implementation, return the number of sections
    return 1
  }
  
  
  func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    // #warning Incomplete implementation, return the number of items
    if collectionView == self.collectionView {
      return dealerCardView.count
    }
    else if collectionView == self.playerCollectionView {
      print(playerCardView.count)
      return playerCardView.count
    }
    
    // if neither return 5
    return 5
  }
  
  func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    var cell = CollectionViewCell()
    let index = indexPath.row
    
    if collectionView == self.collectionView {
      // dealer
      cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseDealerIdentifier, forIndexPath: indexPath) as! CollectionViewCell
      cell.image.image = dealerCardView[index].image
    }
    else if collectionView == self.playerCollectionView {
      // player
      cell = collectionView.dequeueReusableCellWithReuseIdentifier(reusePlayerIdentifier, forIndexPath: indexPath) as! CollectionViewCell
      cell.image.image = playerCardView[index].image
    }
    
    cell.frame.origin = CGPoint(x: index * 70, y: 0)
    cell.layer.zPosition = CGFloat(index)
    
    return cell
  }
  
  
  // MARK: UICollectionViewDelegate
  
  /*
  // Uncomment this method to specify if the specified item should be highlighted during tracking
  override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
  return true
  }
  */
  
  /*
  // Uncomment this method to specify if the specified item should be selected
  override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
  return true
  }
  */
  
  /*
  // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
  override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
  return false
  }
  
  override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
  return false
  }
  
  override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
  
  }
  */
  
}
