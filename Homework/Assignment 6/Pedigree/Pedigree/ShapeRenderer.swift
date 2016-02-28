//
//  ShapeRenderer.swift
//  Pedigree
//
//  Created by David Aghassi on 2/28/16.
//  Copyright © 2016 David Aghassi. All rights reserved.
//

import UIKit

/// A class for rendering shapes on screen
class ShapeRenderer: NSObject {
  
  /**
   Draws a rectangle
   
   - parameter rect:   The `CGRect` to be drawn
   - parameter person: The data that denotes the properties of the rect
   
   - returns: `CAShapeLayer`
   */
  static func drawRect(rect: CGRect, person: PedigreeData) -> CAShapeLayer {
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
    
    shapeLayer.contentsScale = UIScreen.mainScreen().scale
    return shapeLayer
  }
  
  /**
   Draws a circle
   
   - parameter origin: Center of the circle as `CGPoint`
   - parameter radius: Radius of the circle as `CGFloat`
   - parameter person: The data that denotes how the ciricle will be drawn
   
   - returns: `CAShapeLayer`
   */
  static func drawCircle(origin: CGPoint, radius: CGFloat, person: PedigreeData) -> CAShapeLayer {
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
    
    shapeLayer.contentsScale = UIScreen.mainScreen().scale
    return shapeLayer
  }
  
  /**
   Draws a line and adds it to the sublayer of the canvas
   
   - parameter start: The beginning CGPoint
   - parameter end:   The ending CGPoint
   - returns: CAShapeLayer
   */
  static func drawLine(start: CGPoint, end: CGPoint) -> CAShapeLayer {
    let path = UIBezierPath()
    path.moveToPoint(start)
    path.addLineToPoint(end)
    path.closePath()
    
    let shapeLayer = CAShapeLayer()
    shapeLayer.strokeColor = UIColor.blackColor().CGColor
    shapeLayer.path = path.CGPath
    shapeLayer.lineWidth = 1.0
    
    shapeLayer.contentsScale = UIScreen.mainScreen().scale
    return shapeLayer
  }
  
}
