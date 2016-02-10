//
//  MyCollectionViewController.swift
//  Blackjack
//
//  Created by David Aghassi on 2/10/16.
//  Copyright © 2016 David Aghassi. All rights reserved.
//

import UIKit

class MyCollectionViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}


// MARK: UICollectionViewDataSource
extension MyCollectionViewController: UICollectionViewDataSource {
  
  func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 2
  }
  
  func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
    return 1
  }
  
  func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    let cell = collectionView.cellForItemAtIndexPath(indexPath) as! CardCollectionViewCell
    
    // name image according to indexPath.row in conjuction with array postion of card
    cell.cell.image = UIImage(named: "club-1.png")
    
    return cell
  }
}

// MARK: UICollectionViewFlowLayout
//extension MyCollectionViewController: UICollectionViewFlowLayout {
//  
//}
