//
//  String+Initials_Tests.swift
//  CoreKit-Tests
//
//  Created by Tibor Bödecs on 2017. 09. 27..
//  Copyright © 2017. Tibor Bödecs. All rights reserved.
//

import XCTest
@testable import CoreKit



class StringInitials_Tests: XCTestCase {
    
    func test() {
        
        let str1 = "árvíztűrő a tükörfúrógép ma"
        let str2 = "árvíztűrő tükörfúrógép"
        let str3 = "hello"
        let str4 = ""
        
        XCTAssert(str1.initials == "áatm")
        XCTAssert(str2.initials == "át")
        XCTAssert(str3.initials == "h")
        XCTAssert(str4.initials == "")
    }
}



