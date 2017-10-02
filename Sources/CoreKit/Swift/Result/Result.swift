//
//  Result.swift
//  CoreKit
//
//  Created by Tibor Bödecs on 2017. 09. 27..
//  Copyright © 2017. Tibor Bödecs. All rights reserved.
//

/**
 Generic result type
 */
public enum Result<T> {
    case success(T)
    case failure(Error)
}


public extension Result {
    
    /**
     Maps the result type to a new value
     
     - parameter _ transform: A mapping closure.
     - returns: A result containing the transformed value
     */
    public func map<U>(_ transform: (T) -> U) -> Result<U> {
        switch self {
        case .success(let t):
            return .success(transform(t))
        case .failure(let err):
            return .failure(err)
        }
    }
    
    /**
     Maps the result type to a new value
     
     - parameter _ transform: A mapping closure.
     - returns: A result containing the transformed value
     */
    public func flatMap<U>(transform: (T) -> Result<U>) -> Result<U> {
        switch self {
        case .success(let t):
            return transform(t)
        case .failure(let err):
            return .failure(err)
        }
    }
}

public extension Result
{
    /**
     Resolves a result to a throwing error or a value
     
     - returns: An error thrown or a value returned
     */
    public func resolve() throws -> T {
        switch self {
        case .success(let value):
            return value
        case .failure(let error):
            throw error
        }
    }
    
    /**
     Initializes a Result with a throwing expression
     
     - parameter _ throwingExpression: An expression to run
     - returns: A result containing the outcome of the expression
     */
    public init(_ throwingExpression: (() throws -> T)) {
        do {
            let value = try throwingExpression()
            self = .success(value)
        }
        catch {
            self = .failure(error)
        }
    }
}

