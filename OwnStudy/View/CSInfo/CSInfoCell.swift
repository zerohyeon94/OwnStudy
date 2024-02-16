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
    
    // cell 선택시 변경되는 효과
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//        
//        if selected {
//            contentView.layer.borderWidth = 2
//            contentView.layer.borderColor = UIColor.blue.cgColor
//        } else {
//            contentView.layer.borderWidth = 1
//            contentView.layer.borderColor = UIColor.lightGray.cgColor
//        }
//    }
    
    // cell 사이의 간격을 두지 않고 한열로 배열하기 위해서 사용하지 않음.
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        
//        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16))
//    }
    
    // 테투리 사용하지 않음.
//    private func setLayer() {
//        layer.borderColor = UIColor.black.cgColor // 테두리 색상
//        layer.borderWidth = 1.0 // 테두리 두께
//        layer.cornerRadius = 10.0 // 모서리를 둥글게
//        layer.masksToBounds = true // 뷰의 내용이 테두리를 넘어가지 않도록 범위 설정.
//    }
    
    func autoLayout() {
        // 셀에 UI 요소 추가
        contentView.addSubview(csInfoStackView)
        
        csInfoStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16))
        }
        
        // titleLabel의 높이를 내용에 맞게 조절
        titleLabel.setContentCompressionResistancePriority(.required, for: .vertical)
        titleLabel.setContentHuggingPriority(.required, for: .vertical)
    }
    
    private func setupUI() {
        //        contentView.backgroundColor = .clear
        
//        setLayer()
        autoLayout()
    }
}
