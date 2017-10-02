//
//  CharacterSet+Union.swift
//  CoreKit
//
//  Created by Tibor Bödecs on 2017. 09. 27..
//  Copyright © 2017. Tibor Bödecs. All rights reserved.
//

import Foundation.NSCharacterSet


public extension CharacterSet {

    public static func +(lhs: CharacterSet, rhs: CharacterSet) -> CharacterSet {
        let charset = NSMutableCharacterSet()
        charset.formUnion(with: lhs)
        charset.formUnion(with: rhs)
        return charset as CharacterSet
    }
}
