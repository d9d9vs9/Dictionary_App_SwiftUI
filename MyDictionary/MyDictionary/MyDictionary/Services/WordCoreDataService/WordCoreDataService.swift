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

final class MYWordCoreDataService: NSObject, WordCoreDataService {
    
    fileprivate let managedObjectContext: NSManagedObjectContext
    fileprivate let coreDataStack: CoreDataStack
    
    init(managedObjectContext: NSManagedObjectContext, coreDataStack: CoreDataStack) {
        self.managedObjectContext = managedObjectContext
        self.coreDataStack = coreDataStack
    }
    
}

extension MYWordCoreDataService {
    
    func add(word: WordModel, completionHandler: @escaping ResultSavedWord) {
        let newWord = Word.init(id: word.id,
                                word: word.word,
                                translatedWord: word.translatedWord,
                                insertIntoManagedObjectContext: managedObjectContext)
        
        self.save(word: newWord, completionHandler: completionHandler)
    }
    
}

extension MYWordCoreDataService {
    
    func fetchWords(completionHandler: @escaping FetchResultWords){
        
        let fetchRequest = NSFetchRequest<Word>(entityName: CoreDataEntityName.word)
        let asynchronousFetchRequest = NSAsynchronousFetchRequest(fetchRequest: fetchRequest) { [unowned self] asynchronousFetchResult in
                        
            guard let result = asynchronousFetchResult.finalResult else { completionHandler(.failure(CustomCoreDataError.finalResultIsNil)) ; return }
            
            DispatchQueue.main.async {
                completionHandler(.success(result.map({ $0.wordModel })))
            }
            
        }
                
        do {
            try managedObjectContext.execute(asynchronousFetchRequest)
        } catch let error {
            completionHandler(.failure(error))
        }
        
    }
    
    func fetchWord(byID id: String, completionHandler: @escaping ResultSavedWord) {
        let fetchRequest = NSFetchRequest<Word>(entityName: CoreDataEntityName.word)
        fetchRequest.predicate = NSPredicate(format: "\(WordAttributeName.id) == %@", id)
        let asynchronousFetchRequest = NSAsynchronousFetchRequest(fetchRequest: fetchRequest) { [unowned self] asynchronousFetchResult in
                        
            guard let result = asynchronousFetchResult.finalResult else { completionHandler(.failure(CustomCoreDataError.finalResultIsNil)) ; return }
            guard let word = result.map({ $0.wordModel }).first else { completionHandler(.failure(CustomCoreDataError.finalResultIsNil)) ; return }
            DispatchQueue.main.async {
                completionHandler(.success(word))
            }
            
        }
                
        do {
            try managedObjectContext.execute(asynchronousFetchRequest)
        } catch let error {
            completionHandler(.failure(error))
        }
    }
    
}

extension MYWordCoreDataService {
    
    func update(word: WordModel, completionHandler: @escaping ResultSavedWord) {
        
    }
    
}

extension MYWordCoreDataService {
    
    func delete(byID id: String, completionHandler: @escaping ResultDeletedWord) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: CoreDataEntityName.word)
        fetchRequest.predicate = NSPredicate(format: "\(WordAttributeName.id) == %@", id)
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            try managedObjectContext.execute(batchDeleteRequest)
            completionHandler(.success)
        } catch let error {
            completionHandler(.failure(error))
        }
    }
    
}

// MARK: - Save
fileprivate extension MYWordCoreDataService {
    
    func save(word: Word, completionHandler: @escaping ResultSavedWord) {
        coreDataStack.saveContext(managedObjectContext) { [unowned self] (result) in
            switch result {
            case .success:
                self.fetchWord(byID: word.id) { [unowned self] (result) in
                    switch result {
                    case .success(let wordModel):
                        completionHandler(.success(wordModel))
                    case .failure(let error):
                        completionHandler(.failure(error))
                    }
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
}
