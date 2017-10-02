//
//  Object+ObjectName.swift
//  CoreKit
//
//  Created by Tibor Bödecs on 2017. 09. 29..
//  Copyright © 2017. Tibor Bödecs. All rights reserved.
//

import Foundation.NSObject


public extension NSObject {

    /**
     Returns the full name with the namespace identifier
     */
    public static var objectNameIdentifier: String {
        return self.description()
    }

    public var objectNameIdentifier: String {
        return type(of: self).description()
    }
    
    public static var objectNamespace: String? {
        let names = NSStringFromClass(self).split(separator: ".").map { String($0) }
        if names.count <= 1 {
            return nil
        }
        return names.first
    }

    public var objectNamespace: String? {
        return type(of: self).objectNamespace
    }

    public static var objectName: String {
        return String(NSStringFromClass(self).split(separator: ".").last!)
    }

    public var objectName: String {
        return type(of: self).objectName
    }
}
