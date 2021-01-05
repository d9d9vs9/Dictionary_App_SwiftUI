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
    
    fileprivate let wordManager: WordManager
    fileprivate let coreDataStack: CoreDataStack
    fileprivate let wordValidationService: WordValidationService
    let dataModel: WordDetailDataModel
    
    init(dataModel: WordDetailDataModel) {
        self.dataModel = dataModel
        let coreDataStack = CoreDataStack.init()
        self.coreDataStack = coreDataStack
        self.wordManager = MYWordManager.init(managedObjectContext: coreDataStack.privateContext,
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
            wordManager.update(word: WordModel.init(uuid: dataModel.wordModel.uuid,
                                                            word: wordText,
                                                            translatedWord: translatedWord,
                                                            stringCreatedDate: dataModel.wordModel.stringCreatedDate)) { [unowned self] (result) in
                switch result {
                case .success(let model):
                    // Post Updated Word Notification
                    self.postDidUpdateWordNotification(model)
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
    
    func postDidUpdateWordNotification(_ word: WordModel) {
        NotificationCenter.default.post(name: WordNSNotificationName.didUpdateWord, object: word)
    }
    
}
