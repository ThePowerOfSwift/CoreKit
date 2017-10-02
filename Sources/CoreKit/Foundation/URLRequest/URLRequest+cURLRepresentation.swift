//
//  URLRequest+cURLRepresentation.swift
//  CoreKit
//
//  Created by Tibor Bödecs on 2017. 09. 27..
//  Copyright © 2017. Tibor Bödecs. All rights reserved.
//

import Foundation.NSURLSession


public extension URLRequest {
    
    public func cURLRepresentation(withURLSession session: URLSession? = nil, credential: URLCredential? = nil) -> String {
        var components = ["curl -i"]
        
        guard let url = self.url, let host = url.host else {
            return "curl command could not be created"
        }
        
        if let method = self.httpMethod {
            components.append("-X \(method.uppercased())")
        }
        
        
        if let session = session {
            if let credentialStorage = session.configuration.urlCredentialStorage {
                let protectionSpace = URLProtectionSpace(host: host,
                                                         port: url.port ?? 0,
                                                         protocol: url.scheme,
                                                         realm: host,
                                                         authenticationMethod: NSURLAuthenticationMethodHTTPBasic)
                
                if let credentials = credentialStorage.credentials(for: protectionSpace)?.values {
                    for credential in credentials {
                        components.append("-u \(credential.user!):\(credential.password!)")
                    }
                }
                else {
                    if let credential = credential {
                        components.append("-u \(credential.user!):\(credential.password!)")
                    }
                }
            }
            
            if session.configuration.httpShouldSetCookies {
                if
                    let cookieStorage = session.configuration.httpCookieStorage,
                    let cookies = cookieStorage.cookies(for: url), !cookies.isEmpty
                {
                    let string = cookies.reduce("") { $0 + "\($1.name)=\($1.value);" }
                    let index  = string.index(before: string.endIndex)
                    components.append("-b \"\(String(string[..<index]))\"")
                }
            }
        }
        
        var headers: [AnyHashable: Any] = [:]
        
        if let additionalHeaders = session?.configuration.httpAdditionalHeaders {
            for (field, value) in additionalHeaders where field != AnyHashable("Cookie") {
                headers[field] = value
            }
        }
        
        if let headerFields = self.allHTTPHeaderFields {
            for (field, value) in headerFields where field != "Cookie" {
                headers[field] = value
            }
        }
        
        for (field, value) in headers {
            components.append("-H \"\(field): \(value)\"")
        }
        
        if let httpBody = self.httpBody?.utf8String {
            var escapedBody = httpBody.replacingOccurrences(of: "\\\"", with: "\\\\\"")
            escapedBody = escapedBody.replacingOccurrences(of: "\"", with: "\\\"")
            
            components.append("-d \"\(escapedBody)\"")
        }
        
        components.append("\"\(url.absoluteString)\"")
        
        return components.joined(separator: " \\\n\t")
    }
}
