//
//  SignUpTextField.swift
//  OwnStudy
//
//  Created by 조영현 on 3/28/24.
//

import Foundation
import UIKit

class SignUpTextField: UITextField {
    enum TextFieldType {
        case email
        case password
        case name
        case age
        case goal
    }

    init(type: TextFieldType) {
        super.init(frame: .zero)
        
        self.backgroundColor = AppTheme.Color.TextField.background
        self.font = AppTheme.Font.Page.body
        self.textColor = AppTheme.Color.TextField.text
        self.layer.cornerRadius = 10
        
        self.returnKeyType = .done
        self.autocorrectionType = .no
        self.autocapitalizationType = .none
        
        self.leftViewMode = .always
        self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: self.frame.size.height))
        
        switch type {
        case .email:
            self.placeholder = "이메일"
            self.keyboardType = .emailAddress
            self.textContentType = .emailAddress
        case .password:
            self.placeholder = "비밀번호"
            self.textContentType = .oneTimeCode
            self.isSecureTextEntry = true
        case .name:
            self.placeholder = "한국어 (2~10글자)"
        case .age:
            self.placeholder = "나이"
        case .goal:
            self.placeholder = "목표"
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
