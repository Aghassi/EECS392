//
//  ViewController.swift
//  PerfectNumbers
//
//  Created by David Aghassi on 2/2/16.
//  Copyright © 2016 David Aghassi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  // MARK: Logic
  func isPerfectNumber(start: Int, end: Int) -> (Bool, Int) {
    var sumSoFar = 0
    
    for (var index = 0; index < end; index++) {
      if ( (start+index) % index == 0) {
        sumSoFar += index;
      }
      if ((start+index) == sumSoFar) {
        return (true, (start+index))
      }
    }
    
    return (false, 0)
  }

}

