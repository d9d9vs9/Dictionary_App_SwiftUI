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
    
    let dataModel: AddWordDataModel
    
    init(dataModel: AddWordDataModel) {
        self.coreDataStack = CoreDataStack.init()
        self.wordManager = MYWordManager.init(managedObjectContext: coreDataStack.privateContext,
                                              coreDataStack: coreDataStack)
        self.dataModel = dataModel
    }
    
}

extension MYAddWordInteractor {
    
    func add(word: WordModel, completionHandler: @escaping ResultSavedWord) {
        if (isValid(wordModel: word)) {
            wordManager.add(word: word) { [unowned self] (result) in
                switch result {
                case .success:
                    postDidAddWordNotification()
                case .failure:
                    break
                }
                completionHandler(result)
            }
        } else {
            completionHandler(.failure(WordValidation.wordInvalid))
            return
        }
    }
    
}

fileprivate extension MYAddWordInteractor {
    
    func isValid(wordModel: WordModel) -> Bool {
        let characterSet = NSCharacterSet.letters
                
        let wordRange = wordModel.word.rangeOfCharacter(from: characterSet)
        let translatedWordRange = wordModel.translatedWord.rangeOfCharacter(from: characterSet)
                
        return (wordRange != nil && translatedWordRange != nil)
    }
    
}

fileprivate extension MYAddWordInteractor {
    
    enum WordValidation: Error {
        case wordInvalid
        case translatedWordInvalid
    }
    
}

fileprivate extension MYAddWordInteractor {
    
    func postDidAddWordNotification() {
        NotificationCenter.default.post(name: WordNSNotificationName.didAddWord, object: nil)
    }
    
}
