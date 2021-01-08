//
//  SearchBar.swift
//  MyDictionary
//
//  Created by Дмитрий Чумаков on 08.12.2020.
//

import SwiftUI

struct SearchBar: View {
    
    @Binding var searchInput: String
    @Binding var cancelButtonAction: Bool
    
    var body: some View {
        ZStack {
            // Background Color
            Color(AppStyling.Color.lightGray.color())
            // Custom Search Bar (Search Bar + 'Cancel' Button)
            HStack {
                // Search Bar
                HStack {
                    // Magnifying Glass Icon
                    Image(systemName: "magnifyingglass")
                    
                    // Search Area TextField
                    TextField(KeysForTranslate.search.localized,
                              text: $searchInput)
                        .accentColor(Color(AppStyling.Color.systemBlack.color()))
                        .foregroundColor(Color(AppStyling.Color.systemBlack.color()))
                }
                .padding(EdgeInsets(top: 5,
                                    leading: 5,
                                    bottom: 5,
                                    trailing: 5))
                .background(Color(AppStyling.Color.systemWhite.color()).cornerRadius(8.0))
                
                // 'Cancel' Button
                Button(action: {
                    self.searchInput = Constants.StaticText.emptyString
                    self.cancelButtonAction = true
                    // Hide Keyboard
                    Constants.Keyboard.hideKeyboard()
                }, label: {
                    Text(KeysForTranslate.cancel.localized)
                })
                .accentColor(Color(AppStyling.Color.systemWhite.color()))
                .padding(EdgeInsets(top: 2,
                                    leading: 2,
                                    bottom: 2,
                                    trailing: 8))
            }
            .padding(EdgeInsets(top: 5,
                                leading: 5,
                                bottom: 5,
                                trailing: 5))
        }
        .frame(height: 50)
    }
    
}
