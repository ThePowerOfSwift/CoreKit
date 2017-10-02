//
//  AppleViewController.swift
//  CoreKit
//
//  Created by Tibor Bödecs on 2017. 09. 27..
//  Copyright © 2017. Tibor Bödecs. All rights reserved.
//

#if os(iOS) || os(tvOS)
    
    import UIKit.UIViewController
    
    public typealias AppleViewController = UIViewController
    
#endif
#if os(macOS)
    
    import AppKit.NSViewController
    
    public typealias AppleViewController = NSViewController
    
    
#endif




