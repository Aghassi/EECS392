//
//  PedigreeDetailViewController.swift
//  Pedigree
//
//  Created by David Aghassi on 3/17/16.
//  Copyright © 2016 David Aghassi. All rights reserved.
//

import UIKit

class PedigreeDetailViewController: UIViewController {
  
  var tappedCellData: PedigreeData = PedigreeData(individual: 0, father: 0, mother: 0, gender: 0)
  
  
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
