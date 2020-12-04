//
//  AddWordPresenter.swift
//  MyDictionary
//
//  Created by Дмитрий Чумаков on 03.12.2020.
//

import Foundation

protocol AddWordPresenter: ObservableObject {
    func addToMyDictionaryButtonClicked(wordText: String, translatedText: String, completionHandler: @escaping ResultSavedWord)
}

final class MYAddWordPresenter: AddWordPresenter {
    
    fileprivate let interactor: AddWordInteractor
    fileprivate let router: AddWordRouter
    
    init(interactor: AddWordInteractor, router: AddWordRouter) {
        self.interactor = interactor
        self.router = router
    }
    
}

// MARK: - Actions
extension MYAddWordPresenter {
    
    func addToMyDictionaryButtonClicked(wordText: String, translatedText: String, completionHandler: @escaping ResultSavedWord) {
        interactor.add(word: WordModel.init(word: wordText, translatedWord: translatedText), completionHandler: completionHandler)
    }
    
}
