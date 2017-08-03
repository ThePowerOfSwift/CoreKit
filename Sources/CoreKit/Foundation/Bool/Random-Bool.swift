//
//  Random-Bool.swift
//  CoreKit
//
//  Created by Tibor Bodecs on 06/09/16.
//  Copyright © 2016 Tibor Bodecs. All rights reserved.
//
#if os(iOS) || os(tvOS) || os(watchOS) || os(macOS)
import Foundation


extension Bool {

    /**
     Returns a random boolean value
     */
    var random: Bool {
        return arc4random_uniform(2) == 0
    }

}
#endif