//
//  FloatingPoint+RandomSignal.swift
//  CoreKit
//
//  Created by Tibor Bödecs on 2017. 09. 27..
//  Copyright © 2017. Tibor Bödecs. All rights reserved.
//

import Darwin


public extension FloatingPoint {
    
    /**
     Randomly returns either 1.0 or -1.0.
     */
    public static var randomSignal: Self {
        get {
            return ((arc4random_uniform(2) == 0) ? 1.0 : -1.0) as! Self
        }
    }
}



