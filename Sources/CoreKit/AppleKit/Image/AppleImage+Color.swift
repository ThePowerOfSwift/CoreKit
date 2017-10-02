//
//  AppleImage+Color.swift
//  CoreKit
//
//  Created by Tibor Bödecs on 2017. 09. 27..
//  Copyright © 2017. Tibor Bödecs. All rights reserved.
//

import CoreGraphics
#if os(iOS) || os(tvOS) || os(watchOS)
    import UIKit
#else
    import AppKit
#endif



public extension AppleImage {
    
    public static func from(color: AppleColor) -> AppleImage {
        #if os(iOS) || os(tvOS) || os(watchOS)
            let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
            UIGraphicsBeginImageContext(rect.size);
            let context = UIGraphicsGetCurrentContext();
            context!.setFillColor(color.cgColor);
            context!.fill(rect);
            let newImage = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            return newImage!
        #else
            let image = AppleImage(size: NSSize(width: 1, height: 1))
            image.lockFocus()
            color.drawSwatch(in: NSRect(x: 0, y: 0, width: 1, height: 1))
            image.unlockFocus()
            return image
        #endif
    }
    
    public var averageColor : AppleColor {
        
        let rgba = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: 4)
        let colorSpace: CGColorSpace = CGColorSpaceCreateDeviceRGB()
        let info = CGImageAlphaInfo.premultipliedLast.rawValue
        let context = CGContext(data: rgba, width: 1, height: 1, bitsPerComponent: 8, bytesPerRow: 4, space: colorSpace, bitmapInfo: info)!
        
        #if os(iOS) || os(tvOS) || os(watchOS)
            let image = self.cgImage!
        context.draw(image, in: CGRect(x: 0, y: 0, width: 1, height: 1))
        #else
            let image = self.cgImage
            context.draw(image, in: NSRect(x: 0, y: 0, width: 1, height: 1))
        #endif

        
        
        if rgba[3] > 0 {
            let alpha: CGFloat = CGFloat(rgba[3]) / 255.0
            let multiplier: CGFloat = alpha / 255.0
            
            return AppleColor(red: CGFloat(rgba[0]) * multiplier, green: CGFloat(rgba[1]) * multiplier, blue: CGFloat(rgba[2]) * multiplier, alpha: alpha)
            
        }
        return AppleColor(red: CGFloat(rgba[0]) / 255.0, green: CGFloat(rgba[1]) / 255.0, blue: CGFloat(rgba[2]) / 255.0, alpha: CGFloat(rgba[3]) / 255.0)
    }
    
    
}

