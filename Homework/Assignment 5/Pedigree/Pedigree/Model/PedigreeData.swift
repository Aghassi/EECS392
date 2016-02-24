//
//  PedigreeData.swift
//  Pedigree
//
//  Created by David Aghassi on 2/23/16.
//  Copyright © 2016 David Aghassi. All rights reserved.
//

import UIKit

class PedigreeData: NSObject {
  // familyID, individualID, fatherID, motherID, gender (1: male, 2:female), affected status(1: affected, 0:not)
  var familyID: Int = 0
  var individualID: Int = 0
  var fatherID: Int = 0
  var motherID: Int = 0
  var gender: Int = 0
  var affected: Int = 0
  
  init(individual: Int, father: Int, mother: Int, gender: Int) {
    super.init()
    individualID = individual
    fatherID = father
    motherID = mother
    self.gender = gender
  }

}
