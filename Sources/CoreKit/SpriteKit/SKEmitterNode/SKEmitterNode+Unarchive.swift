//
//  SKEmitterNode+Unarchive.swift
//  CoreKit
//
//  Created by Tibor Bödecs on 2017. 09. 27..
//  Copyright © 2017. Tibor Bödecs. All rights reserved.
//

import SpriteKit.SKEmitterNode


public extension SKEmitterNode {

    public static func unarchiveEmitterNode(file: String) -> SKEmitterNode? {
        if let path = Bundle.main.path(forResource: file, ofType: "sks") {
            return NSKeyedUnarchiver.unarchiveObject(withFile: path) as? SKEmitterNode
        }
        return nil
    }
}
