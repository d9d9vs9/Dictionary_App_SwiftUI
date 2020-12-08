//
//  WordDetailInteractor.swift
//  MyDictionary
//
//  Created by Admin on 27.11.2020.
//

import Foundation

protocol WordDetailInteractor {
    var dataModel: WordDetailDataModel { get }
    func onDisappear(wordText: String, translatedWord: String)
}

final class MYWordDetailInteractor: WordDetailInteractor {
    
    fileprivate let wordCoreDataService: WordCoreDataService
    fileprivate let coreDataStack: CoreDataStack
    let dataModel: WordDetailDataModel
    
    init(dataModel: WordDetailDataModel) {
        self.dataModel = dataModel
        let coreDataStack = CoreDataStack.init()
        self.coreDataStack = coreDataStack
        self.wordCoreDataService = MYWordCoreDataService.init(managedObjectContext: coreDataStack.privateContext,
                                                              coreDataStack: coreDataStack)
    }
    
}

extension MYWordDetailInteractor {
    
    func onDisappear(wordText: String, translatedWord: String) {
        wordCoreDataService.update(word: WordModel.init(uuid: dataModel.wordModel.uuid,
                                                        word: wordText,
                                                        translatedWord: translatedWord)) { [weak self] (result) in
            switch result {
            case .success:
                self?.postDidUpdateWordNotification()
                break
            case .failure:
                break
            }
        }
    }
    
}

// MARK - Post Did Update Word Notification
fileprivate extension MYWordDetailInteractor {
    
    func postDidUpdateWordNotification() {
        NotificationCenter.default.post(name: WordNSNotificationName.didUpdateWord, object: nil)
    }
    
}
