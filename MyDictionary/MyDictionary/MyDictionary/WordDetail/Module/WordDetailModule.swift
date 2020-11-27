//
//  WordDetailModule.swift
//  MyDictionary
//
//  Created by Admin on 27.11.2020.
//

import SwiftUI

final class WordDetailModule {
    
}

extension WordDetailModule {
    
    static var module: some View {
        let dataModel = WordDetailDataModel.init()
        let router = MYWordDetailRouter.init()
        let interactor = MYWordDetailInteractor.init(dataModel: dataModel)
        let presenter = MYWordDetailPresenter(interactor: interactor, router: router)
        let view = WordDetailView.init(presenter: presenter)
        return view
    }
    
}
