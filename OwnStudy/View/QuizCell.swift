//
//  QuizCell.swift
//  OwnStudy
//
//  Created by 조영현 on 2/2/24.
//

import Foundation
import UIKit
import SnapKit

class QuizCell: HomeCommonCell {
    static let cellIdentifier = "QuizCell"
    
    var titleLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = AppTheme.Color.text
        label.font = AppTheme.Font.Cell.title
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var questionLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = AppTheme.Color.text
        label.font = AppTheme.Font.Cell.body
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        autoLayout()
    }
    
    func autoLayout() {
        // 셀에 UI 요소 추가
        contentView.addSubview(titleLabel)
        contentView.addSubview(questionLabel)
        
        titleLabel.snp.makeConstraints { make in
            //            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0))
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview().offset(10)
        }
        
        questionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(10)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
