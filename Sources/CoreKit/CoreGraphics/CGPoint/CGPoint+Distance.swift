//
//  CGPoint+Distance.swift
//  CoreKit
//
//  Created by Tibor Bödecs on 2017. 09. 27..
//  Copyright © 2017. Tibor Bödecs. All rights reserved.
//

import CoreGraphics.CGGeometry


public extension CGPoint {
    
    /**
     Checks the distance from another point
     
     - parameter from: The point to measure the distance
     - returns: The distance from the other point
     */
    public func distance(from: CGPoint) -> CGFloat {
        let xDist = (from.x - self.x);
        let yDist = (from.y - self.y);
        return sqrt((xDist * xDist) + (yDist * yDist));
    }
}

