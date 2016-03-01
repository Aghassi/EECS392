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
    
    chart = [pedigreeOne, pedigreeTwo, pedigreeThree, pedigreeFour, pedigreeFive, pedigreeSix]
    for view in chart {
      view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "highlight:"))
    }
    
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
    
    for person in pedigree {
      if person.fatherID > 0 && person.motherID > 0 {
        pedigree[person.fatherID-1].children.append(person.individualID-1)
        pedigree[person.motherID-1].children.append(person.individualID-1)
      }
    }
    
    renderPedigree()
  }
  
  /**
   Renders the pedigree chart
   */
  func renderPedigree() {
    for person in pedigree {
      chart[person.individualID-1].backgroundColor = UIColor.clearColor()
      let y = chart[person.individualID-1].bounds.origin.y
      let x = chart[person.individualID-1].bounds.origin.x
      
      let midX = chart[person.individualID-1].bounds.maxX / 2.0
      let midY = chart[person.individualID-1].bounds.maxY / 2.0
      
      let length = chart[person.individualID-1].bounds.width
      let radius = length / 2.0
      
      let startMidX = chart[person.individualID-1].bounds.midX
      let startMidY = chart[person.individualID-1].bounds.midY
      let start = CGPoint(x: startMidX, y: startMidY)
      
      // male
      if person.gender == 1 {
        renderMale(x, y: y, edgeLength: length, person: person)
      } else {
        renderFemale(midX, y: midY, radius: radius, person: person)
      }
      
      if person.marriedTo > 0 && !rendered.contains(person.marriedTo){
        let endMidX = 150.0
        let endMidY = 40.0
        let end = CGPoint(x: endMidX, y: endMidY)
        let line = ShapeRenderer.drawLine(start, end: end)
        let view = chart[person.individualID-1]
        view.layer.addSublayer(line)
      }
      else {
        let line = ShapeRenderer.drawLine(start, end: start)
        let view = chart[person.individualID-1]
        view.layer.addSublayer(line)
      }

      if person.fatherID > 0 && person.motherID > 0 {
        // Hard coded for this assignment, no better way to do it due to time constraints
        var end: CGPoint
        var start: CGPoint
        
        if person.individualID % 2 == 0 {
          let midPointX = CGFloat(35.0)
          let midPointY = CGFloat(50.0)
          end = CGPoint(x: -1 * midPointX, y: -1 * midPointY)
          start = CGPoint(x: 50, y: 35)
        }
        else {
          let midPointX = CGFloat(85.0)
          let midPointY = CGFloat(55.0)
          end = CGPoint(x: midPointX, y: -1 * midPointY)
          start = CGPoint(x: 15, y: 35)
        }
        
        
        let line = ShapeRenderer.drawLine(start, end: end)
        let view = chart[person.individualID-1]
        view.layer.addSublayer(line)
      }
      
      while chart[person.individualID-1].layer.sublayers?.count < 3 {
        let line = ShapeRenderer.drawLine(start, end: start)
        let view = chart[person.individualID-1]
        view.layer.addSublayer(line)
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
    let view = chart[person.individualID-1]
    view.layer.addSublayer(drawnRectangle)
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
    let origin = CGPoint(x: x, y: y)
    let circle = ShapeRenderer.drawCircle(origin, radius: radius, person: person)
    let view = chart[person.individualID-1]
    view.layer.addSublayer(circle)
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
  
  /**
   Draws changes the stroke and stroke width of the pedigree box selected
   
   - parameter gesture: Tap gesture
   */
  func highlight(gesture: UITapGestureRecognizer) {
    if let view = gesture.view {
      let shapeLayer = view.layer.sublayers?.first as! CAShapeLayer
      if shapeLayer.lineWidth == 3.0 {
        // unselect
        shapeLayer.lineWidth = 2.0
        shapeLayer.strokeColor = UIColor.redColor().CGColor
      }
      else {
        //select
        shapeLayer.lineWidth = 3.0
        shapeLayer.strokeColor = UIColor.purpleColor().CGColor
      }
    }
  }
  
  /**
   Handles panning of the view
   
   - parameter recognizer: The view being panned by a gesture.
   */
  @IBAction func handlePan(recognizer:UIPanGestureRecognizer) {
    let translation = recognizer.translationInView(self.view)
    if let view = recognizer.view {
      view.center = CGPoint(x:view.center.x + translation.x,
        y:view.center.y + translation.y)
    }
    recognizer.setTranslation(CGPointZero, inView: self.view)
  }
}

