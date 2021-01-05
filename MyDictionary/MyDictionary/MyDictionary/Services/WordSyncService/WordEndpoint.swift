//
//  WordEndpoint.swift
//  MyDictionary
//
//  Created by Дмитрий Чумаков on 04.01.2021.
//

import Foundation

enum WordEndpoint: Endpoint {
    
    case addWord(_ word: WordModel)
    case getWords
    
    var path: String {
        switch self {
        case .addWord:
            return "addWord"
        case .getWords:
            return "words"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .addWord:
            return .post
        case .getWords:
            return .get
        }
    }
    
    var httpHeaders: HTTPHeader {
        switch self {
        case .addWord:
            return Constants.HTTPHeaderConstants.defaultHeaders()
        case .getWords:
            return Constants.HTTPHeaderConstants.defaultHeaders()
        }
    }
    
    var httpParameters: HTTPParameters? {
        switch self {
        case .addWord(let model):
            return model.data
        case .getWords:
            return nil
        }
    }
    
    var requestType: RequestType {
        switch self {
        case .addWord:
            return .data
        case .getWords:
            return .data
        }
    }
    
    var responseType: ResponseType {
        switch self {
        case .addWord:
            return .data
        case .getWords:
            return .data
        }
    }
    
}
