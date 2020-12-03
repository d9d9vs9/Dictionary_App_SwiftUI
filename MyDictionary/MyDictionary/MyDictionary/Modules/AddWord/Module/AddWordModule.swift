//
//  AddWordModule.swift
//  MyDictionary
//
//  Created by Дмитрий Чумаков on 03.12.2020.
//

import SwiftUI

final class AddWordModule {
    
    var sender: Any?
    
    init(sender: Any?) {
        self.sender = sender
    }
    
}

extension AddWordModule {
    
    var module: some View {
        let dataModel = AddWordDataModel.init()
        let router = AddWordRouter.init()
        let interactor = MYAddWordInteractor.init(dataModel: dataModel)
        let presenter = MYAddWordPresenter(interactor: interactor, router: router)
        let view = AddWordView.init(presenter: presenter)
        return view
    }
    
}
