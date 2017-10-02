//
//  Array+Unique.swift
//  CoreKit-iOS
//
//  Created by Tibor Bödecs on 2017. 09. 26..
//  Copyright © 2017. Tibor Bödecs. All rights reserved.
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
