//
//  SelectedPedigreeTableViewController.swift
//  PedigreeTable
//
//  Created by David Aghassi on 3/26/16.
//  Copyright © 2016 David Aghassi. All rights reserved.
//

import UIKit

class SelectedPedigreeTableViewController: UITableViewController {
  var selectedPedigree: Pedigree?
  var family: [Individual]? {
    return selectedPedigree?.family
  }
  
  enum Storyboard: String {
    case selectedIdentifier = "selectIndividual"
    case addIdentifier = "addIndividual"
    case reuseIdentifier = "IndividualCell"
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = false
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  // MARK: - Table view data source
  
  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    // #warning Incomplete implementation, return the number of sections
    return 1
  }
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // #warning Incomplete implementation, return the number of rows
    if (family != nil) {
      return (family?.count)!
    }
    else {
      return 0
    }
  }
  
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier(Storyboard.reuseIdentifier.rawValue, forIndexPath: indexPath)
    
    if family != nil {
      let individual = family![indexPath.row]
      
      cell.textLabel?.text = "\(individual.name.first) \(individual.name.last)"
      
      if (individual.father != nil) {
        // force unwrapping is bad, but I'm doing it because of time required for this assignment and how much I need to get done in a week
        let fatherName = "\(individual.father!.name.first) \(individual.father!.name.last)"
        let motherName = "\(individual.mother!.name.first) \(individual.mother!.name.last)"
        cell.detailTextLabel?.text = "Father: \(fatherName), Mother: \(motherName)"
      }
      else {
        cell.detailTextLabel?.text = ""
      }
    }
    
    return cell
  }
  
  // MARK: - Navigation
  
  // In a storyboard-based application, you will often want to do a little preparation before navigation
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == Storyboard.addIdentifier.rawValue {
      let destinationController = segue.destinationViewController as! IndividualDataViewController
      destinationController.individual = nil
      destinationController.navigationItem.title = ""
    }
    if segue.identifier == Storyboard.selectedIdentifier.rawValue {
      let selectedRow = tableView.indexPathForSelectedRow?.row
      let destinationController = segue.destinationViewController as! IndividualDataViewController
      destinationController.individual = family![selectedRow!]
      destinationController.navigationItem.title = (destinationController.individual?.name.first)! + " " + (destinationController.individual?.name.last)!
    }
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
  }
  
  
}
