//
//  Blocks.swift
//  CoreKit
//
//  Created by Tibor Bödecs on 2017. 09. 26..
//  Copyright © 2017. Tibor Bödecs. All rights reserved.
//


/**
 Generic void block
 */
public typealias VoidBlock = () -> Void

/**
 Generic value block
 */
public typealias ValueBlock<T> = (T) -> Void

/**
 Generic error block
 */
public typealias ErrorBlock = (Error) -> Void


