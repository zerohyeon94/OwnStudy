//
//  FirstViewController.swift
//  OwnStudy
//
//  Created by 조영현 on 2/15/24.
//

import Foundation
import UIKit

class FirstViewController: UIViewController {
    
    lazy var pageTitleLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = AppTheme.Color.text
        label.font = AppTheme.Font.Cell.title
        label.textAlignment = .center
        label.text = "아직 UI가 변경되지 않았습니다."
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var nextButton: UIButton = {
        let button = UIButton()
        
        button.setTitleColor(AppTheme.Color.text, for: .normal)
        button.titleLabel?.font = AppTheme.Font.Cell.body
        button.setTitle("2번째 ViewController로 이동", for: .normal)
        button.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        autoLayout()
    }
    
    func autoLayout() {
        view.addSubview(pageTitleLabel)
        view.addSubview(nextButton)
        
        pageTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        nextButton.snp.makeConstraints { make in
            make.top.equalTo(pageTitleLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(16)
        }
    }
    
    
    // MARK: Action
    @objc func nextButtonTapped() {
        print("nextButtonTapped")
        let secondViewController = SecondViewController()
        secondViewController.modalPresentationStyle = .fullScreen
        secondViewController.delegate = self
        present(secondViewController, animated: true, completion: nil)
    }
}

extension FirstViewController: ChangeUIDelegate {
    func changeUI() {
        self.pageTitleLabel.text = "UI가 변경된 상태!"
        self.view.backgroundColor = .blue
    }
}

