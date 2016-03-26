//
//  Pedigree.swift
//  PedigreeTable
//
//  Created by David Aghassi on 3/26/16.
//  Copyright © 2016 David Aghassi. All rights reserved.
//

import UIKit

class Pedigree: NSObject {
  var family = [Individual]()
  var proband = Individual()

  /**
   Creates a new Pedigree object. Contains an array of `Individuals` and a `Proband`
   
   - parameter family:  Array of `Individuals`
   - parameter proband: a person serving as the starting point for the genetic study of a family (used especially in medicine and psychiatry).
   
   - returns: A `Pedigree` object
   */
  init(family: [Individual], proband: Individual) {
    self.family = family
    self.proband = proband
  }
}
