//
//  AddWordView.swift
//  MyDictionary
//
//  Created by Дмитрий Чумаков on 03.12.2020.
//

import SwiftUI

struct AddWordView: View {
    
    @Environment(\.presentationMode) private var presentationMode
    @ObservedObject fileprivate var presenter: MYAddWordPresenter
    /// Default is Constants.StaticText.emptyString
    @State fileprivate var wordText: String = Constants.StaticText.emptyString
    /// Default is Constants.StaticText.emptyString
    @State fileprivate var translatedText: String = Constants.StaticText.emptyString
    
    init(presenter: MYAddWordPresenter) {
        self.presenter = presenter
    }
    
    var body: some View {
        VStack() {
            TextField(KeysForTranslate.pleaseEnterWord.localized,
                      text: $wordText)
            TextField(KeysForTranslate.pleaseEnterTranslate.localized,
                      text: $translatedText)
            Button(action: {
                self.addToMyDictionaryButtonAction()
            }) {
                Text(KeysForTranslate.addToMyDictionary.localized)
            }
        }.padding()
    }
    
}

// MARK: - Actions
fileprivate extension AddWordView {
    
    func addToMyDictionaryButtonAction() {
        presenter.addToMyDictionaryButtonClicked(wordText: wordText,
                                                 translatedText: translatedText) { (result) in
            
            switch result {
            case .success:
                closeSelf()
            case .failure(let error):
                debugPrint(error)
            }                        
            
        }
        
    }
    
}

// MARK: - Close Self
fileprivate extension AddWordView {
    
    func closeSelf() {
        self.presentationMode.wrappedValue.dismiss()
    }
    
}
