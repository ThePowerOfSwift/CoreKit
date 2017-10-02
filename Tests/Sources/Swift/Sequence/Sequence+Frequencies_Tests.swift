//
//  Sequence+Frequencies_Tests.swift
//  CoreKit-Tests
//
//  Created by Tibor Bödecs on 2017. 09. 27..
//  Copyright © 2017. Tibor Bödecs. All rights reserved.
//

import XCTest
@testable import CoreKit


class SequenceFrequencies_Tests: XCTestCase {
    
    func test() {
        
        let seq1: [String] = ["a", "b", "a", "b", "a", "c"]
        let seq2: [String] = []
        let freq = seq1.frequencies
        
        XCTAssert(
            freq.count == 3 &&
            freq[0].0 == "a" &&
            freq[0].1 == 3 &&
            freq[1].0 == "b" &&
            freq[1].1 == 2 &&
            freq[2].0 == "c" &&
            freq[2].1 == 1
        )
        
        XCTAssert(seq2.frequencies.isEmpty)
    }
}




