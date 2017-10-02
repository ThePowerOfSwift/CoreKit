//
//  String+FirstWord_Tests.swift
//  CoreKit-Tests
//
//  Created by Tibor Bödecs on 2017. 09. 27..
//  Copyright © 2017. Tibor Bödecs. All rights reserved.
//

import XCTest
@testable import CoreKit


class StringFirstWord_Tests: XCTestCase {
    
    func test() {
        
        let str1 = "árvíztűrő tükörfúrógép"
        let str2 = "hello"
        let str3 = ""
        
        XCTAssert(str1.firstWord == Optional("árvíztűrő"))
        XCTAssert(str2.firstWord == Optional("hello"))
        XCTAssert(str3.firstWord == nil)
    }
}

