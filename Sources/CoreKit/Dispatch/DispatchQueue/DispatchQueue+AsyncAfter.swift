//
//  DispatchQueue+AsyncAfter.swift
//  CoreKit
//
//  Created by Tibor Bödecs on 2017. 09. 27..
//  Copyright © 2017. Tibor Bödecs. All rights reserved.
//

import Dispatch


public extension DispatchQueue {
    
    /**
     Executes a code block after asynchronously a time of delay
     
     - parameter delay: The delay in seconds
     - parameter execute block: The code to execute
     */
    public func asyncAfter(delay: Double, execute block: @escaping VoidBlock) {
        self.asyncAfter(deadline: DispatchTime.now() + delay, execute: block)
    }    
}
