//
//  KVOViewController.swift
//  OwnStudy
//
//  Created by 조영현 on 2/20/24.
//

import Foundation
import UIKit

class KVOViewController: UIViewController {
    
    lazy var label: UILabel = {
        let label = UILabel()
        
        label.text = "count: 0"
        label.textColor = AppTheme.Color.text
        label.font = AppTheme.Font.Cell.title
        label.textAlignment = .center
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var button: UIButton = {
        let button = UIButton()
        
        button.setTitle("Click", for: .normal)
        button.setTitleColor(AppTheme.Color.Button.isNotSelected, for: .normal)
        button.setTitleColor(AppTheme.Color.Button.isSelected, for: .highlighted)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var buttonObserverLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .center
        
        // 이미지와 텍스트를 함께 표시할 NSMutableAttributedString 생성
        let attributedString = NSMutableAttributedString(string: "count: ")
        let textAttachment = NSTextAttachment()
        textAttachment.image = UIImage(systemName: "heart.fill")
        let imageString = NSAttributedString(attachment: textAttachment)
        attributedString.append(imageString)
        
        // UILabel에 NSAttributedString 설정
        label.attributedText = attributedString
        
        return label
    }()
    
    private var buttonObserver: NSKeyValueObservation?
    private var labelObserver: NSKeyValueObservation?
    private var count = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        configureLayout()
        
        observerButton()
        observerLabel()
    }
    
    deinit {
        buttonObserver?.invalidate()
    }
    
    func configureLayout() {
        view.addSubview(label)
        view.addSubview(button)
        view.addSubview(buttonObserverLabel)
        
        label.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(0)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        button.snp.makeConstraints { make in
            make.top.equalTo(label.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        buttonObserverLabel.snp.makeConstraints { make in
            make.top.equalTo(button.snp.bottom).offset(30)
            make.leading.trailing.equalToSuperview().inset(16)
        }
    }
    
    func observerButton() {
        buttonObserver = button.observe(\.isHighlighted) { [weak self] object, _ in
            guard let self, object.isHighlighted else { return }
            print("observerButton() 메서드가 감지하였다.")
            
            count += 1
            label.text = "count: \(count)"
        }
    }
    
    func observerLabel() {
        labelObserver = label.observe(\.text, options: [.old, .new, .initial, .prior]) { [weak self] label, change in
            guard let self, label.text != nil else { return }
            print("observerLabel() 메서드가 감지하였다.")
            
            print("변경 정보: \(change)")
            print("change.newValue: \(change.newValue)")
            print("change.oldValue: \(change.oldValue)")
            print("------------------------------------------------------------")
        }
    }
}
