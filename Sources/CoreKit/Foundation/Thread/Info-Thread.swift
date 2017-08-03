//
//  Info-Thread.swift
//  CoreKit
//
//  Created by Tibor Bodecs on 13/07/16.
//  Copyright © 2016 Tibor Bodecs. All rights reserved.
//

import Foundation


public extension Thread {

    private func descriptionValue(_ keyName: String) -> String? {
        let pairs = self.description.components(separatedBy: ",")
        for pair in pairs {
            let components = pair.components(separatedBy: "=")
            if
                let key   = components.first, key.range(of: keyName) != nil,
                let value = components.last
            {
                var characters = NSCharacterSet.whitespaces
                characters.formUnion(CharacterSet(charactersIn: "{}"))
                return value.trimmingCharacters(in: characters)
            }
        }
        return nil
    }

    /*
     --------------------------------------------------------------------------------------------------------------
     api
     --------------------------------------------------------------------------------------------------------------
     */

    /**
     Label aka. name of the thread.
     */
    public var label: String {
        if let name = self.descriptionValue("name"), name != "(null)" {
            return name
        }
        if Thread.isMainThread {
            return "main"
        }
        if let threadName = Thread.current.name, !threadName.isEmpty {
            return threadName
        }
#if os(iOS) || os(tvOS) || os(watchOS) || os(macOS)
        if let queueName = String(validatingUTF8: __dispatch_queue_get_label(nil)) {
            return queueName
        }
#endif
#if os(iOS) || os(tvOS) || os(watchOS) || os(macOS)
        return String(format: "%p", Thread.current)
#endif
#if os(Linux)
        return String(format: "%p", Thread.current as! CVarArg)
#endif
    }

    /**
     Unknown thread number constant
     */
    public static var unknownThreadNumber: Int { return -1 }

    /**
     Number of the thread.
     */
    public var number: Int {
        guard let rawValue = self.descriptionValue("number"), let intValue = Int(rawValue) else {
            return Thread.unknownThreadNumber
        }
        return intValue
    }

}
