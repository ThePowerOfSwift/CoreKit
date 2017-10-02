//
//  AppleImage+Resize.swift
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
    
    public func resize(to size: CGSize) -> AppleImage {
        #if os(iOS) || os(tvOS) || os(watchOS)
            UIGraphicsBeginImageContextWithOptions(size, false, 0.0);
            self.draw(in: CGRect(origin: .zero, size: size))
            let newImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return newImage!
        #else
            let img = AppleImage(size: size)
            img.lockFocus()
            let ctx = NSGraphicsContext.current
            ctx?.imageInterpolation = .high
            let rect = NSMakeRect(0, 0, size.width, size.height)
            self.draw(in: rect, from: rect, operation: .copy, fraction: 1)
            img.unlockFocus()
            return img
        #endif
    }
}
