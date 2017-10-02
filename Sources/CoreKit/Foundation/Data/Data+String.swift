//
//  Data+String.swift
//  CoreKit
//
//  Created by Tibor Bödecs on 2017. 09. 27..
//  Copyright © 2017. Tibor Bödecs. All rights reserved.
//

import Foundation.NSData


public extension Data {
    
    /**
     Converts a data object to an utf8 string.
     
     - returns: The utf8 string or nil
     */
    public var utf8String: String? {
        return self.toString()
    }

    /**
     Converts a data object to a string.
     
     - parameter encoding: The string encoding, utf8 by default
     
     - returns: The utf8 string or nil
     */
    public func toString(encoding: String.Encoding = .utf8) -> String? {
        return String(data: self, encoding: encoding)
    }
    
}

