//
//  AppleView.swift
//  CoreKit
//
//  Created by Tibor Bödecs on 2017. 09. 27..
//  Copyright © 2017. Tibor Bödecs. All rights reserved.
//

#if os(iOS) || os(tvOS)
    
    import UIKit.UIView
    
    public typealias AppleView = UIView
    
#endif
#if os(macOS)
    
    import AppKit.NSView
    
    public typealias AppleView = NSView
    
    
#endif



