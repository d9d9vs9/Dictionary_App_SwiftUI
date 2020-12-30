//
//  APIEnvironment.swift
//  MyDictionary
//
//  Created by Дмитрий Чумаков on 30.12.2020.
//

import Foundation

enum APIEnvironment: EnvironmentProtocol {
    
    case development
    
    var httpHeaders: HTTPHeader? {
        switch self {
        case .development:
            return nil
        }
    }
    
    var baseURL: String {
        switch self {
        case .development:
            return ""
        }
    }
    
}
