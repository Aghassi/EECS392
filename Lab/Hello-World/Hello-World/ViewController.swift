//
//  ViewController.swift
//  Hello-World
//
//  Created by David Aghassi on 1/15/16.
//  Copyright © 2016 David Aghassi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var myTextField: UITextField!
    @IBOutlet weak var myLabel: UILabel!

    /**
     Clicking the button with set the text of `myLabel` to text of `myTextField`
     */
    @IBAction func buttonClicked(sender: UILabel) {
        //: Sender is who is sending this function, in this case it is
        //: A UILabel
        
        //: We only handle the optional if it exists
        //: Interpolation would create Optional(`contents`)
        //: Force casting is dangerous and we should avoid it eg `myTextField.text!`
        if let textFieldString = myTextField.text {
            myLabel.text = "Hello " + textFieldString
        }
        
        //: Hide the keyboard when pressed
        self.view.endEditing(true)
    }
}

