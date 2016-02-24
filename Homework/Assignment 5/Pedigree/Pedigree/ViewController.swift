//
//  ViewController.swift
//  Pedigree
//
//  Created by David Aghassi on 2/23/16.
//  Copyright © 2016 David Aghassi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  var pedigree: [PedigreeData] = []

  override func viewDidLoad() {
    super.viewDidLoad()

    /**
     familyID, individualID, fatherID, motherID, gender (1: male, 2:female), affected status(1: affected, 0:not)
      1   1   0  0  1  1
      1   2   0  0  2  0
      1   3   0  0  1  0
      1   4   1  2  2  1
      1   5   3  4  2  1
      1   6   3  4  1  0
      */
    let person = PedigreeData(individual: 1, father: 0, mother: 0, gender: 1)
    person.affected = 1
    person.marriedTo = 2
    
    let personTwo = PedigreeData(individual: 2, father: 0, mother: 0, gender: 2)
    personTwo.marriedTo = 1
    
    let personThree = PedigreeData(individual: 3, father: 0, mother: 0, gender: 1)
    personThree.marriedTo = 4
    
    let personFour = PedigreeData(individual: 4, father: 1, mother: 2, gender: 2)
    personFour.affected = 1
    personFour.marriedTo = 3
    
    let personFive = PedigreeData(individual: 5, father: 3, mother: 4, gender: 2)
    personFive.affected = 1
    
    let personSix = PedigreeData(individual: 6, father: 3, mother: 4, gender: 1)
    
    
    pedigree = [person, personTwo, personThree, personFour, personFive, personSix]
    // Do any additional setup after loading the view, typically from a nib.
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


}

