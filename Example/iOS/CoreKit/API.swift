//
//  API.swift
//  Example
//
//  Created by Tibor Bodecs on 2016. 10. 18..
//  Copyright © 2016. Tibor Bodecs. All rights reserved.
//

import Foundation
import CoreKit


class Servers {
    
    static let dummy = Server(domain: "images6.alphacoders.com")
    static let json = Server(domain: "jsonplaceholder.typicode.com")
}


enum Kittens: Endpoint {

    case list(String)
    case image

    var request: Request {
        switch self {
        case .image:
            //https://images6.alphacoders.com/362/362694.jpg
            return Request("362/362694.jpg", query: [URLQueryItem(name: "qa", value: "hihi")], task: .download)
        case .list(let _):
            return Request("posts")
        }
    }
}
