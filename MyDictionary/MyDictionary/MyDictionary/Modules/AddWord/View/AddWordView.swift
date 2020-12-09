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
    @State fileprivate var showAlertAction: Bool = false
    @State fileprivate var error: Error? = nil
    
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
        .alert(isPresented: $showAlertAction) {
            Alert(title: Text(KeysForTranslate.error.localized),
                  message: Text(error?.localizedDescription ?? Constants.StaticText.emptyString),
                  dismissButton: .cancel(Text(KeysForTranslate.cancel.localized)))
        }
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
                self.setError(error)
                self.showAlert()
                debugPrint(error)
            }                        
            
        }
        
    }
    
}

// MARK: - Show Alert
fileprivate extension AddWordView {
    
    func showAlert() {
        self.showAlertAction = true
    }
    
}

// MARK: - Set Error
fileprivate extension AddWordView {
    
    func setError(_ newError: Error) {
        self.error = newError
    }
    
}

// MARK: - Close Self
fileprivate extension AddWordView {
    
    func closeSelf() {
        self.presentationMode.wrappedValue.dismiss()
    }
    
}
