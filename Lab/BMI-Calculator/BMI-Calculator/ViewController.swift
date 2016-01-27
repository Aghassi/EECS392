//
//  ViewController.swift
//  BMI-Calculator
//
//  Created by David Aghassi on 1/15/16.
//  Copyright © 2016 David Aghassi. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var heightTextField: UITextField!
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var bmiLabel: UILabel!

    var height: Double?
    var weight: Double?
    
    // Calculated value
    var BMI: Double {
        get {
            if let w = weight {
                if let h = height {
                    return (w * 703)/((h)*(h))
                }
            }
            return 0.0
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField == heightTextField {
            height = Double(heightTextField.text!)
        }
        if textField == weightTextField {
            weight = Double(weightTextField.text!)
        }
        textField.resignFirstResponder()
        self.update()
        print("We are here")
        return true
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesBegan(touches, withEvent: event)
        
    }
    
    /**
     Updates the `bmiLabel` based on weight and height
    */
    func update() {
        // `BMI` will calculate its own value since it doesn't have one
        bmiLabel.text = "BMI: " + String(self.BMI)
    }
}