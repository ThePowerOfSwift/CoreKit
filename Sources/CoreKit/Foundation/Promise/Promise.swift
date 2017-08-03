//
//    Promise.swift
//    CoreKit
//
//    Created by Tibor Bodecs on 29/08/16.
//    Copyright © 2016 Tibor Bodecs. All rights reserved.
//

import Foundation
#if os(Linux)
import Dispatch
#endif


public enum PromiseError: Error {
    case validation
    case timeout
}

fileprivate struct Callback<T> {

    fileprivate let queue: DispatchQueue
    private let onSuccess: ValueBlock<T>
    private let onFailure: ErrorBlock

    fileprivate init(queue: DispatchQueue, onSuccess: @escaping ValueBlock<T>, onFailure: @escaping ErrorBlock) {
        self.queue     = queue
        self.onSuccess = onSuccess
        self.onFailure = onFailure
    }

    fileprivate func callSuccess(_ value: T) {
        self.queue.async { self.onSuccess(value) }
    }

    fileprivate func callFailure(_ error: Error) {
        self.queue.async { self.onFailure(error) }
    }
}

public enum PromiseState<T> {

    case pending
    case fulfilled(value: T)
    case rejected(error: Error)

    fileprivate var isPending: Bool {
        if case .pending = self {
            return true
        }
        return false
    }

    fileprivate var isFulfilled: Bool {
        if case .fulfilled = self {
            return true
        }
        return false
    }

    fileprivate var isRejected: Bool {
        if case .rejected = self {
            return true
        }
        return false
    }

    fileprivate var value: T? {
        if case .fulfilled(let value) = self {
            return value
        }
        return nil
    }

    fileprivate var error: Error? {
        if case .rejected(let error) = self {
            return error
        }
        return nil
    }
}


open class Promise<T> {

    private var state: PromiseState<T>
    private let lockQueue = DispatchQueue(label: "com.corekit.promise.lock", qos: .userInitiated)
    private var callbacks: [Callback<T>] = []
    private var executionQueue: DispatchQueue!

    /*
     --------------------------------------------------------------------------------------------------------------
     init
     --------------------------------------------------------------------------------------------------------------
     */

    public init(_ on: DispatchQueue = .global(qos: .userInitiated), _ state: PromiseState<T> = .pending) {
        self.executionQueue = on
        self.state          = state
    }

    public convenience init(on queue: DispatchQueue = .global(qos: .userInitiated), value: T) {
        self.init(queue, .fulfilled(value: value))
    }

    public convenience init(on queue: DispatchQueue = .global(qos: .userInitiated), error: Error) {
        self.init(queue, .rejected(error: error))
    }

    public convenience init(on queue: DispatchQueue = .global(qos: .userInitiated),
                            block: @escaping (_ fulfill: @escaping ValueBlock<T>,
                                              _ reject: @escaping ErrorBlock) throws -> Void)
    {
        self.init(queue)

        queue.async {
            do {
                try block(self.fulfill, self.reject)
            }
            catch {
                self.reject(error)
            }
        }
    }

    public convenience init(queue: DispatchQueue = .global(qos: .userInitiated),
                            block: @escaping () throws -> T)
    {
        self.init(queue)

        queue.async {
            do {
                self.fulfill(try block())
            }
            catch {
                self.reject(error)
            }
        }
    }

    /*
     --------------------------------------------------------------------------------------------------------------
     then
     --------------------------------------------------------------------------------------------------------------
     */

    @discardableResult
    public func then(on queue: DispatchQueue? = nil,
                     success: @escaping ValueBlock<T>,
                     failure: @escaping ErrorBlock) -> Promise<T>
    {
        let executionQueue = queue ?? self.executionQueue ?? .main

//        let callback = self.callbacks.last
//        callback?.queue

        return Promise<T>(on: self.executionQueue) { fulfill, reject in
            self.addCallbacks(
                on: executionQueue,
                onFulfilled: { value in
                    fulfill(value)
                    success(value)
                }, onRejected: { error in
                    reject(error)
                    failure(error)
                }
            )
        }
    }

    /*
     --------------------------------------------------------------------------------------------------------------
     success && failure
     --------------------------------------------------------------------------------------------------------------
     */

    @discardableResult
    public func success(on queue: DispatchQueue? = nil, _ success: @escaping ValueBlock<T>) -> Promise<T> {
        return self.then(on: queue, success: success, failure: { _ in })
    }

    @discardableResult
    public func failure(on queue: DispatchQueue? = nil, _ failure: @escaping ErrorBlock) -> Promise<T> {
        return self.then(on: queue, success: { _ in }, failure: failure)
    }


    /*
     --------------------------------------------------------------------------------------------------------------
     flatMap && map
     --------------------------------------------------------------------------------------------------------------
     */

    @discardableResult
    public func flatMap<U>(on queue: DispatchQueue? = nil, _ f: @escaping ((T) -> Promise<U>)) -> Promise<U> {

        let executionQueue = queue ?? self.executionQueue ?? .main

        return Promise<U>(on: self.executionQueue) { fulfill, reject in
            self.addCallbacks(
                on: executionQueue,
                onFulfilled: { value in f(value).then(on: queue, success: fulfill, failure: reject) },
                onRejected: reject
            )
        }
    }

