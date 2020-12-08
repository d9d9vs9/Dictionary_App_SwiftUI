//
//  AppStyling.swift
//  MyDictionary
//
//  Created by Дмитрий Чумаков on 08.12.2020.
//

import UIKit

struct AppStyling {
    
    enum Color {
        
        case clear
        case systemBlack
        case systemWhite
        case systemGray
        case lightGray
        
        /// - Parameter alpha: Default is 1
        func color(alpha: CGFloat = 1) -> UIColor {
            switch self {
            case .clear:
                return UIColor.clear
            case .systemBlack:
                return UIColor.black.withAlphaComponent(alpha)
            case .systemWhite:
                return UIColor.white.withAlphaComponent(alpha)
            case .systemGray:
                return UIColor.systemGray.withAlphaComponent(alpha)
            case .lightGray:                
                return UIColor.lightGray.withAlphaComponent(alpha)
            }
        }
        
    }
    
}

