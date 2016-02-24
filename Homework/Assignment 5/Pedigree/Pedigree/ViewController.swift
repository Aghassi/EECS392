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
  var rendered: [Int] = []

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
    
    for person in pedigree {
      if person.fatherID > 0 && person.motherID > 0 {
        pedigree[person.fatherID-1].children.append(person.individualID-1)
        pedigree[person.motherID-1].children.append(person.individualID-1)
      }
    }
    
    renderPedigreeChart()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  /**
    Render each square on the same line as long as the people don't have parents
    Each new line will consist of relatives (we assume the list is ordered as such)
    If we tag each layer before we add them to the view, we can query the tags by individualID to see if the 
    person people are married to already is rendered
  */
  
  func renderPedigreeChart() {
    let edgeLength = (self.view.bounds.width + self.view.bounds.height) / 20.0
    
    var originX = CGFloat(20.0)
    var originY = CGFloat(20.0)
  
    for person in pedigree {
      if (person.fatherID == 0 && person.motherID == 0) {
        // male
        if (person.gender == 1) {
          renderMale(originX, y: originY, edgeLength: edgeLength, person: person)
          
          if (person.children.count > 0) {
            for child in person.children {
              if !rendered.contains(child) {
                var childOriginY: CGFloat = 0.0
                
                if pedigree[child].gender == 1 {
                  childOriginY = originY + edgeLength + 25.0
                  renderMale(originX, y: childOriginY, edgeLength: edgeLength, person: pedigree[child])
                }
                else {
                  let radius = edgeLength/1.8
                  childOriginY = originY + radius + 75.0
                  renderFemale(originX, y: childOriginY, radius: radius, person: pedigree[child])
                }
                let start = CGPoint(x: originX + edgeLength/2, y: childOriginY)
                let origin = CGPoint(x: originX + edgeLength/2, y: originY)
                drawLine(start, end: origin)
                rendered.append(child)
              }
            }
          }
        }
        // female
        else {
          let origin = CGPoint(x: originX + 30, y: originY + 30.0)
          let radius = edgeLength/1.8
          drawCircle(origin, radius: radius, person: person)
          rendered.append(person.individualID)
          
          if (person.children.count > 0) {
            for child in person.children {
              if !rendered.contains(child) {
                var childOriginY: CGFloat = 0.0
                
                if pedigree[child].gender == 1 {
                  childOriginY = originY + edgeLength + 25.0
                  renderMale(originX, y: childOriginY, edgeLength: edgeLength, person: pedigree[child])
                }
                else {
                  let radius = edgeLength/1.8
                  childOriginY = originY + radius + 75.0
                  renderFemale(originX, y: childOriginY, radius: radius, person: pedigree[child])
                }
                let start = CGPoint(x: originX + edgeLength/2, y: childOriginY)
                let origin = CGPoint(x: originX + edgeLength/2, y: originY)
                drawLine(start, end: origin)
                rendered.append(child)
              }
            }
          }
        }
        
       originX += originX + edgeLength + 10
      }
    }
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

