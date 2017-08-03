//
//  UrlEscaped-String.swift
//  CoreKit
//
//  Created by Tibor Bodecs on 2016. 09. 14..
//  Copyright © 2016. Tibor Bodecs. All rights reserved.
//

import Foundation


public extension String {

    /**
        Returns a percent-escaped string following RFC 3986 for a query string key or value.
    */
    public var urlEscaped: String {
        var charset = CharacterSet.urlQueryAllowed
        charset.remove(charactersIn: ":#[]@!$&'()*+,;=")
        return self.addingPercentEncoding(withAllowedCharacters: charset) ?? self
    }
}
