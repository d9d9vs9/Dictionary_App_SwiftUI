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
    
    func add(word: WordModel, completionHandler: WordStoredResult) {
        completionHandler()
    }
    
}

extension MYWordSyncService {
    
    func fetchWords() -> [WordModel] {
        return []
    }
    
}

extension MYWordSyncService {
    
    func update(word: WordModel, completionHandler: WordStoredResult) {
        completionHandler()
    }
    
}

extension MYWordSyncService {
    
    
    func delete(word: WordModel, completionHandler: WordStoredResult) {
        completionHandler()
    }
    
}
