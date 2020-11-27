//
//  WordListCell.swift
//  MyDictionary
//
//  Created by Admin on 27.11.2020.
//

import SwiftUI

struct WordListCell: View {
    
    @ObservedObject var model: WordModel
    
    var body: some View {
        Text(model.word)
    }
    
}

struct WordListCell_Previews: PreviewProvider {
    static var previews: some View {
        WordListCell(model: WordModel.mock.first!)
    }
}
