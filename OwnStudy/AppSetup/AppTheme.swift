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
        
        struct TextField {
            static let background = UIColor.darkGray
            static let placeholder = UIColor.white
            static let secure = UIColor.white
            static let text = UIColor.white
        }
        
        struct Button {
            static let isSelected = UIColor.green
            static let isNotSelected = UIColor.lightGray
        }
        
        // stash Test
        struct Observer {
            static let isObserved = UIColor.yellow
            static let isNotObserved = UIColor.black
        }
    }

    struct Font {
        struct Page {
            static let title = UIFont(name: "SpoqaHanSansNeo-Bold", size: 25)
            static let body = UIFont(name: "SpoqaHanSansNeo-Medium", size: 18)
            static let subBody = UIFont(name: "SpoqaHanSansNeo-Medium", size: 14)
            static let button = UIFont(name: "SpoqaHanSansNeo-Medium", size: 16)
            static let subButton = UIFont(name: "SpoqaHanSansNeo-Medium", size: 14)
        }
        
        struct Cell {
            static let title = UIFont(name: "SpoqaHanSansNeo-Bold", size: 20)
            static let body = UIFont(name: "SpoqaHanSansNeo-Medium", size: 16)
        }
    }
}
