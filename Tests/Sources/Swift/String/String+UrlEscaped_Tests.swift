//
//  String+UrlEscaped_Tests.swift
//  CoreKit-Tests
//
//  Created by Tibor Bödecs on 2017. 09. 27..
//  Copyright © 2017. Tibor Bödecs. All rights reserved.
//

import XCTest
@testable import CoreKit


class StringUrlEscaped_Tests: XCTestCase {
    
    func test() {
        let key = "árvíztűrő tükörfúrógép[]p"
        let value = "%C3%A1rv%C3%ADzt%C5%B1r%C5%91%20t%C3%BCk%C3%B6rf%C3%BAr%C3%B3g%C3%A9p%5B%5Dp"
        XCTAssert(key.urlEscaped == value)
    }
}





