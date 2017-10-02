//
//  SignedInteger+RandomSignal.swift
//  CoreKit
//
//  Created by Tibor Bödecs on 2017. 09. 27..
//  Copyright © 2017. Tibor Bödecs. All rights reserved.
//

import Darwin


public extension SignedInteger {

    /**
     Randomly returns either 1 or -1
     */
    public static var randomSignal: Self {
        get {
            return ((arc4random_uniform(2) == 0) ? 1 : -1) as! Self
        }
    }
}


