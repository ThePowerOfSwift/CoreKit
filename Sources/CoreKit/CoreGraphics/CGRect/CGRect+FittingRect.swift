//
//  CGRect+FittingRect.swift
//  CoreKit
//
//  Created by Tibor Bödecs on 2017. 09. 27..
//  Copyright © 2017. Tibor Bödecs. All rights reserved.
//

import CoreGraphics.CGGeometry


public extension CGRect {
    
    /**
     Returns the rect that fits into the given rect
     
     - parameter rect: The rect to fit into
     - returns: The rect that fits into
     */
    public func fittingRect(_ rect: CGRect) -> CGRect {
        let scale = self.size.scaleToFit(size: rect.size)
        let targetSize = CGSize(width: self.size.width * scale, height: self.size.height * scale)
        let center = CGPoint(x: rect.midX, y: rect.midY)
        return center.centerRect(size: targetSize)
    }
}

