//
//  AppleSplitViewController.swift
//  CoreKit
//
//  Created by Tibor Bödecs on 2017. 09. 27..
//  Copyright © 2017. Tibor Bödecs. All rights reserved.
//

#if os(iOS) || os(tvOS)
    
    import UIKit.UISplitViewController
    
    public typealias AppleSplitViewController = UISplitViewController
    
#endif
#if os(macOS)
    
    import AppKit.NSSplitViewController
    
    public typealias AppleSplitViewController = NSSplitViewController
    
#endif


