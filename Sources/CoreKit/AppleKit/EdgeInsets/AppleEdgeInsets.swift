//
//  AppleEdgeInsets.swift
//  CoreKit
//
//  Created by Tibor Bödecs on 2017. 09. 27..
//  Copyright © 2017. Tibor Bödecs. All rights reserved.
//

#if os(iOS) || os(tvOS) || os(watchOS)
    
    import UIKit
    
    public typealias AppleEdgeInsets = UIEdgeInsets

#endif
#if os(macOS)
    
    import AppKit
    
    public typealias AppleEdgeInsets = NSEdgeInsets
    
#endif




