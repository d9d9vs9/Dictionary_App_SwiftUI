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
        let newWord = Word.init(context: managedObjectContext)
        newWord.id = word.id
        newWord.word = word.word
        newWord.translatedWord = word.translatedWord
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
    
}

extension MYWordCoreDataService {
    
    func update(word: WordModel, completionHandler: @escaping ResultSavedWord) {
        
    }
    
}

extension MYWordCoreDataService {
    
    func delete(word: WordModel, completionHandler: @escaping ResultDeletedWord) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: CoreDataEntityName.word)
        fetchRequest.predicate = NSPredicate(format: "\(WordAttributeName.id) == %@", word.id)
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
