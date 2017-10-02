//
//  ExpressibleByIntegerLiteral+Random_Tests.swift
//  CoreKit-Tests
//
//  Created by Tibor Bödecs on 2017. 09. 26..
//  Copyright © 2017. Tibor Bödecs. All rights reserved.
//

import XCTest
@testable import CoreKit


class ExpressibleByIntegerLiteralRandom_Tests: XCTestCase {
    
    func test() {
        
        let intRandom = Int.random
        let int8Random = Int8.random
        let int16Random = Int16.random
        let int32Random = Int32.random
        let int64Random = Int64.random
        
        let uintRandom = UInt.random
        let uint8Random = UInt8.random
        let uint16Random = UInt16.random
        let uint32Random = UInt32.random
        let uint64Random = UInt64.random
        
        XCTAssert(intRandom > Int.min && intRandom < Int.max)
        XCTAssert(int8Random > Int8.min && int8Random < Int8.max)
        XCTAssert(int16Random > Int16.min && int16Random < Int16.max)
        XCTAssert(int32Random > Int32.min && int32Random < Int32.max)
        XCTAssert(int64Random > Int64.min && int64Random < Int64.max)
        
        XCTAssert(uintRandom > UInt.min && uintRandom < UInt.max)
        XCTAssert(uint8Random > UInt8.min && uint8Random < UInt8.max)
        XCTAssert(uint16Random > UInt16.min && uint16Random < UInt16.max)
        XCTAssert(uint32Random > UInt32.min && uint32Random < UInt32.max)
        XCTAssert(uint64Random > UInt64.min && uint64Random < UInt64.max)
    }
}



