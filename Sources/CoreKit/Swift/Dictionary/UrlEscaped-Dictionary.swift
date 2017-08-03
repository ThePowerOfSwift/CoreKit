//
//  UrlEscaped-Dictionary.swift
//  CoreKit
//
//  Created by Tibor Bodecs on 2016. 09. 14..
//  Copyright © 2016. Tibor Bodecs. All rights reserved.
//


public extension Dictionary where Key: ExpressibleByStringLiteral, Key: Comparable, Value: Any {

    /**
        Creates percent-escaped, URL encoded query string components from the given key-value pair using recursion.
     */
    public var urlEscaped: String {

        func queryComponents(_ key: String, _ value: Any) -> [(String, String)] {
            var components: [(String, String)] = []

            if let dictionary = value as? [String: Any] {
                for (nestedKey, value) in dictionary {
                    components += queryComponents("\(key)[\(nestedKey)]", value)
                }
            }
            else if let array = value as? [Any] {
                for value in array {
                    components += queryComponents("\(key)[]", value)
                }
            }
            else {
                components.append((key.urlEscaped, "\(value)".urlEscaped))
            }
            return components
        }

        var components: [(String, String)] = []

        self.keys.sorted(by: <).forEach { components += queryComponents($0 as! String, self[$0]!) }

        return (components.map { "\($0)=\($1)" } as [String]).joined(separator: "&")
    }
}
