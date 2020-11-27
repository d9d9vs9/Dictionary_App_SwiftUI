//
//  WordDetailPresenter.swift
//  MyDictionary
//
//  Created by Admin on 27.11.2020.
//

import Combine

protocol WordDetailPresenter: ObservableObject {
    
}

final class MYWordDetailPresenter: WordDetailPresenter {
    
    fileprivate let interactor: WordDetailInteractor
    fileprivate let router: WordDetailRouter
    
    fileprivate var cancellables: Set<AnyCancellable> = []
    
    init(interactor: WordDetailInteractor, router: WordDetailRouter) {
        self.interactor = interactor
        self.router = router
    }
    
}
