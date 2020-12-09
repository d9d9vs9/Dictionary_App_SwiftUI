//
//  WordDetailInteractor.swift
//  MyDictionary
//
//  Created by Admin on 27.11.2020.
//

import Foundation

protocol WordDetailInteractor {
    var dataModel: WordDetailDataModel { get }
    func updateWord(wordText: String, translatedWord: String, completionHandler: @escaping ResultSavedWord)
}

final class MYWordDetailInteractor: WordDetailInteractor {
    
    fileprivate let wordCoreDataService: WordCoreDataService
    fileprivate let coreDataStack: CoreDataStack
    fileprivate let wordValidationService: WordValidationService
    let dataModel: WordDetailDataModel
    
    init(dataModel: WordDetailDataModel) {
        self.dataModel = dataModel
        let coreDataStack = CoreDataStack.init()
        self.coreDataStack = coreDataStack
        self.wordCoreDataService = MYWordCoreDataService.init(managedObjectContext: coreDataStack.privateContext,
                                                              coreDataStack: coreDataStack)
        
        self.wordValidationService = MYWordValidationService.init()
    }
    
}

extension MYWordDetailInteractor {
    
    func updateWord(wordText: String, translatedWord: String, completionHandler: @escaping ResultSavedWord) {
        
        // Validation Word
        switch wordValidationService.isValid(word: wordText,
                                             translatedWord: translatedWord) {
        case .success:
            // Update And Save Word
            wordCoreDataService.update(word: WordModel.init(uuid: dataModel.wordModel.uuid,
                                                            word: wordText,
                                                            translatedWord: translatedWord)) { [unowned self] (result) in
                switch result {
                case .success:
                    // Post Updated Word Notification
                    self.postDidUpdateWordNotification()
                    break
                case .failure:
                    break
                }
                
                completionHandler(result)
            }
        case .failure(let error):
            completionHandler(.failure(error))
            break
        }
                
    }
    
}

// MARK: - Post Did Update Word Notification
fileprivate extension MYWordDetailInteractor {
    
    func postDidUpdateWordNotification() {
        NotificationCenter.default.post(name: WordNSNotificationName.didUpdateWord, object: nil)
    }
    
}
