//
//  ExpressibleByIntegerLiteral+Random.swift
//  CoreKit-iOS
//
//  Created by Tibor Bödecs on 2017. 09. 26..
//  Copyright © 2017. Tibor Bödecs. All rights reserved.
//

import Darwin


public extension ExpressibleByIntegerLiteral {

    /**
     Randomization of the generic integer type
     
     - returns: A random integer value
     */
    public static var random: Self {
        var r: Self = 0
        arc4random_buf(&r, MemoryLayout<Self>.size)
        return r
    }

}
