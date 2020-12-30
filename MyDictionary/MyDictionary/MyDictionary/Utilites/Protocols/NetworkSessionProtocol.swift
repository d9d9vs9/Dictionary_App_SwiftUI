//
//  NetworkSessionProtocol.swift
//  MyDictionary
//
//  Created by Дмитрий Чумаков on 30.12.2020.
//

import Foundation

protocol NetworkSessionProtocol {
    /// Create  a URLSessionDataTask. The caller is responsible for calling resume().
    /// - Parameters:
    ///   - request: `URLRequest` object.
    ///   - completionHandler: The completion handler for the data task.
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask?
}
