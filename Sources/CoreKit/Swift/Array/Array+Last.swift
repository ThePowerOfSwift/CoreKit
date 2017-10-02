//
//  Array+Last.swift
//  CoreKit
//
//  Created by Tibor Bödecs on 2017. 09. 26..
//  Copyright © 2017. Tibor Bödecs. All rights reserved.
//


public extension Array {
    
    /**
     Returns the last n element from an array

     - parameter _ count: The number of elements to return
     - returns: An array of the elements
     */
    public func last(_ count: Int) -> [Element] {
        if count < 1 {
            return []
        }
        return Array(self.suffix(count))
    }
}
