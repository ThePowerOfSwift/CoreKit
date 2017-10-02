//
//  String+CapitalizedFirstCharacter.swift
//  CoreKit
//
//  Created by Tibor Bödecs on 2017. 09. 27..
//  Copyright © 2017. Tibor Bödecs. All rights reserved.
//


extension String {
    
    /**
     Converts the first letter of the string to an upper case letter
     
     - returns: The string with a capitalized first letter
     */
    public var capitalizedFirstCharacter: String {
        if self.count > 1 {
            let startIndex = self.index(self.startIndex, offsetBy: 1)
            let begin = self[..<startIndex]
            let end = self[startIndex...]
            let first = begin.uppercased()
            return first + end
        }
        return self.capitalized
    }
    
}
