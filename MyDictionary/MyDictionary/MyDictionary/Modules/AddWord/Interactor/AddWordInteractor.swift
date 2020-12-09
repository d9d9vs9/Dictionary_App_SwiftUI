//
//  AddWordInteractor.swift
//  MyDictionary
//
//  Created by Дмитрий Чумаков on 03.12.2020.
//

import Foundation

protocol AddWordInteractor: AddWordProtocol {
    var dataModel: AddWordDataModel { get }
}

final class MYAddWordInteractor: AddWordInteractor {
    
    fileprivate let coreDataStack: CoreDataStack
    fileprivate let wordManager: WordManager
    fileprivate let wordValidationService: WordValidationService
    
    let dataModel: AddWordDataModel
    
    init(dataModel: AddWordDataModel) {
        self.coreDataStack = CoreDataStack.init()
        self.wordManager = MYWordManager.init(managedObjectContext: coreDataStack.privateContext,
                                              coreDataStack: coreDataStack)
        self.wordValidationService = MYWordValidationService.init()
        self.dataModel = dataModel
    }
    
}

extension MYAddWordInteractor {
    
    func add(word: WordModel, completionHandler: @escaping ResultSavedWord) {
        switch wordValidationService.isValid(word: word.word,
                                             translatedWord: word.translatedWord) {
        case .success:
            wordManager.add(word: word) { [unowned self] (result) in
                switch result {
                case .success:
                    self.postDidAddWordNotification(word)
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

// MARK: - Post Did Add Word Notification
fileprivate extension MYAddWordInteractor {
    
    func postDidAddWordNotification(_ word: WordModel) {
        NotificationCenter.default.post(name: WordNSNotificationName.didAddWord, object: word)
    }
    
}
