//
//  String+FirstWord.swift
//  CoreKit
//
//  Created by Tibor Bödecs on 2017. 09. 27..
//  Copyright © 2017. Tibor Bödecs. All rights reserved.
//

extension String {
    
    /**
     Returns the first word of the string
     */
    var firstWord: String? {
        return self.split(separator: " ").map { String($0) }.first
    }
}

