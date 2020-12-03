//
//  WordManager.swift
//  MyDictionary
//
//  Created by Дмитрий Чумаков on 03.12.2020.
//

import Foundation

protocol WordManager: CRUDWord {
    
}

final class MYWordManager: WordManager {
    
    fileprivate let wordSyncService: WordSyncService,
                    wordCoreDataService: WordCoreDataService
    
    init(wordSyncService: WordSyncService = MYWordSyncService(),
         wordCoreDataService: WordCoreDataService = MYWordCoreDataService()) {
        
        self.wordSyncService = wordSyncService
        self.wordCoreDataService = wordCoreDataService
        
    }
    
}

extension MYWordManager {
    
    func add(word: WordModel, completionHandler: WordStoredResult) {
        wordCoreDataService.add(word: word, completionHandler: completionHandler)
        wordSyncService.add(word: word, completionHandler: completionHandler)
    }
    
}

extension MYWordManager {
    
    func fetchWords() -> [WordModel] {
        return wordCoreDataService.fetchWords()
    }
    
}

extension MYWordManager {
    
    func update(word: WordModel, completionHandler: WordStoredResult) {
        wordCoreDataService.update(word: word, completionHandler: completionHandler)
        wordSyncService.update(word: word, completionHandler: completionHandler)
    }
    
}

extension MYWordManager {
        
    func delete(word: WordModel, completionHandler: WordStoredResult) {
        wordCoreDataService.delete(word: word, completionHandler: completionHandler)
        wordSyncService.delete(word: word, completionHandler: completionHandler)
    }
    
}
