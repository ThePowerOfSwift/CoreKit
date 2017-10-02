//
//  AppleImage+Tint.swift
//  CoreKit
//
//  Created by Tibor Bödecs on 2017. 09. 27..
//  Copyright © 2017. Tibor Bödecs. All rights reserved.
//

import CoreGraphics

#if os(iOS) || os(tvOS) || os(watchOS)
    import UIKit
#elseif os(OSX)
    import AppKit
#endif


public extension AppleImage {
    
    public func tint(color: AppleColor) -> AppleImage {
        #if os(iOS) || os(tvOS) || os(watchOS)
            let rect = CGRect(origin: .zero, size: self.size)
            UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale);
            self.draw(in: rect)
            let context = UIGraphicsGetCurrentContext()!
            context.setBlendMode(.sourceIn)
            context.setFillColor(color.cgColor);
            context.fill(rect);
            let newImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return newImage!
        #else
            let tinted = self.copy() as! AppleImage
            tinted.lockFocus()
            color.set()
            let imageRect = NSRect(origin: .zero, size: self.size)
            imageRect.fill(using: .sourceAtop)
            tinted.unlockFocus()
            return tinted
        #endif
    }
}
