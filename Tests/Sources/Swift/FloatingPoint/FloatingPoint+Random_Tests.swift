//
//  FloatingPoint+Random_Tests.swift
//  CoreKit-Tests
//
//  Created by Tibor Bödecs on 2017. 09. 26..
//  Copyright © 2017. Tibor Bödecs. All rights reserved.
//

import XCTest
@testable import CoreKit


class FloatingPointRandom_Tests: XCTestCase {
    
    func test() {
        let randomFloat = Float.random
        let randomDouble = Double.random

        XCTAssert(randomFloat > 0)
        XCTAssert(randomDouble > 0)
    }
}

