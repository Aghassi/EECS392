//
//  Individual.swift
//  PedigreeTable
//
//  Created by David Aghassi on 3/24/16.
//  Copyright © 2016 David Aghassi. All rights reserved.
//

import UIKit

class Individual: NSObject {
  enum Gender {
    case MALE
    case FEMALE
  }
  
  //least have these attributes: ID, First Name, Last Name, Gender, pointers to father and mother, disease status
  var ID: Int = 0
  var name = (first: "", last: "")
  var gender = Gender.FEMALE
  var mother = Individual()
  var father = Individual()
  
  override init() {
    super.init()
  }
  
  /**
   Sets the individual. Requires `ID`, `name`, `gender`. `father` and `mother` can be applied after if any
   
   - parameter id:     id of the individual
   - parameter name:   Tuple consisting of `first` and `last` that are strings
   - parameter gender: `Gender.MALE` or `Gender.FEMALE`
   
   - returns: An individual
   */
  init (id: Int, name: (String, String), gender: Gender) {
    ID = id
    self.name = name
    self.gender = gender
  }
}
