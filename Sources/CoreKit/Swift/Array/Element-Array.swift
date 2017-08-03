//
//  Element-Array.swift
//  CoreKit
//
//  Created by Tibor Bodecs on 07/07/16.
//  Copyright © 2016 Tibor Bodecs. All rights reserved.
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
