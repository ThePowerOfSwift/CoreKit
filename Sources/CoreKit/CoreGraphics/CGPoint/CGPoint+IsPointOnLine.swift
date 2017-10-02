//
//  CGPoint+IsPointOnLine.swift
//  CoreKit
//
//  Created by Tibor Bödecs on 2017. 09. 27..
//  Copyright © 2017. Tibor Bödecs. All rights reserved.
//

import CoreGraphics.CGGeometry


public extension CGPoint {
    
    /**
     Checks if a point is on a line
     
     - parameter _ first: The first point of a line
     - parameter _ second: The second point of a line
     - returns: True if the point is on the line, false otherwise
     */
    public func isPointOnLine(_ first: CGPoint, _ second: CGPoint) -> Bool {
        return (first.y - self.y) * (first.x - second.x) == (first.y - second.y) * (first.x - self.x)
    }
}
