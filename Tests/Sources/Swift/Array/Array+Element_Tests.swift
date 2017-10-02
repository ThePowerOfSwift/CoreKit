//
//  Array+Element_Tests.swift
//  CoreKit-Tests
//
//  Created by Tibor Bödecs on 2017. 09. 26..
//  Copyright © 2017. Tibor Bödecs. All rights reserved.
//

import XCTest
@testable import CoreKit


class ArrayElement_Tests: XCTestCase {
    
    func test() {
        let sample1: [String] = ["a", "b", "c"]
        
        XCTAssert(sample1.element(at: -1) == nil)
        XCTAssert(sample1.element(at: 5) == nil)
        XCTAssert(sample1.element(at: 0) == Optional("a"))
        XCTAssert(sample1.element(at: 2) == Optional("c"))
    }
}

