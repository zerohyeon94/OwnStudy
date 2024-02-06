//
//  CSInfoCell.swift
//  OwnStudy
//
//  Created by 조영현 on 2/5/24.
//

import Foundation
import UIKit
import SnapKit

class HomeCSInfoCell: HomeCommonCell {
    static let cellIdentifier = "CSInfoCell"
    
    var questionCount: Int = 0
    var bookmarkedCount: Int = 0
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = AppTheme.Color.text
        label.font = AppTheme.Font.Cell.title
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var questionCountLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = AppTheme.Color.text
        label.font = AppTheme.Font.Cell.body
        // 추가로 문제의 수를 악해서 입력
        label.text = "문제 수 : \(questionCount)"
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var bookmarkedCountLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = AppTheme.Color.text
        label.font = AppTheme.Font.Cell.body
        // 추가로 문제의 수를 악해서 입력
        label.text = "즐겨찾기 수 : \(bookmarkedCount)"
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var countStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [questionCountLabel, bookmarkedCountLabel])
        stackView.backgroundColor = .white
        stackView.spacing = 0
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        autoLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func autoLayout() {
        // 셀에 UI 요소 추가
        contentView.addSubview(titleLabel)
        contentView.addSubview(countStackView)
        
        titleLabel.snp.makeConstraints { make in
            //            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0))
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview().offset(10)
        }
        
        countStackView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(10)
        }
    }
    
    func setCount(questionCount: Int, bookmarkedCount: Int) {
        self.questionCount = questionCount
        self.bookmarkedCount = bookmarkedCount
        
        questionCountLabel.text = "문제 수 : \(questionCount)"
        bookmarkedCountLabel.text = "즐겨찾기 수 : \(bookmarkedCount)"
    }
}
