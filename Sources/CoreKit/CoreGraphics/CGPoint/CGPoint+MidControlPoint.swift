//
//  CGPoint+MidControlPoint.swift
//  CoreKit
//
//  Created by Tibor Bödecs on 2017. 09. 27..
//  Copyright © 2017. Tibor Bödecs. All rights reserved.
//

import CoreGraphics.CGGeometry


public extension CGPoint {
    
    /**
     Gets the middle control point (bezier path) from a given point
     
     - parameter _ point: The another point
     - returns: The middle control point
     */
    public func midControlPoint(_ point: CGPoint) -> CGPoint {
        var controlPoint = self.midPoint(point)
        let diffY = CGFloat(abs(point.y - controlPoint.y))
        if self.y < point.y {
            controlPoint.y += diffY
        }
        else if self.y > point.y {
            controlPoint.y -= diffY
        }
        return controlPoint
    }
}
