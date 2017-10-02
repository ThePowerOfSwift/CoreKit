//
//  String+CapitalizedFirstCharacter_Tests.swift
//  CoreKit
//
//  Created by Tibor Bödecs on 2017. 09. 27..
//  Copyright © 2017. Tibor Bödecs. All rights reserved.
//

import XCTest
@testable import CoreKit


class StringCapitalizedFirstCharacter_Tests: XCTestCase {
    
    func test() {
        
        let str1 = "árvíztűrő tükörfúrógép"
        let str2 = "hello"
        let str3 = ""

        XCTAssert(str1.capitalizedFirstCharacter == "Árvíztűrő tükörfúrógép")
        XCTAssert(str2.capitalizedFirstCharacter == "Hello")
        XCTAssert(str3.capitalizedFirstCharacter == "")
    }
}


