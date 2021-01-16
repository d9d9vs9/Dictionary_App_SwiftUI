//
//  AppStyling.swift
//  MyDictionary
//
//  Created by Дмитрий Чумаков on 08.12.2020.
//

import SwiftUI

struct AppStyling {
    
    enum MYColor {
        
        case clear
        case black
        case white
        case gray
        
        /// - Parameter opacity: Default is 1
        func color(opacity: Double = 1) -> Color {
            switch self {
            case .clear:
                return .clear
            case .black:
                return Color.black.opacity(opacity)
            case .white:
                return Color.white.opacity(opacity)
            case .gray:
                return Color.gray.opacity(opacity)
            }
        }
        
    }
    
}

