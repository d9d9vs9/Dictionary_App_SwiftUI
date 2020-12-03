//
//  AddWordView.swift
//  MyDictionary
//
//  Created by Дмитрий Чумаков on 03.12.2020.
//

import SwiftUI

struct AddWordView: View {
    
    @ObservedObject fileprivate var presenter: MYAddWordPresenter
    
    init(presenter: MYAddWordPresenter) {
        self.presenter = presenter
    }
    
    var body: some View {
        VStack(alignment: .center) {
            Text(KeysForTranslate.pleaseEnterWord.localized)
            TextField(Constants.StaticText.emptyString,
                      text: presenter.$wordText)
        }.padding()
    }
    
}
