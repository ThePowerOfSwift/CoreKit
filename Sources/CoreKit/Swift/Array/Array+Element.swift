//
//  Array+Element.swift
//  CoreKit
//
//  Created by Tibor Bödecs on 2017. 09. 26..
//  Copyright © 2017. Tibor Bödecs. All rights reserved.
//


public extension Array {
    
    /**
     Returns an element from an array at a given index
     
     - parameter index: Index of the element to return
     - returns: An element at the given index
     */
    public func element(at index: Int) -> Element? {
        return index < self.count && index >= 0 ? self[index] : nil
    }
    
}
