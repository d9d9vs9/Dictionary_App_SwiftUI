//
//  WordListRouter.swift
//  MyDictionary
//
//  Created by Admin on 27.11.2020.
//

import SwiftUI

final class WordListRouter {
    
}

extension WordListRouter {

    func makeWordDetailView(for word: WordModel) -> some View {
        return WordDetailModule.init(sender: word).module
    }

}
