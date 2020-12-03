//
//  WordListPresenter.swift
//  MyDictionary
//
//  Created by Admin on 27.11.2020.
//

import SwiftUI
import Combine

protocol WordListPresenter: ObservableObject {
    var words: [WordModel] { get }
}

final class MYWordListPresenter: WordListPresenter {
        
    fileprivate let interactor: WordListInteractor
    fileprivate var cancellables: Set<AnyCancellable> = []
    let router: WordListRouter
    
    @Published var words: [WordModel] = []    
    
    init(interactor: WordListInteractor, router: WordListRouter) {
        self.interactor = interactor
        self.router = router
        
        interactor.dataModel.$words
            .assign(to: \.words, on: self)
            .store(in: &cancellables)
        
    }
    
}

extension MYWordListPresenter {
    
    func linkBuilder<Content: View>(for word: WordModel, @ViewBuilder content: () -> Content) -> some View {
        NavigationLink(destination: router.makeWordDetailView(for: word)) {
            content()
        }
    }
    
}
