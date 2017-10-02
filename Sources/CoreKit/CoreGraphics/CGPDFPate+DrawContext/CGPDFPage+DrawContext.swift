//
//  CGPDFPage+DrawContext.swift
//  CoreKit
//
//  Created by Tibor Bödecs on 2017. 09. 27..
//  Copyright © 2017. Tibor Bödecs. All rights reserved.
//

#if os(iOS) || os(tvOS)

import CoreGraphics.CGPDFPage
import UIKit.UIGraphics
    
    
public extension CGPDFPage {

    /**
     Draws the context in a rectangle
     
     - parameter rect: The rectangle to draw in
     */
    public func drawContextIn(rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else {
            return print("Warning: Could not get graphics context.")
        }

        context.saveGState()
        
        let image     = UIGraphicsGetImageFromCurrentImageContext()
        var transform = CGAffineTransform.identity
        transform     = transform.scaledBy(x: 1.0, y: -1.0)
        transform     = transform.translatedBy(x: 0, y: -image!.size.height)
        
        context.concatenate(transform)

        let drawRect    = rect.applying(transform)
        let pageRect    = self.getBoxRect(.cropBox)
        let size        = pageRect.size.scaleToFit(size: drawRect.size)
        let drawingRect = pageRect.fittingRect(drawRect)
        
        context.translateBy(x: drawingRect.origin.x, y: drawingRect.origin.y)
        context.scaleBy(x: size, y: size)
        context.drawPDFPage(self)
        context.restoreGState()
    }
}
    
#endif

