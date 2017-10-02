//
//  Device.swift
//  CoreKit
//
//  Created by Tibor Bödecs on 2017. 09. 26..
//  Copyright © 2017. Tibor Bödecs. All rights reserved.
//


/**
 Contains informations about the actual device
 */
public struct Device {

    /**
     CPU architectures
     */
    public enum Architecture {
        case arch64
        case arch32
    }
    
    /**
     Returns the CPU architecture of the device
     
     - returns: CPU Architecture enum
     */
    public static var architecture: Architecture {
        if MemoryLayout<Int>.size == MemoryLayout<Int64>.size {
            return .arch64
        }
        return .arch32
    }
}

