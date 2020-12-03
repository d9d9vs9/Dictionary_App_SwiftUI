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
    
    fileprivate let wordManager: WordManager
    
    let dataModel: AddWordDataModel
    
    init(dataModel: AddWordDataModel) {
        self.wordManager = MYWordManager.init()
        self.dataModel = dataModel
    }
    
}

extension MYAddWordInteractor {
    
    func add(word: WordModel, completionHandler: WordStoredResult) {
        if (isValid(wordModel: word)) {
            wordManager.add(word: word, completionHandler: completionHandler)
        } else {
            completionHandler(WordValidation.wordInvalid)
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
