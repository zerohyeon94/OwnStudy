//
//  SecondViewController.swift
//  OwnStudy
//
//  Created by 조영현 on 2/15/24.
//

import Foundation
import UIKit

protocol ChangeUIDelegate: class {
    func changeUI()
}

class SecondViewController: UIViewController {
    
    var delegate: ChangeUIDelegate?
    
    lazy var pageTitleLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = AppTheme.Color.text
        label.font = AppTheme.Font.Cell.title
        label.text = "2번째 화면 입니다."
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var changeUIButton: UIButton = {
        let button = UIButton()
        
        button.setTitleColor(AppTheme.Color.text, for: .normal)
        button.titleLabel?.font = AppTheme.Font.Cell.body
        button.setTitle("UI 변경", for: .normal)
        button.addTarget(self, action: #selector(changeUIButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        autoLayout()
    }
    
    func autoLayout() {
        view.addSubview(pageTitleLabel)
        view.addSubview(changeUIButton)

        pageTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        changeUIButton.snp.makeConstraints { make in
            make.top.equalTo(pageTitleLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(16)
        }
    }
    
    // MARK: Action
    @objc func changeUIButtonTapped() {
        print("delegate")
        self.delegate?.changeUI()
        self.dismiss(animated: true)
    }
}
