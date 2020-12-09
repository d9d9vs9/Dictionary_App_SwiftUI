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
        let newWord = Word.init(uuid: word.uuid,
                                word: word.word,
                                translatedWord: word.translatedWord,
                                stringCreatedDate: word.stringCreatedDate,
                                insertIntoManagedObjectContext: managedObjectContext)
        
        self.save(word: newWord, completionHandler: completionHandler)
    }
    
}

extension MYWordCoreDataService {
    
    func fetchWords(fetchLimit: Int, fetchOffset: Int, completionHandler: @escaping FetchResultWords){
        
        let fetchRequest = NSFetchRequest<Word>(entityName: CoreDataEntityName.word)
        fetchRequest.fetchLimit = fetchLimit
        fetchRequest.fetchOffset = fetchOffset
        let asynchronousFetchRequest = NSAsynchronousFetchRequest(fetchRequest: fetchRequest) { [unowned self] asynchronousFetchResult in
            
            if let result = asynchronousFetchResult.finalResult {
                DispatchQueue.main.async {
                    completionHandler(.success(result.map({ $0.wordModel })))
                }
            }
            
        }
        
        do {
            try managedObjectContext.execute(asynchronousFetchRequest)
        } catch let error {
            completionHandler(.failure(error))
        }
        
    }
    
    func fetchWord(byUUID uuid: String, completionHandler: @escaping ResultSavedWord) {
        let fetchRequest = NSFetchRequest<Word>(entityName: CoreDataEntityName.word)
        fetchRequest.predicate = NSPredicate(format: "\(WordAttributeName.uuid) == %@", uuid)
        let asynchronousFetchRequest = NSAsynchronousFetchRequest(fetchRequest: fetchRequest) { [unowned self] asynchronousFetchResult in
            
            if let result = asynchronousFetchResult.finalResult {
                if let word = result.map({ $0.wordModel }).first {
                    DispatchQueue.main.async {
                        completionHandler(.success(word))
                    }
                }
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
        let batchUpdateRequest = NSBatchUpdateRequest(entityName: CoreDataEntityName.word)
        batchUpdateRequest.propertiesToUpdate = [WordAttributeName.word : word.word,
                                                 WordAttributeName.translatedWord : word.translatedWord
        ]
        batchUpdateRequest.predicate = NSPredicate(format: "\(WordAttributeName.uuid) == %@", word.uuid)
        
        do {
            try managedObjectContext.execute(batchUpdateRequest)
            savePerform(word: word.word(insertIntoManagedObjectContext: managedObjectContext)) { [unowned self] (result) in
                DispatchQueue.main.async {
                    completionHandler(result)
                }
            }
        } catch let error {
            DispatchQueue.main.async {
                completionHandler(.failure(error))
            }
        }
        
    }
    
}

extension MYWordCoreDataService {
    
    func delete(byUUID uuid: String, completionHandler: @escaping ResultDeletedWord) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: CoreDataEntityName.word)
        fetchRequest.predicate = NSPredicate(format: "\(WordAttributeName.uuid) == %@", uuid)
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            try managedObjectContext.execute(batchDeleteRequest)
            self.savePerform { [unowned self] (result) in
                DispatchQueue.main.async {
                    completionHandler(result)
                }
            }
        } catch let error {
            completionHandler(.failure(error))
        }
    }
    
}

// MARK: - Save
fileprivate extension MYWordCoreDataService {
    
    func savePerform(completionHandler: @escaping ResultSaved) {
        coreDataStack.savePerform(completionHandler: completionHandler)
    }
    
    func savePerform(word: Word, completionHandler: @escaping ResultSavedWord) {
        coreDataStack.savePerform() { [unowned self] (result) in
            switch result {
            case .success:
                self.fetchWord(byUUID: word.uuid) { [unowned self] (result) in
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
    
    func save(word: Word, completionHandler: @escaping ResultSavedWord) {
        coreDataStack.savePerformAndWait() { [unowned self] (result) in
            switch result {
            case .success:
                self.fetchWord(byUUID: word.uuid) { [unowned self] (result) in
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
