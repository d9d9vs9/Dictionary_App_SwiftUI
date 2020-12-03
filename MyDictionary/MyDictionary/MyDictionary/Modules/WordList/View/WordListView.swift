//
//  WordListView.swift
//  MyDictionary
//
//  Created by Admin on 27.11.2020.
//

import SwiftUI

struct WordListView: View {
    
    @ObservedObject fileprivate var presenter: MYWordListPresenter
    @State fileprivate var showingDetail = false
    
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
        }
        .navigationBarTitle(KeysForTranslate.words.localized)
        .navigationBarItems(trailing:
                                Button(action: { self.showingDetail = true }) {
                                    Image(systemName: "plus")
                                }.sheet(isPresented: $showingDetail) {
                                    self.presenter.router.makeAddWordView()
                                })
    }
    
}
