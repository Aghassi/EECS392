//
//  ViewController.swift
//  Pedigree
//
//  Created by David Aghassi on 2/23/16.
//  Copyright © 2016 David Aghassi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  var pedigree: [PedigreeData] = []
  var chart: [UIView] = []
  var rendered: [Int] = []
  
  @IBOutlet weak var canvas: UIView!
  @IBOutlet weak var pedigreeOne: UIView!
  @IBOutlet weak var pedigreeTwo: UIView!
  @IBOutlet weak var pedigreeThree: UIView!
  @IBOutlet weak var pedigreeFour: UIView!
  @IBOutlet weak var pedigreeFive: UIView!
  @IBOutlet weak var pedigreeSix: UIView!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Add recognizer for pinch and zoom
    canvas.addGestureRecognizer(UIPinchGestureRecognizer(target: self, action: "scale:"))
    
    /**
     familyID, individualID, fatherID, motherID, gender (1: male, 2:female), affected status(1: affected, 0:not)
     1   1   0  0  1  1
     1   2   0  0  2  0
     1   3   0  0  1  0
     1   4   1  2  2  1
     1   5   3  4  2  1
     1   6   3  4  1  0
     */
    let person = PedigreeData(individual: 1, father: 0, mother: 0, gender: 1)
    person.affected = 1
    person.marriedTo = 2
    
    let personTwo = PedigreeData(individual: 2, father: 0, mother: 0, gender: 2)
    personTwo.marriedTo = 1
    
    let personThree = PedigreeData(individual: 3, father: 0, mother: 0, gender: 1)
    personThree.marriedTo = 4
    
    let personFour = PedigreeData(individual: 4, father: 1, mother: 2, gender: 2)
    personFour.affected = 1
    personFour.marriedTo = 3
    
    let personFive = PedigreeData(individual: 5, father: 3, mother: 4, gender: 2)
    personFive.affected = 1
    
    let personSix = PedigreeData(individual: 6, father: 3, mother: 4, gender: 1)
    
    
    pedigree = [person, personTwo, personThree, personFour, personFive, personSix]
    chart = [pedigreeOne, pedigreeTwo, pedigreeThree, pedigreeFour, pedigreeFive, pedigreeSix]
    
    for person in pedigree {
      if person.fatherID > 0 && person.motherID > 0 {
        pedigree[person.fatherID-1].children.append(person.individualID-1)
        pedigree[person.motherID-1].children.append(person.individualID-1)
      }
    }
    
    for person in pedigree {
      chart[person.individualID-1].backgroundColor = UIColor.clearColor()
      let y = chart[person.individualID-1].layer.frame.origin.y
      let x = chart[person.individualID-1].layer.frame.origin.x
      
      let midX = chart[person.individualID-1].layer.frame.midX
      let midY = chart[person.individualID-1].layer.frame.midY
      
      let radius = chart[person.individualID-1].layer.frame.width / 2.0
      let length = chart[person.individualID-1].layer.frame.width
      
      let start = CGPoint(x: midX, y: midY)
      
      // male
      if person.gender == 1 {
        renderMale(x, y: y, edgeLength: length, person: person)
      } else {
        renderFemale(x, y: midY, radius: radius, person: person)
      }
      
      if person.marriedTo > 0 {
        
        let endMidX = chart[person.marriedTo-1].layer.frame.midX
        let endMidY = chart[person.marriedTo-1].layer.frame.midY
        let end = CGPoint(x: endMidX, y: endMidY)
        let line = ShapeRenderer.drawLine(start, end: end)
        canvas.layer.addSublayer(line)
      }
      
      if person.fatherID > 0 && person.motherID > 0 {
        let fatherOriginMid = CGPoint(x: chart[person.fatherID-1].layer.frame.midX, y: chart[person.fatherID-1].layer.frame.midY)
        let motherOriginMid = CGPoint(x: chart[person.motherID-1].layer.frame.midX, y: chart[person.motherID-1].layer.frame.midY)
        
        let midPointX = (fatherOriginMid.x + motherOriginMid.x) / 2.0
        let midPointY = (fatherOriginMid.y + motherOriginMid.y) / 2.0
        
        let end = CGPoint(x: midPointX, y: midPointY)
        
        let line = ShapeRenderer.drawLine(start, end: end)
        canvas.layer.addSublayer(line)
      }
    }
    
  }
  
  /**
   Draws a male represenation on the pedigree
   
   - parameter x:          The `x` point on the canvas
   - parameter y:          The `y` point on the canvas
   - parameter edgeLength: The edge length of the rectangle to be drawn
   - parameter person:     The data of the person the rectangle will represent
   */
  func renderMale(x: CGFloat, y: CGFloat, edgeLength: CGFloat, person: PedigreeData) {
    let rect = CGRectMake(x, y, edgeLength, edgeLength)
    let drawnRectangle = ShapeRenderer.drawRect(rect, person: person)
    canvas.layer.addSublayer(drawnRectangle)
    rendered.append(person.individualID)
  }
  
  /**
   Draws a female represenation on the pedigree
   
   - parameter x:      The `x` point on the canvas
   - parameter y:      The `y` point on the canvas
   - parameter radius: The `radius` of the circle to represent the female
   - parameter person: The data of the person the circle will represent
   */
  func renderFemale(x: CGFloat, y: CGFloat, radius: CGFloat, person: PedigreeData) {
    let origin = CGPoint(x: x + 30, y: y)
    let circle = ShapeRenderer.drawCircle(origin, radius: radius, person: person)
    canvas.layer.addSublayer(circle)
    rendered.append(person.individualID)
  }
  
  /**
   Scales the canvas that the pedigree is rendered on
   
   - parameter sender: `UIPinchGestureRecognizer` from which we derive the scale
   */
  func scale(sender: UIPinchGestureRecognizer) {
    if let view = sender.view {
      canvas.transform = CGAffineTransformScale(view.transform,
        sender.scale, sender.scale)
      sender.scale = 1
    }
  }
}
