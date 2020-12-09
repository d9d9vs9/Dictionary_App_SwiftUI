//
//  WordDetailPresenter.swift
//  MyDictionary
//
//  Created by Admin on 27.11.2020.
//

import Foundation

protocol WordDetailPresenter: ObservableObject {
    var wordModel: WordModel { get }
    func doneButtonClicked(wordText: String, translatedWord: String, completionHandler: @escaping ResultSavedWord)
}

final class MYWordDetailPresenter: WordDetailPresenter {
    
    fileprivate let interactor: WordDetailInteractor
    fileprivate let router: WordDetailRouter
    
    var wordModel: WordModel
    
    init(interactor: WordDetailInteractor, router: WordDetailRouter) {
        self.interactor = interactor
        self.router = router
        
        self.wordModel = interactor.dataModel.wordModel
        
    }
    
}

extension MYWordDetailPresenter {
    
    func doneButtonClicked(wordText: String, translatedWord: String, completionHandler: @escaping ResultSavedWord) {
        interactor.updateWord(wordText: wordText, translatedWord: translatedWord, completionHandler: completionHandler)
    }
    
}
