//
//  SearchBar.swift
//  MyDictionary
//
//  Created by Дмитрий Чумаков on 08.12.2020.
//

import SwiftUI

struct SearchBar: View {
    
    @Binding var searchInput: String
    @State fileprivate var searching = false
    
    var body: some View {
        ZStack {
            // Background Color
            Color(#colorLiteral(red: 0.737254902, green: 0.1294117647, blue: 0.2941176471, alpha: 1))
            // Custom Search Bar (Search Bar + 'Cancel' Button)
            HStack {
                // Search Bar
                HStack {
                    // Magnifying Glass Icon
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(Color(#colorLiteral(red: 0.737254902, green: 0.1294117647, blue: 0.2941176471, alpha: 1)))
                    
                    // Search Area TextField
                    TextField("", text: $searchInput)
                        .accentColor(.white)
                        .foregroundColor(.white)
                }
                .padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5))
                .background(Color(#colorLiteral(red: 0.6196078431, green: 0.1098039216, blue: 0.2509803922, alpha: 1)).cornerRadius(8.0))
                
                // 'Cancel' Button
                Button(action: {
                    searching = false
                    searchInput = Constants.StaticText.emptyString
                    
                    // Hide Keyboard
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                }, label: {
                    Text("Cancel")
                })
                .accentColor(Color.white)
                .padding(EdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 8))
            }
            .padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5))
        }
        .frame(height: 50)
    }
        
}
