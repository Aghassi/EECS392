//
//  SelectedPedigreeTableViewController.swift
//  PedigreeTable
//
//  Created by David Aghassi on 3/26/16.
//  Copyright © 2016 David Aghassi. All rights reserved.
//

import UIKit

class SelectedPedigreeTableViewController: UITableViewController {
  private let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
  var selectedPedigree: Pedigree?
  var family: [Individual]? 
  
  enum Storyboard: String {
    case selectedIdentifier = "selectIndividual"
    case addIdentifier = "addIndividual"
    case saveIndividual = "saveIndividual"
    case reuseIdentifier = "IndividualCell"
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    family = selectedPedigree?.family
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = false
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem()
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    
    tableView.reloadData()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  @IBAction func individualWasSaved(segue: UIStoryboardSegue, sender: AnyObject) {
    if segue.identifier == Storyboard.saveIndividual.rawValue {
      let senderController = sender.sourceViewController as! IndividualDataViewController
      let individualToSave = senderController.individual
      if let individual = individualToSave {
      
        individual.name.first = senderController.nameTextField.text!
        individual.name.last = (family![0] as Individual).name.last
        switch senderController.genderTextField.text! {
          case "Male":
            individual.gender = Gender.MALE
          case "Female":
            individual.gender = Gender.FEMALE
          default:
            individual.gender = Gender.FEMALE
        }
        
        // I should have done this differently, I would have prefered to find the actual individual. Or just stored the name
        if let father = senderController.fatherTextField.text {
          individual.father = Individual(id: -1, name: ("\(father)", ""), gender: Gender.MALE)
        }
        
        if let mother = senderController.motherTextField.text {
          individual.mother = Individual(id: -1, name: ("\(mother)", ""), gender: Gender.FEMALE)
        }
      
        if individual.ID > family?.count {
          family?.append(individual)
        }
        else {
          family?[individual.ID] = individual
        }
        
        selectedPedigree?.family = family!
        let index = appDelegate.pedigrees.indexOf(selectedPedigree!)
        appDelegate.pedigrees[index!] = selectedPedigree!
      }
    }
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
      destinationController.individual = Individual(id: (family?.count)!+1, name: ("", ""), gender: Gender.FEMALE)
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
