//
//  Delay-DispatchQueue.swift
//  CoreKit
//
//  Created by Tibor Bödecs on 2017. 01. 04..
//  Copyright © 2017. Tibor Bodecs. All rights reserved.
//

import Foundation
#if os(Linux)
import Dispatch
#endif

public extension DispatchQueue {

    public func asyncAfter(delay: TimeInterval, execute block: @escaping VoidBlock) {
        self.asyncAfter(deadline: DispatchTime.now() + delay, execute: block)
    }

}
