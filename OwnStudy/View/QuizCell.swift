//
//  QuizCell.swift
//  OwnStudy
//
//  Created by 조영현 on 2/2/24.
//

import Foundation
import UIKit

class QuizCell: UICollectionViewCell {
    static let cellIdentifier = "QuizCell"
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = ThemeColor.deepTextColor
        label.font = UIFont(name: "SpoqaHanSansNeo-Bold", size: 10)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 1.0
        layer.cornerRadius = 10.0
        layer.masksToBounds = true
        
        // 셀 내부의 UI 요소들 초기화
        titleLabel = UILabel(frame: contentView.bounds)
        titleLabel.textAlignment = .center
        titleLabel.textColor = .black
        
        // 셀에 UI 요소 추가
        contentView.addSubview(titleLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
