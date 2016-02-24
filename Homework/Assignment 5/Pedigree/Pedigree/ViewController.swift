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

  @IBOutlet weak var pedigreeOne: UIView!
  @IBOutlet weak var pedigreeTwo: UIView!
  @IBOutlet weak var pedigreeThree: UIView!
  @IBOutlet weak var pedigreeFour: UIView!
  @IBOutlet weak var pedigreeFive: UIView!
  @IBOutlet weak var pedigreeSix: UIView!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()

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
        renderFemale(x, y: midY, radius: radius, person: person)
      } else {
        renderMale(x, y: y, edgeLength: length, person: person)
      }
      
      if person.marriedTo > 0 {
        
        let endMidX = chart[person.marriedTo-1].layer.frame.midX
        let endMidY = chart[person.marriedTo-1].layer.frame.midY
        let end = CGPoint(x: endMidX, y: endMidY)
        drawLine(start, end: end)
      }
      
      if person.fatherID > 0 && person.motherID > 0 {
        let fatherOriginMid = CGPoint(x: chart[person.fatherID-1].layer.frame.midX, y: chart[person.fatherID-1].layer.frame.midY)
        let motherOriginMid = CGPoint(x: chart[person.motherID-1].layer.frame.midX, y: chart[person.motherID-1].layer.frame.midY)
        
        let midPointX = (fatherOriginMid.x + motherOriginMid.x) / 2.0
        let midPointY = (fatherOriginMid.y + motherOriginMid.y) / 2.0
        
        let end = CGPoint(x: midPointX, y: midPointY)
        
        drawLine(start, end: end)
      }
    }
    
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
  
  func renderMale(x: CGFloat, y: CGFloat, edgeLength: CGFloat, person: PedigreeData) {
    let rect = CGRectMake(x, y, edgeLength, edgeLength)
    drawRect(rect, person: person)
    rendered.append(person.individualID)
  }
  
  func renderFemale(x: CGFloat, y: CGFloat, radius: CGFloat, person: PedigreeData) {
    let origin = CGPoint(x: x + 30, y: y)
    drawCircle(origin, radius: radius, person: person)
  }

  
  func drawRect(rect: CGRect, person: PedigreeData) {
    let path = UIBezierPath(rect: rect)
    let shapeLayer = CAShapeLayer()
    shapeLayer.path = path.CGPath
    
    if person.affected > 0 {
      shapeLayer.strokeColor = UIColor.redColor().CGColor
      shapeLayer.fillColor = UIColor.redColor().CGColor
    }
    else {
      shapeLayer.strokeColor = UIColor.redColor().CGColor
      shapeLayer.fillColor = UIColor.clearColor().CGColor
    }
    
    shapeLayer.lineWidth = 2.0
    shapeLayer.name = person.individualID.description
    view.layer.addSublayer(shapeLayer)
  }

  func drawCircle(origin: CGPoint, radius: CGFloat, person: PedigreeData) {
    let path = UIBezierPath(arcCenter: origin, radius: radius, startAngle: 0, endAngle: CGFloat(2.0 * M_PI), clockwise: true)
    let shapeLayer = CAShapeLayer()
    shapeLayer.path = path.CGPath
    
    if person.affected > 0 {
      shapeLayer.strokeColor = UIColor.redColor().CGColor
      shapeLayer.fillColor = UIColor.redColor().CGColor
    }
    else {
      shapeLayer.strokeColor = UIColor.redColor().CGColor
      shapeLayer.fillColor = UIColor.clearColor().CGColor
    }

    shapeLayer.lineWidth = 2.0
    shapeLayer.name = person.individualID.description
    view.layer.addSublayer(shapeLayer)
  }
  
  func drawLine(start: CGPoint, end: CGPoint) {
    let path = UIBezierPath()
    path.moveToPoint(start)
    path.addLineToPoint(end)
    path.closePath()
    
    let shapeLayer = CAShapeLayer()
    shapeLayer.strokeColor = UIColor.blackColor().CGColor
    shapeLayer.path = path.CGPath
    shapeLayer.lineWidth = 1.0
    view.layer.addSublayer(shapeLayer)

  }
}

