//
//  Json-Data.swift
//  Twitter
//
//  Created by Tibor Bodecs on 11/08/16.
//  Copyright © 2016 Tibor Bodecs. All rights reserved.
//

import Foundation


/**
 Json object
 */
public typealias Json = [String:Any]

/**
 Implement this protocol if you object is constructable form a json object.
 */
public protocol JsonRepresentable {

    init(object: Json) throws

    var jsonValue: Json? { get }
}

public extension JsonRepresentable {

    var jsonValue: Json? {
        return nil
    }
}


/**
 This protocol is for json errors.
 */
public enum JsonError: Error {

    case missing(String)
    case invalid(Any?)
    case parse(Any?)
    case type(Any?)
}


public extension Dictionary where Key: ExpressibleByStringLiteral, Key: Comparable, Value: Any {

    public func toData(_ options: JSONSerialization.WritingOptions = []) throws -> Data {
        do {
            return try JSONSerialization.data(withJSONObject: self, options: options)
        }
        catch {
            throw JsonError.invalid(self)
        }
    }
}


public extension Data {

    

    /**
     Converts a data object to a value type.

     - throws: `JsonError.parse` with the original data, if the json could not be parsed.

     - returns: T
     */

    public func toValue<T>(options: JSONSerialization.ReadingOptions = [.allowFragments]) throws -> T {
        let json = try JSONSerialization.jsonObject(with: self, options: options)
        if let object  = json as? T {
            return object
        }
        throw JsonError.type(json)
    }

    /**
     Converts a data object to a Json object.

     - throws: `JsonError.parse` with the original data, if the json could not be parsed.

     - returns: Json
     */
    public func toJsonObject(options: JSONSerialization.ReadingOptions = [.allowFragments]) throws -> Json {
        return try self.toValue(options: options)
    }

    /**
     Converts a data object to an array of Json objects.

     - throws: `JsonError.parse` with the original data, if the json could not be parsed.

     - returns: [Json]
     */
    public func toJsonArray(options: JSONSerialization.ReadingOptions = [.allowFragments]) throws -> [Json] {
        return try self.toValue(options: options)
    }
}
