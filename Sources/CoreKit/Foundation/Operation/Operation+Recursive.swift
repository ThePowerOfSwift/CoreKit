//
//  Operation+Recursive.swift
//  CoreKit
//
//  Created by Tibor Bödecs on 2017. 09. 27..
//  Copyright © 2017. Tibor Bödecs. All rights reserved.
//

import Foundation.NSOperation


public extension Operation {

    /**
     All the dependencies of the given operation including self
     
     - returns: The NSOperation array of dependencies
     */
    public var recursiveDependencies: [Operation] {
        var operations : [Operation] = [self]
        for dependency in self.dependencies {
            operations += dependency.recursiveDependencies
        }
        return operations
    }
    
    /**
     Executes the operation with all the dependencies on the given queue
     
     - parameter on queue: The operations will be added to this queue
     - parameter waitUntilFinished: If true, the queue will be blocked
     */
    public func executeWithRecursiveDependencies(on queue: OperationQueue = .main, waitUntilFinished: Bool = false) {
        queue.addOperations(self.recursiveDependencies, waitUntilFinished: waitUntilFinished)
    }
    
}
