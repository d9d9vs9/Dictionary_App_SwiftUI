//
//  WordDetailView.swift
//  MyDictionary
//
//  Created by Admin on 27.11.2020.
//

import SwiftUI

struct WordDetailView: View {
    
    @ObservedObject fileprivate var presenter: MYWordDetailPresenter
    
    init(presenter: MYWordDetailPresenter) {
        self.presenter = presenter
    }
    
    var body: some View {
        Text(presenter.wordModel.word)
            .onDisappear { debugPrint("onDisappear", String(describing: WordDetailView.self)) }
    }
    
}