//
//  WordManager.swift
//  MyDictionary
//
//  Created by Дмитрий Чумаков on 03.12.2020.
//

import CoreData

protocol WordManager: CRUDWord {
    
}

final class MYWordManager: WordManager {
            
    fileprivate let managedObjectContext: NSManagedObjectContext,
                    coreDataStack: CoreDataStack,
                    wordSyncService: WordSyncService,
                    wordCoreDataService: WordCoreDataService
    
    init(managedObjectContext: NSManagedObjectContext, coreDataStack: CoreDataStack) {
        
        self.managedObjectContext = managedObjectContext
        self.coreDataStack = coreDataStack
        self.wordSyncService = MYWordSyncService()
        self.wordCoreDataService = MYWordCoreDataService(managedObjectContext: managedObjectContext,
                                                         coreDataStack: coreDataStack)
        
    }
    
}

extension MYWordManager {
    
    func add(word: WordModel, completionHandler: @escaping ResultSavedWord) {
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
    
    func update(word: WordModel, completionHandler: @escaping ResultSavedWord) {
        wordCoreDataService.update(word: word, completionHandler: completionHandler)
        wordSyncService.update(word: word, completionHandler: completionHandler)
    }
    
}

extension MYWordManager {
        
    func delete(word: WordModel, completionHandler: @escaping ResultSavedWord) {
        wordCoreDataService.delete(word: word, completionHandler: completionHandler)
        wordSyncService.delete(word: word, completionHandler: completionHandler)
    }
    
}
