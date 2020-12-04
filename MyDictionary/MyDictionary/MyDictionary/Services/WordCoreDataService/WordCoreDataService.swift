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
    
    fileprivate let managedObjectContext: NSManagedObjectContext
    fileprivate let coreDataStack: CoreDataStack
    
    init(managedObjectContext: NSManagedObjectContext, coreDataStack: CoreDataStack) {
        self.managedObjectContext = managedObjectContext
        self.coreDataStack = coreDataStack
    }
    
}

extension MYWordCoreDataService {
    
    func add(word: WordModel, completionHandler: @escaping ResultSavedWord) {
        let newWord = Word.init(context: managedObjectContext)
        newWord.word = word.word
        newWord.translatedWord = word.translatedWord
        self.save(word: newWord, completionHandler: completionHandler)
    }
    
}

extension MYWordCoreDataService {
    
    func fetchWords() -> [WordModel] {
        let fetchRequest = NSFetchRequest<Word>(entityName: CoreDataEntityName.word)
        do {
            return try managedObjectContext.fetch(fetchRequest).map({ $0.wordModel })
        } catch {
            return []
        }
    }
    
}

extension MYWordCoreDataService {
    
    func update(word: WordModel, completionHandler: @escaping ResultSavedWord) {
        
    }
    
}

extension MYWordCoreDataService {
    
    func delete(word: WordModel, completionHandler: @escaping ResultSavedWord) {
        
    }
    
}

// MARK: - Save
fileprivate extension MYWordCoreDataService {
    
    func save(word: Word, completionHandler: @escaping ResultSavedWord) {
        coreDataStack.saveContext(managedObjectContext) { (result) in
            switch result {
            case .success:
                completionHandler(.success(word.wordModel))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
}
