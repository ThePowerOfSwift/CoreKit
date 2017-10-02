//
//  Result_Tests.swift
//  CoreKit-Tests
//
//  Created by Tibor Bödecs on 2017. 09. 27..
//  Copyright © 2017. Tibor Bödecs. All rights reserved.
//

import XCTest
@testable import CoreKit


class Result_Tests: XCTestCase {
    
    enum MyError: Error {
        case problem
    }

    func test() {
        
        let res1 = Result.success(6)
        let res2 = Result<Int>.failure(MyError.problem)
        
        if case let Result.success(value) = res1 {
            XCTAssert(value == 6)
        }

        if case let Result.failure(value) = res2 {
            switch value {
            case MyError.problem:
                XCTAssert(value as? MyError != nil)
            default:
                XCTFail("This should be a different error.")
            }
        }
        
        do {
            let mapTest = try res1.map { String($0) }.resolve()
            XCTAssert(mapTest == "6")
            
            let flatMapTest = try res1.flatMap { _ in Result.success(Float(1.1)) }.resolve()

            XCTAssert(flatMapTest == 1.1)
        }
        catch {
            XCTFail(error.localizedDescription)
        }
        
        do {
            let _ = try res2.map { _ in "failure" }.resolve()

            XCTFail("This should not be called.")
        }
        catch {
            XCTAssert(error is MyError)
        }

        do {
            let _ = try res2.flatMap { _ in Result.success(1) }.resolve()
            
            XCTFail("This should not be called.")
        }
        catch {
            XCTAssert(error is MyError)
        }
    }
    
    func testThrowableInit() {
        let res3 = Result<Int> { () -> Int in
            return 1
        }
        let res4 = Result<Int> { () -> Int in
            throw MyError.problem
        }
        
        do {
            let res3resolved = try res3.resolve()
            XCTAssert(res3resolved == 1)
        }
        catch {
            XCTFail(error.localizedDescription)
        }
        
        do {
            let _ = try res4.resolve()
            
            XCTFail("This should not be called.")
        }
        catch {
            XCTAssert(error is MyError)
        }
    }
}


