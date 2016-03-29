//
//  IndividualDataViewController.swift
//  PedigreeTable
//
//  Created by David Aghassi on 3/27/16.
//  Copyright © 2016 David Aghassi. All rights reserved.
//

import UIKit

class IndividualDataViewController: UIViewController {
  var individual: Individual?
  
  // MARK: - Outlets
  @IBOutlet weak var nameTextField: UITextField!
  @IBOutlet weak var genderTextField: UITextField!
  @IBOutlet weak var motherTextField: UITextField!
  @IBOutlet weak var fatherTextField: UITextField!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    if individual != nil {
      nameTextField.text = "\(individual!.name.first)"
      
      if individual!.father != nil {
        // This does count for the case when you could have one father and no mother
        fatherTextField.text = "\(individual!.father!.name.first)"
        motherTextField.text = "\(individual!.mother!.name.first)"
      }
      else {
        fatherTextField.text = ""
        motherTextField.text = ""
      }
      
      if let gender = individual?.gender?.rawValue {
        switch gender {
        case 0:
          genderTextField.text = "Male"
        case 1:
          genderTextField.text = "Female"
        default:
          genderTextField.text = "It"
        }
      }
    }
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
