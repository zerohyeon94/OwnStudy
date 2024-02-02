//
//  HomeCommonCell.swift
//  OwnStudy
//
//  Created by 조영현 on 2/2/24.
//

import Foundation
import UIKit

class HomeCommonCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 1.0
        layer.cornerRadius = 10.0
        layer.masksToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
