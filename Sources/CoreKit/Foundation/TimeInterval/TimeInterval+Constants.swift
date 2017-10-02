//
//  TimeInterval+Constants.swift
//  CoreKit
//
//  Created by Tibor Bödecs on 2017. 09. 27..
//  Copyright © 2017. Tibor Bödecs. All rights reserved.
//

import Foundation.NSDate


public extension TimeInterval {

    public static var second: TimeInterval { return 1 }
    public static var minute: TimeInterval { return 60 }
    public static var hour: TimeInterval { return 3600 }
    public static var day: TimeInterval { return 86400 }
    public static var week: TimeInterval { return 604800 }
}
