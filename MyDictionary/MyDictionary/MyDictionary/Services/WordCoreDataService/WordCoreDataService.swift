//
//  WordCoreDataService.swift
//  MyDictionary
//
//  Created by Дмитрий Чумаков on 03.12.2020.
//

import Foundation

protocol WordCoreDataService: CRUDWord {
    
}

final class MYWordCoreDataService: WordCoreDataService {
    
}

extension MYWordCoreDataService {
    
    func add(word: WordModel, completionHandler: WordStoredResult) {
        completionHandler()
    }
    
}

extension MYWordCoreDataService {
    
    func fetchWords() -> [WordModel] {
        return []
    }
    
}

extension MYWordCoreDataService {
    
    func update(word: WordModel, completionHandler: WordStoredResult) {
        completionHandler()
    }
    
}

extension MYWordCoreDataService {
    
    
    func delete(word: WordModel, completionHandler: WordStoredResult) {
        completionHandler()
    }
    
}
