//
//  AppTheme.swift
//  OwnStudy
//
//  Created by 조영현 on 2/2/24.
//

import Foundation
import UIKit

struct AppTheme {
    struct Color {
        static let primary = UIColor.blue
        static let secondary = UIColor.green
        static let text = UIColor.black
        
        struct Button {
            static let isSelected = UIColor.green
            static let isNotSelected = UIColor.lightGray
        }
    }

    struct Font {
        struct Page {
            static let title = UIFont(name: "SpoqaHanSansNeo-Bold", size: 25)
        }
        
        struct Cell {
            static let title = UIFont(name: "SpoqaHanSansNeo-Bold", size: 20)
            static let body = UIFont(name: "SpoqaHanSansNeo-Medium", size: 16)
        }
    }
}
