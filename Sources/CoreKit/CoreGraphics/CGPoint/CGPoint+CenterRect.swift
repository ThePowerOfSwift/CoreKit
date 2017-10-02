//
//  CGPoint+CenterRect.swift
//  CoreKit
//
//  Created by Tibor Bödecs on 2017. 09. 27..
//  Copyright © 2017. Tibor Bödecs. All rights reserved.
//

import CoreGraphics.CGGeometry


public extension CGPoint {
    
    /**
     Creates a rectange with a given size from the center of the point
     
     - parameter size: The size of the rectange
     - returns: The rectange centered to the point
     */
    public func centerRect(size: CGSize) -> CGRect {
        return CGRect(x: self.x - size.width / 2.0, y: self.y - size.height / 2.0, width: size.width, height: size.height)
    }
}
