//
//  HomeTestCodeCell.swift
//  OwnStudy
//
//  Created by 조영현 on 2/15/24.
//

import Foundation
import UIKit
import SnapKit

class HomeTestCodeCell: HomeCommonCell {
    static let cellIdentifier = "HomeTestCodeCell"
    
    var recentTestTitle: String = ""
    var codeTestCount: Int = 0
    var bookmarkedCount: Int = 0
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = AppTheme.Color.text
        label.font = AppTheme.Font.Cell.title
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var recentTestTitleLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = AppTheme.Color.text
        label.font = AppTheme.Font.Cell.body
        label.text = "최근에 추가된 코드 테스트: \(recentTestTitle)"
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var codeTestCountLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = AppTheme.Color.text
        label.font = AppTheme.Font.Cell.body
        label.text = "코드 테스트 수 : \(codeTestCount)"
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var bookmarkedCountLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = AppTheme.Color.text
        label.font = AppTheme.Font.Cell.body
        label.text = "즐겨찾기 수 : \(bookmarkedCount)"
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var countStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [codeTestCountLabel, bookmarkedCountLabel])
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
        contentView.addSubview(recentTestTitleLabel)
        
        titleLabel.snp.makeConstraints { make in
            //            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0))
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview().offset(10)
        }
        
        countStackView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(10)
        }
        
        recentTestTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(countStackView.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(10)
        }
    }
    
    func setCount(codeTestCount: Int, bookmarkedCount: Int) {
        self.codeTestCount = codeTestCount
        self.bookmarkedCount = bookmarkedCount
        
        codeTestCountLabel.text = "문제 수 : \(codeTestCount)"
        bookmarkedCountLabel.text = "즐겨찾기 수 : \(bookmarkedCount)"
    }
}
