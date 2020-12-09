//
//  WordDetailView.swift
//  MyDictionary
//
//  Created by Admin on 27.11.2020.
//

import SwiftUI

struct WordDetailView: View {
    
    @Environment(\.presentationMode) private var presentationMode
    @ObservedObject fileprivate var presenter: MYWordDetailPresenter
    @State fileprivate var word: String = Constants.StaticText.emptyString
    @State fileprivate var translatedWord: String = Constants.StaticText.emptyString
    @State fileprivate var showAlertAction: Bool = false
    @State fileprivate var error: Error? = nil
    
    init(presenter: MYWordDetailPresenter) {
        self.presenter = presenter
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(KeysForTranslate.word.localized)
            TextField(self.presenter.wordModel.word,
                      text: $word)
            Text(KeysForTranslate.translatedWord.localized)
            TextField(self.presenter.wordModel.translatedWord,
                      text: $translatedWord)
                .navigationBarItems(trailing:
                                        Button(action: {
                                            self.doneButtonAction()
                                        }) {
                                            Text(KeysForTranslate.done.localized)
                                        })
                
                .onDisappear {
                    debugPrint("onDisappear", String(describing: WordDetailView.self))
                }                
        }
        .alert(isPresented: $showAlertAction) {
            Alert(title: Text(KeysForTranslate.error.localized),
                  message: Text(error?.localizedDescription ?? Constants.StaticText.emptyString),
                  dismissButton: .cancel(Text(KeysForTranslate.cancel.localized)))
        }
    }
}

// MARK: - Actions
fileprivate extension WordDetailView {
    
    func doneButtonAction() {
        self.presenter.doneButtonClicked(wordText: self.word,
                                         translatedWord: self.translatedWord) { (result) in
            switch result {
            case .success:
                self.closeSelf()
            case .failure(let error):
                self.setError(error)
                self.showAlert()
                debugPrint(#function, error)
                break
            }
        }
    }
    
}

// MARK: - Show Alert
fileprivate extension WordDetailView {
    
    func showAlert() {
        self.showAlertAction = true
    }
    
}

// MARK: - Set Error
fileprivate extension WordDetailView {
    
    func setError(_ newError: Error) {
        self.error = newError
    }
    
}

// MARK: - Close Self
fileprivate extension WordDetailView {
    
    func closeSelf() {
        self.presentationMode.wrappedValue.dismiss()
    }
    
}
