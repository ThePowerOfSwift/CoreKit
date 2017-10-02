//
//  AppleScrollView.swift
//  CoreKit
//
//  Created by Tibor Bödecs on 2017. 09. 28..
//  Copyright © 2017. Tibor Bödecs. All rights reserved.
//

#if os(iOS) || os(tvOS)
    
    import UIKit.UIScrollView
    
    public typealias AppleScrollView = UIScrollView
    public typealias AppleScrollViewDelegate = UIScrollViewDelegate
    
#endif

#if os(macOS)
    
    import AppKit.NSScrollView
    
    public typealias AppleScrollView = NSScrollView
    
#endif


