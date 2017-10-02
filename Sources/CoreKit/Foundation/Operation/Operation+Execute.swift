//
//  Operation+Execute.swift
//  CoreKit
//
//  Created by Tibor Bödecs on 2017. 09. 27..
//  Copyright © 2017. Tibor Bödecs. All rights reserved.
//

import Foundation.NSOperation


public extension Operation {

    /**
     Executes an operation on the given queue
     
     - parameter on queue: The operations will be added to this queue
     */
    public func execute(on queue: OperationQueue = .main) {
        queue.addOperation(self)
    }
}

