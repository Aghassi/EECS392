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
  
  @IBOutlet weak var pedigreeNameLabel: UILabel!
  @IBOutlet weak var affectedOutlet: UITextField!
  @IBOutlet weak var fatherLabel: UILabel!
  @IBOutlet weak var motherLabel: UILabel!
  @IBOutlet weak var genderLabel: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    pedigreeNameLabel.text = "Person: \(tappedCellData.individualID)"
    fatherLabel.text = "\(tappedCellData.fatherID)"
    motherLabel.text = "\(tappedCellData.motherID)"
    genderLabel.text = "\(tappedCellData.gender)"
    affectedOutlet.text = "\(tappedCellData.affected)"


    
    // Do any additional setup after loading the view.
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  

  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    tappedCellData.affected = Int(affectedOutlet.text!)!
  }
  
}
