//
//  WordDetailModule.swift
//  MyDictionary
//
//  Created by Admin on 27.11.2020.
//

import SwiftUI

final class WordDetailModule {
    
    var sender: Any?
    
    init(sender: Any?) {
        self.sender = sender
    }
    
}

extension WordDetailModule {
    
    var module: some View {
        guard let model = sender as? WordModel else { fatalError("Impossible Cast To \(WordModel.self)") }
        let dataModel = WordDetailDataModel.init(wordModel: model)
        let router = MYWordDetailRouter.init()
        let interactor = MYWordDetailInteractor.init(dataModel: dataModel)
        let presenter = MYWordDetailPresenter(interactor: interactor, router: router)
        let view = WordDetailView.init(presenter: presenter)
        return view
    }
    
}
