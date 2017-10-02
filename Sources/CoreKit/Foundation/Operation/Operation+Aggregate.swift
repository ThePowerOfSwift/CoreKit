//
//  Operation+Aggregate.swift
//  CoreKit
//
//  Created by Tibor Bödecs on 2017. 09. 27..
//  Copyright © 2017. Tibor Bödecs. All rights reserved.
//

import Foundation.NSOperation


public extension Operation {
    
    /**
     Returns an empty operation with a completion handler to aggregate operations
    
     - returns: The operation
     */
    public static func aggregate(completion: @escaping VoidBlock) -> Operation {
        return BlockOperation(block: {}, completion: completion)
    }
}
