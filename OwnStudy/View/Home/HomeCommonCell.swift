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
        
        layer.borderColor = UIColor.black.cgColor // 테두리 색상
        layer.borderWidth = 1.0 // 테두리 두께
        layer.cornerRadius = 10.0 // 모서리를 둥글게
        layer.masksToBounds = true // 뷰의 내용이 테두리를 넘어가지 않도록 범위 설정.
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
