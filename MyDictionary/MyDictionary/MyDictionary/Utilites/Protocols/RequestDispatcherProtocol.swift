//
//  RequestDispatcherProtocol.swift
//  MyDictionary
//
//  Created by Дмитрий Чумаков on 30.12.2020.
//

import Foundation

protocol RequestDispatcherProtocol {
    init(environment: EnvironmentProtocol, networkSession: NetworkSessionProtocol)
    func execute(endpoint: Endpoint, completion: @escaping (ResponseOperationResult) -> Void) -> URLSessionTask?
}
