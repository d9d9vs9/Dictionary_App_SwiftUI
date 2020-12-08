//
//  WordDetailView.swift
//  MyDictionary
//
//  Created by Admin on 27.11.2020.
//

import SwiftUI

struct WordDetailView: View {
    
    @ObservedObject fileprivate var presenter: MYWordDetailPresenter
    @State fileprivate var word: String = Constants.StaticText.emptyString
    @State fileprivate var translatedWord: String = Constants.StaticText.emptyString
    
    init(presenter: MYWordDetailPresenter) {
        self.presenter = presenter
    }
    
    var body: some View {
        VStack {
            Text(KeysForTranslate.word.localized)
            TextField(self.presenter.wordModel.word, text: $word)
            Text(KeysForTranslate.translatedWord.localized)
            TextField(self.presenter.wordModel.translatedWord, text: $translatedWord)
        }
        .padding()
        .onDisappear {
            self.presenter.onDisappear(wordText: word, translatedWord: translatedWord) ;
            debugPrint("onDisappear", String(describing: WordDetailView.self))
        }
    }
    
}
