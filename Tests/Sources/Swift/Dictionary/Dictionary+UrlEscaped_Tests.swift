//
//  Dictionary+UrlEscaped_Tests.swift
//  CoreKit-Tests
//
//  Created by Tibor Bödecs on 2017. 09. 27..
//  Copyright © 2017. Tibor Bödecs. All rights reserved.
//

import XCTest
@testable import CoreKit


class DictionaryUrlEscaped_Tests: XCTestCase {
    
    func test() {
        let key: [String:Any] = ["hehe": "valami", "sub": [1: "first", 2: [1,2,3]]]
        let value = "hehe=valami&sub=%5B2:%20%5B1,%202,%203%5D,%201:%20%22first%22%5D"
        XCTAssert(key.urlEscaped == value)
    }
}
