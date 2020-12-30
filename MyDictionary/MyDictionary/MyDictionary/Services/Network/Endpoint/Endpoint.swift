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

extension Endpoint {
    
    public func urlRequest(with environment: EnvironmentProtocol) -> URLRequest? {
        
        guard let url = url(with: environment.baseURL) else {
            return nil
        }
        
        var request = URLRequest(url: url)
        
        // Append all related properties.
        request.httpMethod = httpMethod.rawValue
        request.allHTTPHeaderFields = httpHeaders
        request.httpBody = jsonBody
        
        return request
    }
    
    fileprivate func url(with baseURL: String) -> URL? {
        guard var urlComponents = URLComponents(string: baseURL) else {
            return nil
        }
        urlComponents.path = urlComponents.path + path
        urlComponents.queryItems = queryItems
        return urlComponents.url
    }
    
    /// Returns the URLRequest `URLQueryItem`
    fileprivate var queryItems: [URLQueryItem]? {
        // Chek if it is a GET method.
        guard httpMethod == .get, let parameters = httpParameters else {
            return nil
        }
        guard let dict = ((try? JSONSerialization.jsonObject(with: parameters, options: [])) as? [String: Any]) else {
            return nil
        }
        // Convert parameters to query items.
        return dict.map { (key: String, value: Any?) -> URLQueryItem in
            let valueString = String(describing: value)
            return URLQueryItem(name: key, value: valueString)
        }
    }
    
    /// Returns the URLRequest body `Data`
    fileprivate var jsonBody: Data? {
        // The body data should be used for POST, PUT and PATCH only
        guard [.post, .put].contains(httpMethod), let data = httpParameters else {
            return nil
        }
        return data
    }
    
}
