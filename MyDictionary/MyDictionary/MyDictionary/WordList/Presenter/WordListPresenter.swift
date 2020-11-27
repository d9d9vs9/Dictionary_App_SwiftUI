//
//  WordListPresenter.swift
//  MyDictionary
//
//  Created by Admin on 27.11.2020.
//

import SwiftUI
import Combine

protocol WordListPresenter: ObservableObject {
    
}

final class MYWordListPresenter: WordListPresenter {

    @Published var words: [WordModel] = []
    
    fileprivate let interactor: WordListInteractor
    fileprivate let router: WordListRouter
    fileprivate var cancellables: Set<AnyCancellable> = []
    
    init(interactor: WordListInteractor, router: WordListRouter) {
        self.interactor = interactor
        self.router = router
        
        interactor.dataModel.$words
          .assign(to: \.words, on: self)
          .store(in: &cancellables)
        
    }
    
    
    
}

extension MYWordListPresenter {

    func makeAddNewButton() -> some View {
        Button(action: addNewWord) {
            Image(systemName: "plus")
        }
    }
        
}

fileprivate extension MYWordListPresenter {
    
    func addNewWord() {
        debugPrint(#function)
    }
    
}
