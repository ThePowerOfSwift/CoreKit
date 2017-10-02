//
//  CGFloat+Scale.swift
//  CoreKit
//
//  Created by Tibor Bödecs on 2017. 09. 27..
//  Copyright © 2017. Tibor Bödecs. All rights reserved.
//

import CoreGraphics

#if os(iOS) || os(tvOS)
    import UIKit.UIScreen
#elseif os(OSX)
    import AppKit.NSScreen
#endif


public extension CGFloat {

    /**
     Converts one point to the size of a real pixel based on the screen's scale factor.
     
     - returns: The real pixel size in CGFloat
     */
    public static var scale: CGFloat {
        #if os(watchOS)
            return 0.5
        #elseif os(iOS) || os(tvOS)
            return 1.0 / UIScreen.main.scale
        #elseif os(OSX)
            return 1.0 / (NSScreen.main?.backingScaleFactor ?? 1.0)
        #else
            return 1.0
        #endif
    }
}

