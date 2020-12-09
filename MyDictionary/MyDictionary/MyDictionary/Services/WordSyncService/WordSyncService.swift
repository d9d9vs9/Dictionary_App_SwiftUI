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
    
}

extension MYWordSyncService {
    
    func add(word: WordModel, completionHandler: @escaping ResultSavedWord) {
        completionHandler(.success(word))
    }
    
}

extension MYWordSyncService {
    
    func fetchWords(fetchLimit: Int, fetchOffset: Int, completionHandler: @escaping FetchResultWords) {
        completionHandler(.success([]))
    }
    
    func fetchWord(byUUID uuid: String, completionHandler: @escaping ResultSavedWord) {
        
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
