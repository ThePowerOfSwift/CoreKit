//
//  Bool+Random_Tests.swift
//  CoreKit-Tests
//
//  Created by Tibor Bödecs on 2017. 09. 26..
//  Copyright © 2017. Tibor Bödecs. All rights reserved.
//

import XCTest
@testable import CoreKit


class BoolRandom_Tests: XCTestCase {
    
    func test() {
        let random = Bool.random

        XCTAssert(random == true || random == false)
    }
}


