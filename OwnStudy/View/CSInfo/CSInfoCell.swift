//
//  CSInfoCell.swift
//  OwnStudy
//
//  Created by 조영현 on 2/6/24.
//

import Foundation
import UIKit

class CSInfoCell: UITableViewCell {
    static let cellIdentifier = "CSInfoCell"
    
    lazy var numberLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = AppTheme.Color.text
        label.font = AppTheme.Font.Cell.title
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
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
    
    lazy var csInfoStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [numberLabel, titleLabel, bookmarkButton])
        stackView.backgroundColor = .white
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
        setupUI()
    }
    
    private func setLayer() {
        layer.borderColor = UIColor.black.cgColor // 테두리 색상
        layer.borderWidth = 1.0 // 테두리 두께
        layer.cornerRadius = 10.0 // 모서리를 둥글게
        layer.masksToBounds = true // 뷰의 내용이 테두리를 넘어가지 않도록 범위 설정.
    }
    
    func autoLayout() {
        // 셀에 UI 요소 추가
        contentView.addSubview(csInfoStackView)
        
        csInfoStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0))
        }
    }

    private func setupUI() {
        setLayer()
        autoLayout()
    }
}
