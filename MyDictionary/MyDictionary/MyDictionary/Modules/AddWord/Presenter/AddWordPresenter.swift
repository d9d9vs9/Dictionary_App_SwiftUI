//
//  AddWordPresenter.swift
//  MyDictionary
//
//  Created by Дмитрий Чумаков on 03.12.2020.
//

import Foundation

protocol AddWordPresenter: ObservableObject {
    var wordText: String { get }
}

final class MYAddWordPresenter: AddWordPresenter {
    
    fileprivate let interactor: AddWordInteractor
    fileprivate let router: AddWordRouter
    
    /// Default is Constants.StaticText.emptyString
    var wordText: String
    
    init(interactor: AddWordInteractor, router: AddWordRouter) {
        self.interactor = interactor
        self.router = router        
        self.wordText = Constants.StaticText.emptyString
    }
    
}
