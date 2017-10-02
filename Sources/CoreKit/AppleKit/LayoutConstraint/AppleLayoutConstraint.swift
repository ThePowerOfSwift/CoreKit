//
//  AppleLayoutConstraint.swift
//  CoreKit
//
//  Created by Tibor Bödecs on 2017. 09. 27..
//  Copyright © 2017. Tibor Bödecs. All rights reserved.
//

#if os(iOS) || os(tvOS)
    
    import UIKit.NSLayoutConstraint
    
    public typealias AppleLayoutConstraint = NSLayoutConstraint
    
#endif
#if os(macOS)
    
    import AppKit.NSLayoutConstraint
    
    public typealias AppleLayoutConstraint = NSLayoutConstraint


#endif


