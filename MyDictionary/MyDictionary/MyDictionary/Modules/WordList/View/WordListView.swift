//
//  WordListView.swift
//  MyDictionary
//
//  Created by Admin on 27.11.2020.
//

import SwiftUI

struct WordListView: View {
    
    @ObservedObject fileprivate var presenter: MYWordListPresenter    
    @State fileprivate var showingAddWord = false
    
    init(presenter: MYWordListPresenter) {
        self.presenter = presenter
    }
    
    var body: some View {
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
