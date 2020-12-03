//
//  WordListView.swift
//  MyDictionary
//
//  Created by Admin on 27.11.2020.
//

import SwiftUI

struct WordListView: View {
    
    @ObservedObject fileprivate var presenter: MYWordListPresenter
    
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
        .navigationBarItems(trailing: presenter.makeAddNewButton())
    }
    
}

struct WordListView_Previews: PreviewProvider {
    static var previews: some View {
        return WordListModule.init(sender: nil).module
    }
}
