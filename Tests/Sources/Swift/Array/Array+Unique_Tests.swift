//
//  Array+Unique_Tests.swift
//  CoreKit-iOS-Tests
//
//  Created by Tibor Bödecs on 2017. 09. 26..
//  Copyright © 2017. Tibor Bödecs. All rights reserved.
//

import XCTest
@testable import CoreKit


class ArrayUnique_Tests: XCTestCase {

    func test() {
        let sample1: [String] = ["a", "b", "a", "a", "c", "b"]
        let sample2: [String] = []

        XCTAssert(
            sample1.unique.count == 3 &&
            sample1.unique.contains("a") &&
            sample1.unique.contains("b") &&
            sample1.unique.contains("c")
        )

        XCTAssert(sample2.unique.count == 0)
    }
}


