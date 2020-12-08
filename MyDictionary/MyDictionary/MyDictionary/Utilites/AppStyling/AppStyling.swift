//
//  AppStyling.swift
//  MyDictionary
//
//  Created by Дмитрий Чумаков on 08.12.2020.
//

import UIKit

struct AppStyling {
    
    enum Color {
        
        case systemGray
        
        /// - Parameter alpha: Default is 1
        func color(alpha: CGFloat = 1) -> UIColor {
            switch self {
            case .systemGray:
                return UIColor.systemGray.withAlphaComponent(alpha)            
            }
        }
        
    }
    
}

