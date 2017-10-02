//
//  BlockOperation.swift
//  CoreKit
//
//  Created by Tibor Bödecs on 2017. 09. 27..
//  Copyright © 2017. Tibor Bödecs. All rights reserved.
//

import Foundation.NSOperation


public extension BlockOperation {
    
    public convenience init(block: @escaping VoidBlock, completion: VoidBlock?) {
        self.init(block: block)
        self.completionBlock = completion
    }
}

