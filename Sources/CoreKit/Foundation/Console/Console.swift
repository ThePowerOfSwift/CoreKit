//
//  Dlog.swift
//  CoreKit
//
//  Created by Tibor Bodecs on 08/07/16.
//  Copyright © 2016 Tibor Bodecs. All rights reserved.
//

import Foundation


open class Console {

    public var name: String
    public var logLevel: LogLevel = .none

    public enum LogLevel: Int, Comparable, CustomStringConvertible, EnumCollection {
        case none
        case verbose
        case debug
        case info
        case warning
        case error

        public static func == (lhs: LogLevel, rhs: LogLevel) -> Bool {
            return lhs.rawValue == lhs.rawValue
        }

        public static func < (lhs: LogLevel, rhs: LogLevel) -> Bool {
            return lhs.rawValue < rhs.rawValue
        }

        public var description: String {
            switch self {
            case .none:    return "none"
            case .verbose: return "verbose"
            case .debug:   return "debug"
            case .info:    return "info"
            case .warning: return "warning"
            case .error:   return "error"
            }
        }
    }



    /*
     --------------------------------------------------------------------------------------------------------------
     default
     --------------------------------------------------------------------------------------------------------------
     */

    public static let defaultName = "default"

    public static let `default` = Console(name: Console.defaultName)

    private init(name: String) {
        self.name = name
    }

    /*
     --------------------------------------------------------------------------------------------------------------
     consoles
     --------------------------------------------------------------------------------------------------------------
     */
    public private(set) static var consoles: [Console] = [Console.default]

    public static func get(name: String) -> Console {
        if name == defaultName {
            return Console.default
        }
        if let console = Console.consoles.filter({ $0.name == name }).first {
            return console
        }

        let newConsole = Console(name: name)
        Console.consoles.append(newConsole)
        return newConsole
    }

    /*
     --------------------------------------------------------------------------------------------------------------
     dateFormatter
     --------------------------------------------------------------------------------------------------------------
     */
    private var _dateFormatter: DateFormatter?

    private var dateFormatter: DateFormatter {
        if self._dateFormatter == nil {
            let formatter        = DateFormatter()
            formatter.locale     = NSLocale.current
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
            self._dateFormatter  = formatter
        }
        return self._dateFormatter!
    }

    /*
     --------------------------------------------------------------------------------------------------------------
     log
     --------------------------------------------------------------------------------------------------------------
     */

    @discardableResult
    fileprivate func _log<T>(level: LogLevel,
                          _ object: @autoclosure () -> T,
                            _ file: String,
                        _ function: String,
                            _ line: Int,
                          _ column: Int) -> String?
    {
        guard self.logLevel >= level else { return nil }

        var fileName = "unknown"
        if let url = URL(string: file), let name = url.lastPathComponent.components(separatedBy: ".").first {
            fileName = name
        }

#if os(iOS) || os(tvOS) || os(watchOS) || os(macOS)
    let dateString = self.dateFormatter.string(from: Date())
    let details = String(format: "[%@][%@][%@][%@:%d,%d].%@<%@(%d)>\n",
                             dateString,
                             self.name,
                             level.description,
                             fileName,
                             line,
                             column,
                             function,
                             Thread.current.label,
                             Thread.current.number
                        )
#endif
#if os(Linux)
    let dateString = self.dateFormatter.string(from: Date()) as! CVarArg
    let details = String(format: "[%@][%@][%@][%@:%d,%d].%@<%@(%d)>\n",
                             dateString,
                             self.name as! CVarArg,
                             level.description as! CVarArg,
                             fileName as! CVarArg,
                             line,
                             column,
                             function as! CVarArg,
                             Thread.current.label as! CVarArg,
                             Thread.current.number
                        )

#endif



        let message = "\(details)\(object())\n\n"
        print(message)
        return message
    }

}

extension Console: CustomStringConvertible {

    public var description: String {
        return "Console: '" + self.name + "', level: '" + self.logLevel.description + "'"
    }
}


/*
 --------------------------------------------------------------------------------------------------------------
 log methods
 --------------------------------------------------------------------------------------------------------------
 */
public extension Console {

    @discardableResult
    public func log<T>(_ object: @autoclosure () -> T,
                         _ file: String = #file,
                     _ function: String = #function,
                         _ line: Int = #line,
                       _ column: Int = #column) -> String?
    {
        return self._log(level: .verbose, object, file, function, line, column)
    }

    @discardableResult
    public func debug<T>(_ object: @autoclosure () -> T,
                           _ file: String = #file,
                       _ function: String = #function,
                           _ line: Int = #line,
                         _ column: Int = #column) -> String?
    {
        return self._log(level: .debug, object, file, function, line, column)
    }

    @discardableResult
    public func info<T>(_ object: @autoclosure () -> T,
                          _ file: String = #file,
                      _ function: String = #function,
                          _ line: Int = #line,
                        _ column: Int = #column) -> String?
    {
        return self._log(level: .info, object, file, function, line, column)
    }

    @discardableResult
    public func warning<T>(_ object: @autoclosure () -> T,
                             _ file: String = #file,
                         _ function: String = #function,
                             _ line: Int = #line,
                           _ column: Int = #column) -> String?
    {
        return self._log(level: .warning, object, file, function, line, column)
    }

    @discardableResult
    public func error<T>(_ object: @autoclosure () -> T,
                           _ file: String = #file,
                       _ function: String = #function,
                           _ line: Int = #line,
                         _ column: Int = #column) -> String?
    {
        return self._log(level: .error, object, file, function, line, column)
    }
}

/*
 --------------------------------------------------------------------------------------------------------------
 default
 --------------------------------------------------------------------------------------------------------------
 */
public extension Console {

    @discardableResult
    public static func log<T>(_ object: @autoclosure () -> T,
                                _ file: String = #file,
                            _ function: String = #function,
                                _ line: Int = #line,
                              _ column: Int = #column) -> String?
    {
        return Console.default.log(object, file, function, line, column)
    }

    @discardableResult
    public static func debug<T>(_ object: @autoclosure () -> T,
                                  _ file: String = #file,
                              _ function: String = #function,
                                  _ line: Int = #line,
                                _ column: Int = #column) -> String?
    {
        return Console.default.debug(object, file, function, line, column)
    }

    @discardableResult
    public static func info<T>(_ object: @autoclosure () -> T,
                                 _ file: String = #file,
                             _ function: String = #function,
                                 _ line: Int = #line,
                               _ column: Int = #column) -> String?
    {
        return Console.default.info(object, file, function, line, column)
    }

    @discardableResult
    public static func warning<T>(_ object: @autoclosure () -> T,
                                    _ file: String = #file,
                                _ function: String = #function,
                                    _ line: Int = #line,
                                  _ column: Int = #column) -> String?
    {
        return Console.default.warning(object, file, function, line, column)
    }

    @discardableResult
    public static func error<T>(_ object: @autoclosure () -> T,
                                  _ file: String = #file,
                              _ function: String = #function,
                                  _ line: Int = #line,
                                _ column: Int = #column) -> String?
    {
        return Console.default.error(object, file, function, line, column)
    }

}
