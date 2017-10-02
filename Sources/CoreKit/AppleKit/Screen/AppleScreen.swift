//
//  AppleScreen.swift
//  CoreKit
//
//  Created by Tibor Bödecs on 2017. 09. 27..
//  Copyright © 2017. Tibor Bödecs. All rights reserved.
//

#if os(iOS) || os(tvOS)
    
    import UIKit.UIScreen
    
    public typealias AppleScreen = UIScreen
    
    public extension AppleScreen {

        public static var `default`: AppleScreen {
            return AppleScreen.main
        }
    }
    
#endif
#if os(macOS)
    
    import AppKit.NSScreen
    
    public typealias AppleScreen = NSScreen
    
    public extension AppleScreen {

        public var bounds: CGRect { return NSRectToCGRect(self.visibleFrame) }
        
        public static var `default`: AppleScreen {
            return AppleScreen.main!
        }
    }
    
#endif