    @discardableResult
    public func map<U>(on queue: DispatchQueue? = nil, _ f: @escaping ((T) throws -> U)) -> Promise<U> {

        let executionQueue = queue ?? self.executionQueue ?? .main

        return self.flatMap(on: executionQueue, { (value) -> Promise<U> in
            do {
                return Promise<U>(on: self.executionQueue, value: try f(value))
            }
            catch {
                return Promise<U>(on: self.executionQueue, error: error)
            }
        })
    }

    /*
     --------------------------------------------------------------------------------------------------------------
     state updates
     --------------------------------------------------------------------------------------------------------------
     */

    private func updateState(_ state: PromiseState<T>) {
        guard self.isPending else { return }
        self.lockQueue.sync { self.state = state }
        self.fireCallbacksIfCompleted()
    }

    public func reject(_ error: Error) {
        self.updateState(.rejected(error: error))
    }

    public func fulfill(_ value: T) {
        self.updateState(.fulfilled(value: value))
    }

    /*
     --------------------------------------------------------------------------------------------------------------
     values
     --------------------------------------------------------------------------------------------------------------
     */

    public var isPending: Bool {
        return !self.isFulfilled && !self.isRejected
    }

    public var isFulfilled: Bool {
        return self.value != nil
    }

    public var isRejected: Bool {
        return self.error != nil
    }

    public var value: T? {
        return self.lockQueue.sync {
            return self.state.value
        }
    }

    public var error: Error? {
        return self.lockQueue.sync {
            return self.state.error
        }
    }

    /*
     --------------------------------------------------------------------------------------------------------------
     helpers
     --------------------------------------------------------------------------------------------------------------
     */

    private func addCallbacks(on queue: DispatchQueue,
                              onFulfilled: @escaping ValueBlock<T>,
                              onRejected: @escaping ErrorBlock)
    {
        let callback = Callback(queue: queue, onSuccess: onFulfilled, onFailure: onRejected)
        self.lockQueue.async { self.callbacks.append(callback) }
        self.fireCallbacksIfCompleted()
    }

    private func fireCallbacksIfCompleted() {
        self.lockQueue.async {
            guard !self.state.isPending else { return }
            self.callbacks.forEach { callback in
                switch self.state {
                case let .fulfilled(value):
                    callback.callSuccess(value)
                case let .rejected(error):
                    callback.callFailure(error)
                default:
                    break
                }
            }
            self.callbacks.removeAll()
        }
    }

}


extension Promise {

    public func validate(_ condition: @escaping (T) -> Bool) -> Promise<T> {
        return self.map { value -> T in
            guard condition(value) else {
                throw PromiseError.validation
            }
            return value
        }
    }

    @discardableResult
    public static func all<T>(_ promises: [Promise<T>]) -> Promise<[T]> {
        return Promise<[T]> { fulfill, reject in
            guard !promises.isEmpty else { fulfill([]); return }

            for promise in promises {
                promise.then(success: { value in
                    if !promises.contains(where: { $0.isRejected || $0.isPending }) {
                        fulfill(promises.flatMap { $0.value })
                    }
                }, failure: reject)
            }
        }
    }

    @discardableResult
    public static func delay(_ delay: TimeInterval) -> Promise<Void> {
        return Promise<Void> { fulfill, reject in
            let time = DispatchTime.now() + delay
            DispatchQueue.main.asyncAfter(deadline: time) { fulfill(()) }
        }
    }

    @discardableResult
    public static func timeout<T>(_ timeout: TimeInterval) -> Promise<T> {
        return Promise<T> { fulfill, reject in
            Promise<T>.delay(timeout).success { _ in
                reject(PromiseError.timeout)
            }
        }
    }

    @discardableResult
    public static func race<T>(_ promises: [Promise<T>]) -> Promise<T> {
        return Promise<T> { fulfill, reject in
            guard !promises.isEmpty else { fatalError() }
            for promise in promises {
                promise.then(success: fulfill, failure: reject)
            }
        }
    }

    @discardableResult
    public static func zip<T, U>(_ first: Promise<T>, with second: Promise<U>) -> Promise<(T, U)> {
        return Promise<(T, U)> { fulfill, reject in
            let resolver: (Any) -> () = { _ in
                if let firstValue = first.value, let secondValue = second.value {
                    fulfill((firstValue, secondValue))
                }
            }
            first.then(success: resolver, failure: reject)
            second.then(success: resolver, failure: reject)
        }
    }

    @discardableResult
    public func always(on queue: DispatchQueue? = nil, _ block: @escaping () -> Void) -> Promise<T> {
        return self.then(on: queue, success: { _ in block() }, failure: { _ in block() } )
    }

    @discardableResult
    public func addTimeout(_ timeout: TimeInterval) -> Promise<T> {
        return Promise.race(Array([self, Promise<T>.timeout(timeout)]))
    }

    @discardableResult
    public func recover(recovery: @escaping (Error) throws -> Promise<T>) -> Promise<T> {
        return Promise<T> { fulfill, reject in
            self.then(success: fulfill, failure: { error in
                do {
                    try recovery(error).then(success: fulfill, failure: reject)
                }
                catch {
                    reject(error)
                }
            })
        }
    }

    @discardableResult
    public static func retry<T>(count: Int, delay: TimeInterval, generate: @escaping () -> Promise<T>) -> Promise<T> {
        if count <= 0 {
            return generate()
        }
        return Promise<T> { fulfill, reject in
            generate()
            .recover { error in
                return self.delay(delay).flatMap { _ in
                    return self.retry(count: count-1, delay: delay, generate: generate)
                }
            }
            .then(success: fulfill, failure: reject)
        }
    }

}
