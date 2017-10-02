//
//  CGPoint+MidPoint.swift
//  CoreKit
//
//  Created by Tibor Bödecs on 2017. 09. 27..
//  Copyright © 2017. Tibor Bödecs. All rights reserved.
//

import CoreGraphics.CGGeometry


public extension CGPoint {
    
    /**
     Calculates the midpoint between two points
     
     - parameter _ point: The other point to do the math
     - returns: The point between the two points
     */
    public func midPoint(_ point: CGPoint) -> CGPoint {
        return CGPoint(x: (self.x + point.x)/2.0, y: (self.y + point.y)/2.0)
    }
}


