//
//  APIOperation.swift
//  MyDictionary
//
//  Created by Дмитрий Чумаков on 30.12.2020.
//

import Foundation

final class APIOperation: OperationProtocol {
    
    typealias Output = ResponseOperationResult
    
    fileprivate var task: URLSessionTask?
    internal var endpoint: Endpoint
    
    init(_ endpoint: Endpoint) {
        self.endpoint = endpoint
    }
    
    func cancel() {
        task?.cancel()
    }

    func execute(in requestDispatcher: RequestDispatcherProtocol, completion: @escaping (ResponseOperationResult) -> Void) {
        task = requestDispatcher.execute(endpoint: endpoint, completion: { result in
            completion(result)
        })
    }
    
}
