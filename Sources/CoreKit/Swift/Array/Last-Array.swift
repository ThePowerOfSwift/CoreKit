//
//  Last-Array.swift
//  CoreKit
//
//  Created by Tibor Bodecs on 08/07/16.
//  Copyright © 2016 Tibor Bodecs. All rights reserved.
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
    
    public var last: Element? {
        return self.last(1).first
    }
}
