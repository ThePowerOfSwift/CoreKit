//
//  String+JsonMinified_Tests.swift
//  CoreKit
//
//  Created by Tibor Bödecs on 2017. 09. 27..
//  Copyright © 2017. Tibor Bödecs. All rights reserved.
//

import XCTest
@testable import CoreKit



class StringJsonMinified_Tests: XCTestCase {
    
    func test() {
        
        let str1 = """
            // this is a JSON file with comments
            {
                "foo": "bar",    // this is cool
                "bar": [
                "baz", "bum", "zam"
                ],
                /* the rest of this document is just fluff
                 in case you are interested. */
                "something": 10,
                "else": 20
            }

            /* NOTE: You can easily strip the whitespace and comments
             from such a file with the JSON.minify() project hosted
             here on github at http://github.com/getify/JSON.minify
             */
        """

        let str2 = """
            {"/*":"*/","//":"",/*"//"*/"/*/"://
                "//"}
        """

        let str3 = """
            /*
             this is a
             multi line comment */{
                
                "foo"
                :
                "bar/*"// something
                ,    "b\"az":/*
                 something else */"blah"
                
            }
        """

        let str4 = """
            {"foo": "ba\"r//", "bar\\": "b\\\"a/*z",
            "baz\\\\": /* yay */ "fo\\\\\"*/o"
            }
        """
        
        XCTAssert(!str1.isEmpty)
        XCTAssert(!str2.isEmpty)
        XCTAssert(!str3.isEmpty)
        XCTAssert(!str4.isEmpty)
    }
}
