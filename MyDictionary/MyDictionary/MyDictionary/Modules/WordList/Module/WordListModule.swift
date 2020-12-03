//
//  WordListModule.swift
//  MyDictionary
//
//  Created by Admin on 27.11.2020.
//

import SwiftUI

final class WordListModule {
    
    var sender: Any?
    
    init(sender: Any?) {
        self.sender = sender
    }
    
}

extension WordListModule {
    
    var module: some View {
        let dataModel = WordListDataModel.init()
        let router = WordListRouter.init()
        let interactor = MYWordListInteractor.init(dataModel: dataModel)
        let presenter = MYWordListPresenter(interactor: interactor, router: router)
        let view = WordListView.init(presenter: presenter)
        return NavigationView { view }
    }
    
}
