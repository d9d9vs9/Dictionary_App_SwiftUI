//
//  WordDetailView.swift
//  MyDictionary
//
//  Created by Admin on 27.11.2020.
//

import SwiftUI

struct WordDetailView: View {
    
    @ObservedObject fileprivate var presenter: MYWordDetailPresenter
    
    init(presenter: MYWordDetailPresenter) {
        self.presenter = presenter
    }
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
    
}

struct WordDetailView_Previews: PreviewProvider {
    
    static var previews: some View {
        return WordDetailModule.module
    }
    
}
