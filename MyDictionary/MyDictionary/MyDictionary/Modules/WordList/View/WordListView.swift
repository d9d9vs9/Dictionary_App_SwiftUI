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
    @State fileprivate var showingAddWord: Bool = false
    
    init(presenter: MYWordListPresenter) {
        self.presenter = presenter
    }
    
    var body: some View {
               
        VStack(spacing: 0) {
                        
            SearchBar(searchInput: $searchText)
            
            List {
                ForEach(presenter.words, id: \.id) { item in
                    self.presenter.linkBuilder(for: item) {
                        WordListCell(model: item)
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
