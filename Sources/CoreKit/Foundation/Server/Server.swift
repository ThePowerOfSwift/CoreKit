//
//  Server.swift
//  CoreKit
//
//  Created by Tibor Bödecs on 2017. 09. 27..
//  Copyright © 2017. Tibor Bödecs. All rights reserved.
//

import Foundation.NSURLSession


extension Int {
    var megabyte: Int { return self * 1_048_576 }
}

fileprivate extension URLResponse {
    static let unknownContentLength = Int64(-1)
}


/**
 *  Server
 *
 *  - do reachability check here
 */
open class Server: NSObject {

    /**
     *  The domain name to connect
     */
    open var domain: String

    /**
     *  The base path of the server
     */
    open var basePath: String = "/"

    /**
     *  Global headers
     */
    open var headers: [Request.Header] = []

    /**
     *  Global query parameters
     */
    open var query: [URLQueryItem] = []

    /**
     *  Server user
     */
    open var user: String? = nil

    /**
     *  Password
     */
    open var password: String? = nil

    /**
     *  Scheme
     */
    open var scheme: String = "https"

    /**
     *  Port
     */
    open var port: Int? = nil


    open var logRequests: Bool = false

    /**
     *  Every server instance has it's own url session object.
     */
    private var session: URLSession!

    /**
     *  URLCache is also per-server based
     */
//    private var cache: URLCache!

    /**
     *  Hold the active tasks for the server (cancel-all)
     */
    fileprivate var responseTasks: [Response] = []



    private var cache: URLCache!

    /**
     *  Init with a single domain
     */
    public init(domain: String) {
        self.domain = domain

        super.init()
#if os(iOS) || os(tvOS) || os(watchOS) || os(macOS)
        self.cache                = URLCache(memoryCapacity: 20.megabyte, diskCapacity: 256.megabyte, diskPath: "NetworkingCache")
        let config                = URLSessionConfiguration.default
        config.requestCachePolicy = .reloadIgnoringLocalCacheData//.ReturnCacheDataDontLoad //ReturnCacheDataElseLoad
        config.urlCache           = self.cache
        //        config.protocolClasses    = [LoggerProtocol.self, CachingProtocol.self]
        //        CachingProtocol.enabled   = false
        self.session              = URLSession(configuration: config, delegate: self, delegateQueue: nil)
#endif
#if os(Linux)
        self.session              = URLSession(configuration: .default, delegate: self, delegateQueue: nil)
#endif
    }


    /**
     *  Makes a request object
     */
    public func request(_ endpoint: Endpoint, log: Bool? = nil) -> Response {
        let request           = endpoint.request

        var components        = URLComponents()
        components.user       = request.user ?? self.user
        components.password   = request.password ?? self.password
        components.port       = request.port ?? self.port
        components.host       = self.domain
        components.scheme     = request.scheme ?? self.scheme
        components.path       = self.basePath + request.path
        components.fragment   = request.fragment

        var queryItems: [String:String?] = [:]
        self.query.forEach { queryItems[$0.name] = $0.value }
        request.query.forEach { queryItems[$0.name] = $0.value }

#if os(iOS) || os(tvOS) || os(watchOS) || os(macOS)
        components.queryItems = queryItems.map { URLQueryItem(name: $0, value: $1) }
        if let query = components.queryItems, query.isEmpty {
            components.queryItems = nil
        }
#endif

    // remove this after swift 3.1 released
    // see https://bugs.swift.org/browse/SR-384
#if os(Linux)
        components.query = queryItems.map { $0.key + "=" + ($0.value ?? "") }.joined(separator: "&")
        if let queryString = components.query, queryString.isEmpty {
            components.query = nil
        }
#endif

        guard let url = components.url else {
            fatalError("Invalid url components.")
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue.uppercased()
        self.headers.forEach { urlRequest.setValue($0.raw.value, forHTTPHeaderField: $0.raw.name) }
        request.headers.forEach { urlRequest.setValue($0.raw.value, forHTTPHeaderField: $0.raw.name) }
        urlRequest.httpBody = request.data


        var shouldLogRequest = self.logRequests
        if let logCurrentRequest = log {
            shouldLogRequest = logCurrentRequest
        }

        if shouldLogRequest {
            print((urlRequest as URLRequest).cURLRepresentation())
        }

        let response = Response(session: self.session, request: urlRequest as URLRequest, task: request.task)

        self.responseTasks.append(response)

        return response
    }
}


extension Server: URLSessionDelegate {

    open func urlSession(_ session: URLSession,
                         didReceive challenge: URLAuthenticationChallenge,
                         completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void)
    {

        return completionHandler(.performDefaultHandling, nil)
#if os(iOS) || os(tvOS) || os(watchOS) || os(macOS)
        //basic ssl pinning
//        let trust = challenge.protectionSpace.serverTrust
//        let remoteCert  = SecTrustGetCertificateAtIndex(trust!, 0)
//        let remoteCertData = SecCertificateCopyData(remoteCert!) as Data
//
//        let certPath = Bundle.main.path(forResource: self.domain, ofType: "cer")
//        let localCertificateData = try! Data(contentsOf: URL(fileURLWithPath: certPath!))
//        let localCertificate = SecCertificateCreateWithData(nil, localCertificateData as CFData)
//
//        if remoteCertData == localCertificateData {
//            let credential = URLCredential(trust: trust!)
//            challenge.sender?.use(credential, for: challenge)
//            completionHandler(.useCredential, credential)
//        }
//        else {
//            completionHandler(.rejectProtectionSpace, nil)
//        }
#endif
    }

    open func urlSession(_ session: URLSession, didBecomeInvalidWithError error: Error?) {

    }

