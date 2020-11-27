//
//  WordListModule.swift
//  MyDictionary
//
//  Created by Admin on 27.11.2020.
//

import SwiftUI

final class WordListModule {
    
}

extension WordListModule {
    
    static var module: some View {
        let dataModel = WordListDataModel.init()
        let router = MYWordListRouter.init()
        let interactor = MYWordListInteractor.init(dataModel: dataModel)
        let presenter = MYWordListPresenter(interactor: interactor, router: router)
        let view = WordListView.init(presenter: presenter)
        return NavigationView { view }
    }
    
}
