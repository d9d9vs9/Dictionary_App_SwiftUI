//
//  APINetworkSessionService.swift
//  MyDictionary
//
//  Created by Дмитрий Чумаков on 30.12.2020.
//

import Foundation

final class APINetworkSessionService: NSObject {
    
    fileprivate typealias CompletionHandler = (((URL?, URLResponse?, Error?) -> Void)?)
    /// The URLSession handing the URLSessionTaks.
    fileprivate var session: URLSession!
    fileprivate var taskToHandlersMap: [URLSessionTask : CompletionHandler] = [:]
    
    deinit {
        // We have to invalidate the session becasue URLSession strongly retains its delegate. https://developer.apple.com/documentation/foundation/urlsession/1411538-invalidateandcancel
        session.invalidateAndCancel()
        session = nil
        taskToHandlersMap = [:]
    }
        
    public override convenience init() {
        // Configure the default URLSessionConfiguration.
        let sessionConfiguration = URLSessionConfiguration.default
        sessionConfiguration.timeoutIntervalForResource = 30
        sessionConfiguration.waitsForConnectivity = true        
        
        // Create a `OperationQueue` instance for scheduling the delegate calls and completion handlers.
        let queue = OperationQueue()
        queue.maxConcurrentOperationCount = 3
        queue.qualityOfService = .userInitiated
        
        // Call the designated initializer
        self.init(configuration: sessionConfiguration, delegateQueue: queue)
    }
        
    public init(configuration: URLSessionConfiguration, delegateQueue: OperationQueue) {
        super.init()
        self.session = URLSession.init(configuration: configuration, delegate: self, delegateQueue: delegateQueue)
    }
            
    fileprivate func set(handlers: CompletionHandler?, for task: URLSessionTask) {
        taskToHandlersMap[task] = handlers
    }
        
    fileprivate func getHandlers(for task: URLSessionTask) -> CompletionHandler? {
        return taskToHandlersMap[task]
    }
    
}

// MARK: - URLSessionDelegate
extension APINetworkSessionService: URLSessionDelegate {
    
}
