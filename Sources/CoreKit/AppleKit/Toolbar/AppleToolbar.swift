//
//  AppleToolbar.swift
//  CoreKit
//
//  Created by Tibor Bödecs on 2017. 09. 28..
//  Copyright © 2017. Tibor Bödecs. All rights reserved.
//

#if os(iOS)
    
    import UIKit.UIToolbar
    
    public typealias AppleToolbar = UIToolbar
    
#endif

#if os(macOS)
    
    import AppKit.NSToolbar
    
    public typealias AppleToolbar = NSToolbar
    
#endif









