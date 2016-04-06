//
//  ViewController.swift
//  IconShortcutDemo
//
//  Created by David Aghassi on 4/6/16.
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

  /**
   Used to dismiss a popover view back to the root parent
   
   - parameter sender: The sender calling the function. Used to set the view to `sourceViewConroller`
   */
  @IBAction func unwindToMain(sender: UIStoryboardSegue) {
    _ = sender.sourceViewController
  }
}