    #if os(iOS) || os(tvOS) || os(watchOS)
    open func urlSessionDidFinishEvents(forBackgroundURLSession session: URLSession) {

    }
    #endif
}


extension Server: URLSessionTaskDelegate {


//    open func urlSession(_ session: URLSession,
//                         task: URLSessionTask,
//                         willPerformHTTPRedirection response: HTTPURLResponse,
//                         newRequest request: URLRequest,
//                         completionHandler: @escaping (URLRequest?) -> Void)
//    {
//        //@todo server check or some block property to disable redirection.
//        //just always redirect...
//        completionHandler(request)
//    }
//
//    open func urlSession(_ session: URLSession,
//                         task: URLSessionTask,
//                         didReceive challenge: URLAuthenticationChallenge,
//                         completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void)
//    {
//        completionHandler(.performDefaultHandling, nil)
//    }
//
//    open func urlSession(_ session: URLSession,
//                         task: URLSessionTask,
//                         needNewBodyStream completionHandler: @escaping (InputStream?) -> Void)
//    {
//        completionHandler(nil)
//    }
//
//    open func urlSession(_ session: URLSession,
//                         task: URLSessionTask,
//                         didSendBodyData bytesSent: Int64,
//                         totalBytesSent: Int64,
//                         totalBytesExpectedToSend: Int64)
//    {
//        //@todo: upload progress tracking here.
//    }

    open func urlSession(_ session: URLSession,
                         task: URLSessionTask,
                         didCompleteWithError error: Error?)
    {
        guard let task = self.responseTasks.filter({ $0.task === task }).first else {
            return
        }
        task.error = error
        task.complete()
    }
}


extension Server: URLSessionDataDelegate {


    open func urlSession(_ session: URLSession,
                         dataTask: URLSessionDataTask,
                         didReceive response: URLResponse,
                         completionHandler: @escaping (URLSession.ResponseDisposition) -> Void)
    {

        guard let task = self.responseTasks.filter({ $0.task === dataTask }).first else {
#if os(iOS) || os(tvOS) || os(watchOS) || os(macOS)
            return completionHandler(.cancel)
#endif
#if os(Linux)
            return
#endif
        }

        task.result = Response.Result(urlResponse: response, data: Data())

#if os(iOS) || os(tvOS) || os(watchOS) || os(macOS)
        task.progress = Progress(totalUnitCount: 1)
        if response.expectedContentLength != URLResponse.unknownContentLength {
            task.progress = Progress(totalUnitCount: response.expectedContentLength)
        }
        task.progressHandler?(task.progress!)

        completionHandler(.allow)
#endif


    }

    open func urlSession(_ session: URLSession,
                         dataTask: URLSessionDataTask,
                         didBecome downloadTask: URLSessionDownloadTask)
    {

    }

    open func urlSession(_ session: URLSession,
                         dataTask: URLSessionDataTask,
                         didReceive data: Data)
    {

        guard let task = self.responseTasks.filter({ $0.task === dataTask }).first else {
            return
        }
#if os(iOS) || os(tvOS) || os(watchOS) || os(macOS)
        task.progress?.completedUnitCount += Int64(data.count)
        task.progressHandler?(task.progress!)
#endif
        task.result?.data?.append(data)
    }

//    open func urlSession(_ session: URLSession,
//                         dataTask: URLSessionDataTask,
//                         willCacheResponse proposedResponse: CachedURLResponse,
//                         completionHandler: @escaping (CachedURLResponse?) -> Void)
//    {
//
//    }
}

extension Server: URLSessionDownloadDelegate {

    open func urlSession(_ session: URLSession,
                         downloadTask: URLSessionDownloadTask,
                         didFinishDownloadingTo location: URL)
    {
        guard let task = self.responseTasks.filter({ $0.task === downloadTask }).first else {
            return
        }

        task.result = Response.Result(urlResponse: downloadTask.response, location: location)
        task.result?.location = location
        task.complete()
    }

    open func urlSession(_ session: URLSession,
                         downloadTask: URLSessionDownloadTask,
                         didWriteData bytesWritten: Int64,
                         totalBytesWritten: Int64,
                         totalBytesExpectedToWrite: Int64)
    {

        guard let task = self.responseTasks.filter({ $0.task === downloadTask }).first else {
            return
        }
        //@todo: check NSURLSessionTransferSizeUnknown
#if os(iOS) || os(tvOS) || os(watchOS) || os(macOS)
        task.progress = Progress(totalUnitCount: totalBytesExpectedToWrite)
        task.progress?.completedUnitCount = totalBytesWritten
        task.progressHandler?(task.progress!)
#endif

    }

//    open func urlSession(_ session: URLSession,
//                         downloadTask: URLSessionDownloadTask,
//                         didResumeAtOffset fileOffset: Int64,
//                         expectedTotalBytes: Int64)
//    {
//
//    }
}


//#if os(iOS) || os(tvOS) || os(macOS)
//
//extension Server: URLSessionStreamDelegate {
//    open func urlSession(_ session: URLSession, readClosedFor streamTask: URLSessionStreamTask) {
//
//    }
//
//    open func urlSession(_ session: URLSession, writeClosedFor streamTask: URLSessionStreamTask) {
//
//    }
//
//    open func urlSession(_ session: URLSession, betterRouteDiscoveredFor streamTask: URLSessionStreamTask) {
//
//    }
//
//    open func urlSession(_ session: URLSession,
//                        streamTask: URLSessionStreamTask,
//             didBecome inputStream: InputStream,
//                      outputStream: OutputStream)
//    {
//
//    }
//}
//
//#endif

