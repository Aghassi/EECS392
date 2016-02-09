//
//  ViewController.swift
//  PerfectNumbers
//
//  Created by David Aghassi on 2/2/16.
//  Copyright © 2016 David Aghassi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  @IBOutlet weak var startRangeTextField: UITextField!
  @IBOutlet weak var endRangeTextField: UITextField!

  @IBAction func calculatePerfectNumber(sender: UIButton) {
    guard let startText = startRangeTextField.text else {
      return
    }
    guard let endText = endRangeTextField.text else {
      return
    }
    guard let start = Int(startText) else {
      return
    }
    guard let end = Int(endText) else {
      return
    }
    
    let hasPerfectNumber = isPerfectNumber(start, end: end)
    if hasPerfectNumber.0 {
      let dialog = UIAlertController(title: "There is a perfect number", message: "The first perfect number is \(hasPerfectNumber.1)", preferredStyle: .Alert)
      self.presentViewController(dialog, animated: true, completion: nil)
    }
    else {
      let dialog = UIAlertController(title: "There is not a perfect number", message: nil, preferredStyle: .Alert)
      self.presentViewController(dialog, animated: true, completion: nil)
    }
  }
  
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
    
    for (var numberToCheck = start; numberToCheck < end; numberToCheck++) {
      if (numberToCheck == 0) {
        continue
      }
      
      // Don't include number itself to check
      for (var index = numberToCheck-1; index > 0; index-- ) {
        if numberToCheck % index == 0 {
          sumSoFar += index
        }
      }
      
      if sumSoFar == numberToCheck {
        return (true, numberToCheck)
      }
      else {
        sumSoFar = 0
      }
    }
    
    return (false, 0)
  }

}

// MARK : UITextFieldDelegate
extension ViewController: UITextFieldDelegate {
  
  func textFieldShouldReturn(textField: UITextField) -> Bool {
    return true
  }
  
}
