//
//  Array+Random.swift
//  CoreKit-iOS
//
//  Created by Tibor Bödecs on 2017. 09. 26..
//  Copyright © 2017. Tibor Bödecs. All rights reserved.
//

import Darwin


public extension Array {
    
    /**
     Returns a random element from the array
     
     - returns: Random element from the array or nil if the array is empty
     */
    public var random: Element? {
        guard !self.isEmpty else {
            return nil
        }
        return self[Int(arc4random_uniform(UInt32(self.count)))]
    }
}


