//
//  WordSyncService.swift
//  MyDictionary
//
//  Created by Дмитрий Чумаков on 03.12.2020.
//

import Foundation

protocol WordSyncService: CRUDWord {
    
}

final class MYWordSyncService: WordSyncService {
    
    fileprivate let requestDispatcher: APIRequestDispatcherService
    
    convenience init() {
        self.init(apiRequestDispatcher: APIRequestDispatcherService.init(environment: APIEnvironment.development,
                                                                         networkSession: APINetworkSessionService()))
    }
    
    init(apiRequestDispatcher: APIRequestDispatcherService) {
        self.requestDispatcher = apiRequestDispatcher
    }
    
}

extension MYWordSyncService {
    
    func add(word: WordModel, completionHandler: @escaping ResultSavedWord) {
        completionHandler(.success(word))
    }
    
}

extension MYWordSyncService {
    
    func fetchWords(fetchLimit: Int, fetchOffset: Int, completionHandler: @escaping FetchResultWords) {
        let endpoint = WordEndpoint.getWords
        let apiOperation: APIOperation = APIOperation.init(endpoint)
        apiOperation.execute(in: requestDispatcher) { (response) in
            switch response {
            case .data(let data, _):                
                do {
                    completionHandler(.success(try JSONDecoder.init().decode([WordModel].self, from: data)))
                } catch {
                    completionHandler(.failure(APIError.parseError(error.localizedDescription)))
                }
                break
            case .error(let error, _):
                completionHandler(.failure(error))
                break
            }
        }
    }
    
    func fetchWord(byUUID uuid: String, completionHandler: @escaping ResultSavedWord) {
        
    }
    
    func fetchWordsCount(completionHandler: @escaping (FetchResultWordsCount)) {
        
    }
    
}

extension MYWordSyncService {
    
    func update(word: WordModel, completionHandler: @escaping ResultSavedWord) {
        completionHandler(.success(word))
    }
    
}

extension MYWordSyncService {
        
    func delete(byUUID uuid: String, completionHandler: @escaping ResultDeletedWord) {
        completionHandler(.success)
    }
    
}
