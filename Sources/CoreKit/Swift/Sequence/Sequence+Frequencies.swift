//
//  Sequence+Frequencies.swift
//  CoreKit
//
//  Created by Tibor Bödecs on 2017. 09. 27..
//  Copyright © 2017. Tibor Bödecs. All rights reserved.
//


public extension Sequence where Element: Hashable {

    /**
     Returns the frequencies of the values from a sequence
     
     - returns: Array of the (key, frequency) values
     */
    public var frequencies: [(Element, Int)] {
        var result: [Element:Int] = [:]
        for x in self {
            result[x] = (result[x] ?? 0) + 1
        }
        return result.sorted { $0.1 > $1.1 }
    }
}

