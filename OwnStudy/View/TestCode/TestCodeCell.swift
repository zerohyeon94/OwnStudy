//
//  TestCodeCell.swift
//  OwnStudy
//
//  Created by 조영현 on 2/19/24.
//

import Foundation
import UIKit

class TestCodeCell: UITableViewCell {
    static let cellIdentifier = "TestCodeCell"
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = AppTheme.Color.text
        label.font = AppTheme.Font.Cell.body
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var bookmarkButton: UIButton = {
        let button = UIButton()
        
        button.setTitleColor(AppTheme.Color.text, for: .normal)
        button.titleLabel?.font = AppTheme.Font.Cell.body
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var contentStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, bookmarkButton])
        stackView.backgroundColor = .clear
        stackView.spacing = 0
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.alignment = .fill
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // cell 재사용 시 초기화
    override func prepareForReuse() {
        super.prepareForReuse()
        
    }
    
    func autoLayout() {
        // 셀에 UI 요소 추가
        contentView.addSubview(contentStackView)
        
        contentStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16))
        }
        
        // titleLabel의 높이를 내용에 맞게 조절
        titleLabel.setContentCompressionResistancePriority(.required, for: .vertical)
        titleLabel.setContentHuggingPriority(.required, for: .vertical)
    }
    
    private func setupUI() {

        autoLayout()
    }
}
