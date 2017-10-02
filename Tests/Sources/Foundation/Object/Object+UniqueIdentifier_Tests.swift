//
//  Object+UniqueIdentifier_Tests.swift
//  CoreKit
//
//  Created by Tibor Bödecs on 2017. 09. 29..
//  Copyright © 2017. Tibor Bödecs. All rights reserved.
//

import XCTest
@testable import CoreKit


class ObjectUniqueIdentifier_Tests: XCTestCase {
    
    func test() {
        
        XCTAssert("NSObject" == NSObject.uniqueIdentifier)

        #if os(iOS) || os(tvOS)
            XCTAssert("UIViewController" == AppleViewController.uniqueIdentifier)
        #endif
        #if os(macOS)
            XCTAssert("NSViewController" == AppleViewController.uniqueIdentifier)
        #endif
    }
}

