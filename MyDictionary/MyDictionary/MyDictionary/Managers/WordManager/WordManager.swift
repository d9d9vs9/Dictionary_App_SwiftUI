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
                    apiWordService: APIWordService,
                    wordSyncService: WordSyncService,
                    wordCoreDataService: WordCoreDataService
    
    init(managedObjectContext: NSManagedObjectContext, coreDataStack: CoreDataStack) {
        
        self.managedObjectContext = managedObjectContext
        self.coreDataStack = coreDataStack
        self.apiWordService = MYAPIWordService.init()
        self.wordSyncService = MYWordSyncService()
        self.wordCoreDataService = MYWordCoreDataService(managedObjectContext: managedObjectContext,
                                                         coreDataStack: coreDataStack)
        
    }
    
}

extension MYWordManager {
    
    func add(word: WordModel, completionHandler: @escaping ResultSavedWord) {
        wordCoreDataService.add(word: word, completionHandler: completionHandler)
        apiWordService.add(word: word, completionHandler: completionHandler)
    }
    
}

extension MYWordManager {
    
    func fetchWords(fetchLimit: Int, fetchOffset: Int, completionHandler: @escaping FetchResultWords) {
        return wordCoreDataService.fetchWords(fetchLimit: fetchLimit,
                                              fetchOffset: fetchOffset,
                                              completionHandler: completionHandler)
    }
    
    func fetchWord(byUUID uuid: String, completionHandler: @escaping ResultSavedWord) {
        wordCoreDataService.fetchWord(byUUID: uuid, completionHandler: completionHandler)
    }
    
    func fetchWordsCount(completionHandler: @escaping (FetchResultWordsCount)) {
        wordCoreDataService.fetchWordsCount(completionHandler: completionHandler)
    }
    
}

extension MYWordManager {
    
    func update(word: WordModel, completionHandler: @escaping ResultSavedWord) {
        wordCoreDataService.update(word: word, completionHandler: completionHandler)
        apiWordService.update(word: word, completionHandler: completionHandler)
    }
    
}

extension MYWordManager {
        
    func delete(byUUID uuid: String, completionHandler: @escaping ResultDeletedWord) {
        wordCoreDataService.delete(byUUID: uuid, completionHandler: completionHandler)
        apiWordService.delete(byUUID: uuid, completionHandler: completionHandler)
    }
    
}
