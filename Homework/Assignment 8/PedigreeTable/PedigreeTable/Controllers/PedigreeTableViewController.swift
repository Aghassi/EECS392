//
//  PedigreeTableViewController.swift
//  PedigreeTable
//
//  Created by David Aghassi on 3/26/16.
//  Copyright © 2016 David Aghassi. All rights reserved.
//

import UIKit

class PedigreeTableViewController: UITableViewController {
  private let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
  private var pedigrees = [Pedigree]()
  private var selectedPedigree: Pedigree?
  
  enum Storyboard: String {
    case segueIdentifier = "selectedPedigree"
    case reuseIdentifier = "PedigreeCell"
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Get pedigrees
    pedigrees = appDelegate.pedigrees
    
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
    return pedigrees.count
  }
  
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier(Storyboard.reuseIdentifier.rawValue, forIndexPath: indexPath)
    
    let proband = pedigrees[indexPath.row].proband
    
    cell.textLabel?.text = "Proband: \(proband!.name.first) \(proband!.name.last)"
    
    return cell
  }
  
  override func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
    selectedPedigree = pedigrees[indexPath.row]
    return indexPath
  }

  
  // MARK: - Navigation
  
  // In a storyboard-based application, you will often want to do a little preparation before navigation
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == Storyboard.segueIdentifier.rawValue {
      let destinationController = segue.destinationViewController as! SelectedPedigreeTableViewController
      destinationController.selectedPedigree = selectedPedigree
      destinationController.navigationItem.title = (selectedPedigree?.proband?.name.last)! + " Family"
    }
    
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
  }
  
}
