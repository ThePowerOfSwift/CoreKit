//
//  Blocks.swift
//  CoreKit
//
//  Created by Tibor Bodecs on 05/09/16.
//  Copyright © 2016 Tibor Bodecs. All rights reserved.
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

