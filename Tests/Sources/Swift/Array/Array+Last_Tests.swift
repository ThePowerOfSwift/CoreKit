//
//  Array+Last_Tests
//  CoreKit-Tests
//
//  Created by Tibor Bödecs on 2017. 09. 26..
//  Copyright © 2017. Tibor Bödecs. All rights reserved.
//

import XCTest
@testable import CoreKit


class ArrayLast_Tests: XCTestCase {
    
    func test() {
        let sample1: [String] = ["a", "b", "c"]
        let sample2: [String] = []

        XCTAssert(sample1.last(-1) == [])
        XCTAssert(sample1.last(1).first == sample1.last)
        XCTAssert(sample1.last(2) == ["b", "c"])
        XCTAssert(sample1.last(5) == ["a", "b", "c"])
        XCTAssert(sample2.last(1) == [])
    }
}
