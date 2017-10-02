//
//  AppleWindow.swift
//  CoreKit
//
//  Created by Tibor Bödecs on 2017. 09. 27..
//  Copyright © 2017. Tibor Bödecs. All rights reserved.
//

#if os(iOS) || os(tvOS)

    import UIKit.UIWindow
    
    public typealias AppleWindow = UIWindow
    
#endif
#if os(macOS)
    
    import AppKit.NSFont
    
    public typealias AppleWindow = NSWindow
    
#endif






