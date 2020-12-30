//
//  OperationProtocol.swift
//  MyDictionary
//
//  Created by Дмитрий Чумаков on 30.12.2020.
//

import Foundation

protocol OperationProtocol {
    associatedtype Output
    var endpoint: Endpoint { get }
    func execute(in requestDispatcher: RequestDispatcherProtocol, completion: @escaping (Output) -> Void) ->  Void
    func cancel() -> Void
}
