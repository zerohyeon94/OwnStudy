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
    
    // Label Obesrver 용
    private let labelObserverImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: "circle")
        imageView.clipsToBounds = false
        imageView.tintColor = .black
        return imageView
    }()
    
    private let labelObserverLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Label Observer"
        label.textColor = AppTheme.Color.text
        label.font = AppTheme.Font.Cell.body
        label.textAlignment = .left
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var labelObserverStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [labelObserverImageView, labelObserverLabel])
        stackView.backgroundColor = .clear
        stackView.spacing = 10
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.alignment = .fill
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    // Button Observer 용
    private let buttonObserverImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: "circle")
        imageView.tintColor = .black
        imageView.clipsToBounds = false
        return imageView
    }()
    
    private let buttonObserverLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Button Observer"
        label.textColor = AppTheme.Color.text
        label.font = AppTheme.Font.Cell.body
        label.textAlignment = .left
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var buttonObserverStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [buttonObserverImageView, buttonObserverLabel])
        stackView.backgroundColor = .clear
        stackView.spacing = 10
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.alignment = .fill
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
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
        view.addSubview(labelObserverStackView)
        view.addSubview(buttonObserverStackView)
        
        label.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(0)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        button.snp.makeConstraints { make in
            make.top.equalTo(label.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        labelObserverStackView.snp.makeConstraints { make in
            make.top.equalTo(button.snp.bottom).offset(30)
            make.trailing.equalToSuperview().inset(16)
            make.width.equalTo(200)
        }
        
        buttonObserverStackView.snp.makeConstraints { make in
            make.top.equalTo(labelObserverStackView.snp.bottom).offset(10)
            make.trailing.equalToSuperview().inset(16)
            make.width.equalTo(200)
        }
    }
    
    func observerButton() {
        buttonObserver = button.observe(\.isHighlighted, options: [.old, .new, .initial, .prior]) { [weak self] object, change in
            guard let self, object.isHighlighted else { return }
            
            // 감지 상태를 표시
            print("observerButton() 메서드가 감지하였다.")
            buttonObserverImageView.image = UIImage(systemName: "circle.fill")
            buttonObserverImageView.tintColor = .green
            // 1초 뒤에 원상 복귀
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.buttonObserverImageView.image = UIImage(systemName: "circle")
                self.buttonObserverImageView.tintColor = .black
            }
            
            print("Button 변경 정보: \(change)")
            
            // UI적으로 변경되는 것
            count += 1
            label.text = "count: \(count)"
        }
    }
    
    func observerLabel() {
        labelObserver = label.observe(\.text, options: [.old, .new, .initial, .prior]) { [weak self] label, change in
            guard let self, label.text != nil else { return }
            print("observerLabel() 메서드가 감지하였다.")
            labelObserverImageView.image = UIImage(systemName: "circle.fill")
            labelObserverImageView.tintColor = .yellow
            // 1초 뒤에 원상 복귀
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.labelObserverImageView.image = UIImage(systemName: "circle")
                self.labelObserverImageView.tintColor = .black
            }
            
            print("Label 변경 정보: \(change)")
            print("change.newValue: \(change.newValue)")
            print("change.oldValue: \(change.oldValue)")
            print("------------------------------------------------------------")
        }
    }
}
