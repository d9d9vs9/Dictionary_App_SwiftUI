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
    case updateWord(atModel: UpdateWordModel)
    case deleteWord(atModel: DeleteWordModel)
    
    var path: String {
        switch self {
        case .addWord:
            return "addWord"
        case .getWords:
            return "words"
        case .updateWord:
            return "updateWord"
        case .deleteWord:
            return "deleteWord"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .addWord:
            return .post
        case .getWords:
            return .get
        case .updateWord:
            return .put
        case .deleteWord:
            return .delete
        }
    }
    
    var httpHeaders: HTTPHeader {
        switch self {
        case .addWord:
            return Constants.HTTPHeaderConstants.defaultHeaders()
        case .getWords:
            return Constants.HTTPHeaderConstants.defaultHeaders()
        case .updateWord:
            return Constants.HTTPHeaderConstants.defaultHeaders()
        case .deleteWord:
            return Constants.HTTPHeaderConstants.defaultHeaders()
        }
    }
    
    var httpParameters: HTTPParameters? {
        switch self {
        case .addWord(let model):
            return model.data
        case .getWords:
            return nil
        case .updateWord(let model):
            return model.data
        case .deleteWord(let model):
            return model.data
        }
    }
    
    var requestType: RequestType {
        switch self {
        case .addWord:
            return .data
        case .getWords:
            return .data
        case .updateWord:
            return .data
        case .deleteWord:
            return .data
        }
    }
    
    var responseType: ResponseType {
        switch self {
        case .addWord:
            return .data
        case .getWords:
            return .data
        case .updateWord:
            return .data
        case .deleteWord:
            return .data
        }
    }
    
}
