//
//  WordDetailPresenter.swift
//  MyDictionary
//
//  Created by Admin on 27.11.2020.
//

import Foundation

protocol WordDetailPresenter: ObservableObject {
    var wordModel: WordModel { get }
    func onDisappear(wordText: String, translatedWord: String)
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
    
    func onDisappear(wordText: String, translatedWord: String) {
        interactor.onDisappear(wordText: wordText, translatedWord: translatedWord)
    }
    
}
