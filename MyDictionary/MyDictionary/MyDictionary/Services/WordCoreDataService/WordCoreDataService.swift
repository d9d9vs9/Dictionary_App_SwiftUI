//
//  WordCoreDataService.swift
//  MyDictionary
//
//  Created by Дмитрий Чумаков on 03.12.2020.
//

import Foundation
import CoreData

protocol WordCoreDataService: CRUDWord {
    
}

final class MYWordCoreDataService: WordCoreDataService {
    
}

extension MYWordCoreDataService {
    
    func add(word: WordModel, completionHandler: WordStoredResult) {
        let newWord = NSEntityDescription.insertNewObject(forEntityName: CoreDataEntityName.word,
                                                          into: CoreDataStack.shared.viewContext)
        newWord.setValue(word.word, forKey: WordAttributeName.word)
        newWord.setValue(word.translatedWord, forKey: WordAttributeName.translatedWord)
        do {
            try CoreDataStack.shared.saveContext()
            completionHandler(nil)
        } catch {
            completionHandler(error)
        }        
    }
    
}

extension MYWordCoreDataService {
    
    func fetchWords() -> [WordModel] {
        let fetchRequest = NSFetchRequest<Word>(entityName: CoreDataEntityName.word)
        do {
            return try CoreDataStack.shared.viewContext.fetch(fetchRequest).map({ $0.wordModel })
        } catch {
            return []
        }
    }
    
}

extension MYWordCoreDataService {
    
    func update(word: WordModel, completionHandler: WordStoredResult) {
        completionHandler(nil)
    }
    
}

extension MYWordCoreDataService {
    
    func delete(word: WordModel, completionHandler: WordStoredResult) {
        completionHandler(nil)
    }
    
}
