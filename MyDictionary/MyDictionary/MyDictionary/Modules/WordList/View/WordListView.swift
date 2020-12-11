//
//  WordListView.swift
//  MyDictionary
//
//  Created by Admin on 27.11.2020.
//

import SwiftUI

struct WordListView: View {
    
    @ObservedObject fileprivate var presenter: MYWordListPresenter
    @State fileprivate var searchText: String = Constants.StaticText.emptyString
    @State fileprivate var searchBarCancelButtonAction: Bool = false
    @State fileprivate var showingAddWord: Bool = false
    
    init(presenter: MYWordListPresenter) {
        self.presenter = presenter
    }
    
    var body: some View {
               
        let bindingSearchText = Binding<String>(get: {
            self.searchText
        }, set: {
            self.searchText = $0
            self.searchTextDidChange($0)
        })
        
        let bindingSearchBarCancelButtonAction = Binding<Bool>(get: {
            self.searchBarCancelButtonAction
        }, set: {
            self.searchBarCancelButtonAction = $0
            self.searchBarCancelButtonClicked($0)
        })
        
        VStack(spacing: 0) {
                        
            SearchBar(searchInput: bindingSearchText,
                      cancelButtonAction: bindingSearchBarCancelButtonAction)
            
            List {
                ForEach(presenter.words, id: \.id) { item in
                    self.presenter.linkBuilder(for: item) {
                        WordListCell(model: item)
                            .onAppear {
                                self.presenter.onAppearCell(word: item)
                            }
                    }
                }
                .onMove(perform: presenter.move)
                .onDelete(perform: presenter.delete)
            }
            .navigationBarTitle(KeysForTranslate.words.localized)
            .navigationBarItems(leading: EditButton(),
                                trailing:
                                    Button(action: { self.showingAddWord = true }) {
                                        Image(systemName: "plus")
                                    }.sheet(isPresented: $showingAddWord) {
                                        self.presenter.router.makeAddWordView()
                                    })
            
            
        }
    }
}

// MARK: - Search Text Did Change
fileprivate extension WordListView {
    
    func searchTextDidChange(_ string: String) {
        presenter.searchTextDidChange(string)
    }
    
}

// MARK: - Search Bar Cancel Button Clicked
fileprivate extension WordListView {
    
    func searchBarCancelButtonClicked(_ isClicked: Bool) {
        if (isClicked) {
            presenter.searchBarCancelButtonClicked()
        } else {
            return
        }
    }
    
}
