//
//  CGPath+SmoothLine.swift
//  CoreKit
//
//  Created by Tibor Bödecs on 2017. 09. 27..
//  Copyright © 2017. Tibor Bödecs. All rights reserved.
//

import CoreGraphics.CGGeometry


public extension CGPath {
    
    /**
     Creates a smooth CGPath using middle bezier curve control points from the given points of array
     
     - parameter points: The array of points
     - returns: The line created from the points
     */
    public static func smoothLine(points: [CGPoint]) -> CGMutablePath {
        let path = CGMutablePath()

        guard let firstPoint = points.first else {
            return path
        }

        path.move(to: firstPoint)
        if let lastPoint = points.last, points.count == 2 {
            path.addLine(to: lastPoint)
            return path
        }

        var previousPoint = firstPoint
        for point in points {
            let midPoint = previousPoint.midPoint(point)
            let firstControlPoint = midPoint.midControlPoint(previousPoint)
            let secondControlPoint = midPoint.midControlPoint(point)
            
            path.addQuadCurve(to: midPoint, control: firstControlPoint)
            path.addQuadCurve(to: point, control: secondControlPoint)
            
            previousPoint = point
        }
        return path
    }
}
