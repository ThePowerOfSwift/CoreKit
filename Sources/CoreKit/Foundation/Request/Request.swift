//
//  Request.swift
//  CoreKit
//
//  Created by Tibor Bodecs on 2016. 09. 14..
//  Copyright © 2016. Tibor Bodecs. All rights reserved.
//

import Foundation


public protocol Endpoint {

    var request: Request { get }
}


open class Request {

    public enum Task: String {
        case data
        case download
        case upload
        case stream
    }

    public enum Method: String {
        case get
        case post
        case put
        case delete
        case head
        case patch
        case trace
        case connect
        case options
    }

    public struct Token {

        public let type: String?
        public let token: String
        public let expires: Date

        public init(type: String, token: String, expires: Date) {
            self.type    = type
            self.token   = token
            self.expires = expires
        }

        public var requestHeaderValue: String {
            get {
                if let type = self.type {
                    return type + " " + self.token
                }
                return self.token
            }
        }
    }

    public enum Header {

        private enum Keys: String {
            case ContentDisposition = "Content-Disposition"
            case Accept             = "Accept"
            case ContentType        = "Content-Type"
//            case ContentLength      = "Content-Length"
            case UserAgent          = "User-Agent"
            case Authorization      = "Authorization"
        }

        case ContentDisposition(String)
        case Accept([String])
        case ContentType(String)
//        case ContentLength(Data)
        case UserAgent(String)
        case Authorization(Token)
        case Custom(String, String)

        public var raw: URLQueryItem {
            switch self {
            case .ContentDisposition(let disposition):
                return URLQueryItem(name: Keys.ContentDisposition.rawValue, value: disposition)
            case .Accept(let types):
                return URLQueryItem(name: Keys.Accept.rawValue, value: types.reduce("", { x, y in x ?? "" + ", " + y }))
            case .ContentType(let type):
                return URLQueryItem(name: Keys.ContentType.rawValue, value: type)
//            case .ContentLength(let data):
//                return URLQueryItem(name: Keys.ContentLength.rawValue, value: String(data.count) ?? "0")
            case .UserAgent(let type):
                return URLQueryItem(name: Keys.UserAgent.rawValue, value: type)
            case .Authorization(let token):
                return URLQueryItem(name: Keys.Authorization.rawValue, value: token.requestHeaderValue)
            case .Custom(let key, let value):
                return URLQueryItem(name: key, value: value)
            }
        }
    }

    let path: String
    let query: [URLQueryItem]
    let fragment: String?

    let method: Method
    let headers: [Header]
    let data: Data?

    let user: String?
    let password: String?
    
    let scheme: String?
    let port: Int?
    
    let task: Task

    public init(_ path: String,
                 query: [URLQueryItem] = [],
              fragment: String? = nil,
                method: Method = .get,
               headers: [Header] = [],
                  data: Data? = nil,
                  user: String? = nil,
              password: String? = nil,
                scheme: String? = nil,
                  port: Int? = nil,
                  task: Task = .data)
    {
        self.path     = path
        self.query    = query
        self.fragment = fragment
        self.method   = method
        self.headers  = headers
        self.data     = data
        self.user     = user
        self.password = password
        self.scheme   = scheme
        self.port     = port
        self.task     = task
    }
}



//public class JsonRequest: DataRequest
//{
//    public convenience init(method: RequestMethod = .get, query: String,
//                     headers: [RequestHeader] = [], params: [RequestParam] = [],
//                     fragment: String? = nil, json: AnyObject? = nil)
//    {
//        var data: Data? = nil
//        do {
//            if let jsonData = json {
//                data = try JSONSerialization.data(withJSONObject: jsonData, options: [])
//            }
//        }
//        catch (let err) {
//            print(err)
//        }
//
//        self.init(method: method, query: query, headers: headers, params: params, fragment: fragment, data: data)
//    }
//}




