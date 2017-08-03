//
//  String-Data.swift
//  CoreKit
//
//  Created by Tibor Bödecs on 2017. 01. 04..
//  Copyright © 2017. Tibor Bodecs. All rights reserved.
//

import Foundation


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
