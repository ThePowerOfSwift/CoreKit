//
//  URLRequestLoggerProtocol.swift
//  CoreKit
//
//  Created by Tibor Bödecs on 2017. 10. 05..
//  Copyright © 2017. Tibor Bödecs. All rights reserved.
//

import Foundation.NSURLProtocol


/*
 usage: URLProtocol.registerClass(URLRequestLoggerProtocol.self)
 */

class URLRequestLoggerProtocol: URLProtocol {

    override class func canInit(with request: URLRequest) -> Bool {
        print(request.cURLRepresentation())
        return false
    }
}


