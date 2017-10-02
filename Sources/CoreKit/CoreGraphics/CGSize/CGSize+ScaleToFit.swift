//
//  CGSize+ScaleToFit.swift
//  CoreKit
//
//  Created by Tibor Bödecs on 2017. 09. 27..
//  Copyright © 2017. Tibor Bödecs. All rights reserved.
//

import CoreGraphics.CGGeometry


public extension CGSize {
    
    /**
     Returns the scale to fit into a different size
     
     - parameter size: The size to fit into
     - returns: The scale to fit into the given size
     */
    public func scaleToFit(size: CGSize) -> CGFloat {
        let w = size.width / self.width
        let h = size.height / self.height
        return fmin(w, h)
    }
}
