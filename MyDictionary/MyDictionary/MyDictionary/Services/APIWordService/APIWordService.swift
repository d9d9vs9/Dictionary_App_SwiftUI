//
//  APIWordService.swift
//  MyDictionary
//
//  Created by Дмитрий Чумаков on 08.01.2021.
//

import Foundation

protocol APIWordService: CRUDWord {
    
}

final class MYAPIWordService: APIWordService {
    
    fileprivate let requestDispatcher: APIRequestDispatcherService
    
    convenience init() {
        self.init(apiRequestDispatcher: APIRequestDispatcherService.init(environment: APIEnvironment.development,
                                                                         networkSession: APINetworkSessionService()))
    }
    
    init(apiRequestDispatcher: APIRequestDispatcherService) {
        self.requestDispatcher = apiRequestDispatcher
    }
    
}
extension MYAPIWordService {
    
    func add(word: WordModel, completionHandler: @escaping ResultSavedWord) {
        APIOperation.init(WordEndpoint.addWord(word))
            .execute(in: requestDispatcher) { (response) in
                switch response {
                case .data:
                    completionHandler(.success(word))
                    break
                case .error(let error, _):
                    completionHandler(.failure(error))
                    break
                }
            }
    }
    
}

extension MYAPIWordService {
    
    func fetchWords(fetchLimit: Int, fetchOffset: Int, completionHandler: @escaping FetchResultWords) {
        APIOperation.init(WordEndpoint.getWords)
            .execute(in: requestDispatcher) { (response) in
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

extension MYAPIWordService {
    
    func update(word: WordModel, completionHandler: @escaping ResultSavedWord) {
        APIOperation.init(WordEndpoint.updateWord(atModel: .init(uuid: word.uuid,
                                                                 word: word.word,
                                                                 translatedWord: word.translatedWord)))
            .execute(in: requestDispatcher) { (response) in
                switch response {
                case .data:
                    completionHandler(.success(word))
                    break
                case .error(let error, _):
                    completionHandler(.failure(error))
                    break
                }
            }
    }
    
}

extension MYAPIWordService {
    
    func delete(byUUID uuid: String, completionHandler: @escaping ResultDeletedWord) {
        APIOperation.init(WordEndpoint.deleteWord(atModel: .init(uuid: uuid)))
            .execute(in: requestDispatcher) { (response) in
                switch response {
                case .data:
                    completionHandler(.success)
                    break
                case .error(let error, _):
                    completionHandler(.failure(error))
                    break
                }
            }
    }
    
}
