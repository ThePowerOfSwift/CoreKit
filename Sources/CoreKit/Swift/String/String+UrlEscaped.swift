//
//  String+UrlEscaped.swift
//  CoreKit
//
//  Created by Tibor Bödecs on 2017. 09. 27..
//  Copyright © 2017. Tibor Bödecs. All rights reserved.
//


public extension String {
    
    /**
     Returns a percent-escaped string following RFC 3986 for a query string key or value.
     */
    public var urlEscaped: String {
        return self.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
    }
}

