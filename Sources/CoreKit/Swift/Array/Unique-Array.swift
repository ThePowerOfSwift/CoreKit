//
//  Unique-Array.swift
//  CoreKit
//
//  Created by Tibor Bodecs on 28/08/16.
//  Copyright © 2016 Tibor Bodecs. All rights reserved.
//

public extension Array where Element: Hashable {

    /**
     Returns only the unique elements from the array

     - returns: Unique array of elements
     */
    public var unique: [Element] {
        return Array(Set(self))
    }
}
