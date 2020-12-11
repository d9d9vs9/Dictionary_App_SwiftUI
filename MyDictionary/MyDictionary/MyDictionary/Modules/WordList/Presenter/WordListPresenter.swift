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
    func searchTextDidChange(_ string: String)
    func searchBarCancelButtonClicked()
    func onAppearCell(word: WordModel)
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

// MARK: - Link Builder
extension MYWordListPresenter {
    
    func linkBuilder<Content: View>(for word: WordModel, @ViewBuilder content: () -> Content) -> some View {
        NavigationLink(destination: router.makeWordDetailView(for: word)) {
            content()
        }
    }
    
}

// MARK: - Move Words
extension MYWordListPresenter {
    
    func move(from source: IndexSet, to destination: Int) {
        words.move(fromOffsets: source, toOffset: destination)
    }
    
}

// MARK: - Delete Words
extension MYWordListPresenter {
    
    func delete(from source: IndexSet) {
        interactor.delete(from: source)
    }
    
}

// MARK: - Search Text Did Change
extension MYWordListPresenter {
    
    func searchTextDidChange(_ string: String) {
        interactor.searchTextDidChange(string)
    }
    
}

// MARK: - Search Bar Cancel Button Clicked
extension MYWordListPresenter {
    
    func searchBarCancelButtonClicked() {
        interactor.searchBarCancelButtonClicked()
    }
    
}

// MARK: - On Appear Cell
extension MYWordListPresenter {
    
    func onAppearCell(word: WordModel) {
        interactor.onAppearCell(word: word)
    }
    
}
