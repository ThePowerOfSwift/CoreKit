//
//  AppleBezierPath.swift
//  CoreKit
//
//  Created by Tibor Bödecs on 2017. 09. 27..
//  Copyright © 2017. Tibor Bödecs. All rights reserved.
//

#if os(iOS) || os(tvOS) || os(watchOS)
    
    import UIKit.UIBezierPath
    
    public typealias AppleBezierPath = UIBezierPath
    
    
#endif

#if os(macOS)
    
    import AppKit.NSBezierPath
    
    public typealias AppleBezierPath = NSBezierPath

    public extension AppleBezierPath {

        public var cgPath: CGPath {
            let path = CGMutablePath()
            if self.elementCount == 0 {
                return path
            }
            var didClosePath = false

            for i in 0...self.elementCount-1 {
                var points = [NSPoint](repeating: NSZeroPoint, count: 3)
                switch self.element(at: i, associatedPoints: &points) {
                case .moveToBezierPathElement:
                    path.move(to: points[0])
                case .lineToBezierPathElement:
                    path.addLine(to: points[0])
                case .curveToBezierPathElement:
                    path.addCurve(to: points[0], control1: points[1], control2: points[2])
                case .closePathBezierPathElement:
                    path.closeSubpath()
                    didClosePath = true;
                }
            }
            if !didClosePath {
                path.closeSubpath()
            }
            return path
        }
    }

#endif





