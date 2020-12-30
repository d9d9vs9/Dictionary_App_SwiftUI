//
//  Endpoint.swift
//  MyDictionary
//
//  Created by Дмитрий Чумаков on 29.12.2020.
//

import Foundation

protocol Endpoint {
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var httpHeaders: HTTPHeader { get }
    var httpParameters: HTTPParameters? { get }
    var requestType: RequestType { get }    
    var responseType: ResponseType { get }
}
