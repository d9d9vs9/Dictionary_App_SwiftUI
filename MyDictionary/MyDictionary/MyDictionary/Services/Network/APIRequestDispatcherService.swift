//
//  APIRequestDispatcherService.swift
//  MyDictionary
//
//  Created by Дмитрий Чумаков on 30.12.2020.
//

import Foundation

final class APIRequestDispatcherService: RequestDispatcherProtocol {
    
    /// The environment configuration.
    fileprivate var environment: EnvironmentProtocol
    /// The network session configuration.
    fileprivate var networkSession: NetworkSessionProtocol
    
    required init(environment: EnvironmentProtocol, networkSession: NetworkSessionProtocol) {
        self.environment = environment
        self.networkSession = networkSession
    }
    
    func execute(endpoint: Endpoint, completion: @escaping (ResponseOperationResult) -> Void) -> URLSessionTask? {
        // Create a URL request.
        guard var urlRequest = endpoint.urlRequest(with: environment) else {
            completion(.error(APIError.badRequest("Invalid URL for: \(endpoint)"), nil))
            return nil
        }
        // Add the environment specific headers.
        environment.httpHeaders?.forEach({ (key: String, value: String) in
            urlRequest.addValue(value, forHTTPHeaderField: key)
        })
        
        // Create a URLSessionTask to execute the URLRequest.
        var task: URLSessionTask?
        switch endpoint.requestType {
        case .data:
            task = networkSession.dataTask(with: urlRequest, completionHandler: { [weak self] (data, urlResponse, error) in
                self?.handleJsonTaskResponse(data: data, urlResponse: urlResponse, error: error, completion: completion)
            })
            break
        default:
            break
        }
        
        // Start the task.
        task?.resume()
        
        return task
    }
    
    fileprivate func handleJsonTaskResponse(data: Data?, urlResponse: URLResponse?, error: Error?, completion: @escaping (ResponseOperationResult) -> Void) {
        // Check if the response is valid.
        guard let urlResponse = urlResponse as? HTTPURLResponse else {
            completion(ResponseOperationResult.error(APIError.invalidResponse, nil))
            return
        }
        // Verify the HTTP status code.
        let result = verify(data: data, urlResponse: urlResponse, error: error)
        switch result {
        case .success(let data):
            // Parse the JSON data
            let parseResult = parse(data: data as? Data)
            switch parseResult {
            case .success(let json):
                DispatchQueue.main.async {
                    completion(ResponseOperationResult.json(json, urlResponse))
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    completion(ResponseOperationResult.error(error, urlResponse))
                }
            }
        case .failure(let error):
            DispatchQueue.main.async {
                completion(ResponseOperationResult.error(error, urlResponse))
            }
        }
    }       
    
    fileprivate func parse(data: Data?) -> Result<Any, Error> {
        guard let data = data else {
            return .failure(APIError.invalidResponse)
        }
        
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
            return .success(json)
        } catch (let exception) {
            return .failure(APIError.parseError(exception.localizedDescription))
        }
    }
    
    fileprivate func verify(data: Any?, urlResponse: HTTPURLResponse, error: Error?) -> Result<Any, Error> {
        switch urlResponse.statusCode {
        case 200...299:
            if let data = data {
                return .success(data)
            } else {
                return .failure(APIError.noData)
            }
        case 400...499:
            return .failure(APIError.badRequest(error?.localizedDescription))
        case 500...599:
            return .failure(APIError.serverError(error?.localizedDescription))
        default:
            return .failure(APIError.unknown)
        }
    }
    
}
