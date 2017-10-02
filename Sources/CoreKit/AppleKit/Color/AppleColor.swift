//
//  AppleColor.swift
//  CoreKit
//
//  Created by Tibor Bödecs on 2017. 09. 27..
//  Copyright © 2017. Tibor Bödecs. All rights reserved.
//


#if os(iOS) || os(tvOS) || os(watchOS)

    import UIKit.UIColor
    
    public typealias AppleColor = UIColor

#endif

#if os(macOS)
    
    import AppKit.NSColor

    public typealias AppleColor = NSColor
#endif
