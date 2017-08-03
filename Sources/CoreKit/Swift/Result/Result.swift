//
//  Result.swift
//  CoreKit
//
//  Created by Tibor Bodecs on 2016. 09. 14..
//  Copyright © 2016. Tibor Bodecs. All rights reserved.
//



public enum Result<T> {
    case success(T)
    case failure(Error)
}


public extension Result {

    public func map<U>(f: (T) -> U) -> Result<U> {
        switch self {
        case .success(let t):
            return .success(f(t))
        case .failure(let err):
            return .failure(err)
        }
    }

    public func flatMap<U>(f: (T) -> Result<U>) -> Result<U> {
        switch self {
        case .success(let t):
            return f(t)
        case .failure(let err):
            return .failure(err)
        }
    }
}

public extension Result
{
    public func resolve() throws -> T {
        switch self {
        case .success(let value):
            return value
        case .failure(let error):
            throw error
        }
    }

    public init(_ throwingExpr: (() throws -> T)) {
        do {
            let value = try throwingExpr()
            self = .success(value)
        }
        catch {
            self = .failure(error)
        }
    }
}
