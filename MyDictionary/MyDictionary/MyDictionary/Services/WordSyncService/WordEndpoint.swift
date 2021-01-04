//
//  WordEndpoint.swift
//  MyDictionary
//
//  Created by Дмитрий Чумаков on 04.01.2021.
//

import Foundation

enum WordEndpoint: Endpoint {
    
    case getWords
    
    var path: String {
        switch self {
        case .getWords:
            return "words"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .getWords:
            return .get
        }
    }
    
    var httpHeaders: HTTPHeader {
        switch self {
        case .getWords:
            return Constants.HTTPHeaderConstants.defaultHeaders()
        }
    }
    
    var httpParameters: HTTPParameters? {
        switch self {
        case .getWords:
            return nil
        }
    }
    
    var requestType: RequestType  {
        switch self {
        case .getWords:
            return .data
        }
    }
    
    var responseType: ResponseType  {
        switch self {
        case .getWords:
            return .data
        }
    }
    
}
