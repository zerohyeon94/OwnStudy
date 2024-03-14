//
//  LoginViewController.swift
//  OwnStudy
//
//  Created by 조영현 on 3/12/24.
//

import Foundation
import UIKit
import SnapKit

// final 키워드
final class LoginViewController: UIViewController {
    // ViewModel 생성
    var viewModel = LoginViewModel()
    
    // MARK: - ID 입력하는 텍스트 뷰
    private lazy var idTextFieldView: UIView = {
        let view = UIView()
        view.backgroundColor = AppTheme.Color.TextField.background
        view.layer.cornerRadius = 5
        view.clipsToBounds = true
        // View에 addSubview를 쓰기위해서 lazy var를 사용한다.
        view.addSubview(idTextField)
        view.addSubview(idInfoLabel)
        return view
    }()
    
    // 안내문구
    private let idInfoLabel: UILabel = {
        let label = UILabel()
        label.text = "ID"
        label.font = AppTheme.Font.Page.body
        label.textColor = AppTheme.Color.TextField.placeholder
        return label
    }()
    
    // 로그인 - ID 입력 필드
    private lazy var idTextField: UITextField = {
        var textField = UITextField()
        textField.frame.size.height = 48
        textField.backgroundColor = .clear
        textField.textColor = AppTheme.Color.TextField.text
        textField.tintColor = AppTheme.Color.TextField.text
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.spellCheckingType = .no
        textField.keyboardType = .emailAddress
        textField.addTarget(self, action: #selector(textFieldEditingChanged(_:)), for: .editingChanged)
        return textField
    }()
    
    
    // MARK: - 비밀번호 입력하는 텍스트 뷰
    private lazy var passwordTextFieldView: UIView = {
        let view = UIView()
        //view.frame.size.height = 48
        view.backgroundColor = AppTheme.Color.TextField.background
        view.layer.cornerRadius = 5
        view.clipsToBounds = true
        view.addSubview(passwordTextField)
        view.addSubview(passwordInfoLabel)
        view.addSubview(passwordSecureButton)
        return view
    }()
    
    // 패스워드 텍스트필드의 안내문구
    private let passwordInfoLabel: UILabel = {
        let label = UILabel()
        label.text = "비밀번호"
        label.font = AppTheme.Font.Page.body
        label.textColor = AppTheme.Color.TextField.placeholder
        return label
    }()
    
    // 로그인 - 비밀번호 입력 필드
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.frame.size.height = 48
        textField.backgroundColor = .clear
        textField.textColor = AppTheme.Color.TextField.text
        textField.tintColor = AppTheme.Color.TextField.text
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.spellCheckingType = .no
        textField.isSecureTextEntry = true
        textField.clearsOnBeginEditing = false
        textField.addTarget(self, action: #selector(textFieldEditingChanged(_:)), for: .editingChanged)
        return textField
    }()
    
    // 패스워드에 "표시"버튼 비밀번호 가리기 기능
    private lazy var passwordSecureButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("표시", for: .normal)
        button.setTitleColor(#colorLiteral(red: 0.8374180198, green: 0.8374378085, blue: 0.8374271393, alpha: 1), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .light)
        button.addTarget(self, action: #selector(passwordSecureModeSetting), for: .touchUpInside)
        return button
    }()
    
    // MARK: - 로그인버튼
    private lazy var loginButton: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = .clear
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        button.layer.borderColor = #colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
        button.setTitle("로그인", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.isEnabled = false
        button.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        return button
    }()
    
    // 이메일텍스트필드, 패스워드, 로그인버튼 스택뷰에 배치
    private lazy var stackView: UIStackView = {
        // stackView 내의 arrangedSubviews라는 생성자
        let stackView = UIStackView(arrangedSubviews: [idTextFieldView, passwordTextFieldView, loginButton])
        stackView.spacing = 18
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        return stackView
    }()
    
    // 비밀번호 재설정 버튼
    private lazy var passwordResetButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.setTitle("비밀번호 재설정", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.addTarget(self, action: #selector(resetButtonTapped), for: .touchUpInside)
        return button
    }()
    
    // 3개의 각 텍스트필드 및 로그인 버튼의 높이 설정
    private let textViewHeight: CGFloat = 48
    
    // 오토레이아웃 향후 변경을 위한 변수(애니메이션) -> 동적으로 Auto layout을 조절할 수 있다.
    lazy var emailInfoLabelCenterYConstraint = idInfoLabel.centerYAnchor.constraint(equalTo: idTextFieldView.centerYAnchor)
    lazy var passwordInfoLabelCenterYConstraint = passwordInfoLabel.centerYAnchor.constraint(equalTo: passwordTextFieldView.centerYAnchor)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print()
        configure()
        setupAutoLayout()
    }
    
    private func configure() {
        view.backgroundColor = #colorLiteral(red: 0.07450980392, green: 0.07450980392, blue: 0.07450980392, alpha: 1)
        
        // TextField의 델리게이트 패턴을 사용하기위해 해당 속성에 self로 지정
        // 각각의 textField의 대리자가 ViewController가 된다.
        idTextField.delegate = self
        passwordTextField.delegate = self
        
        [stackView, passwordResetButton].forEach { view.addSubview($0) }
    }
    
    // Auto Layout
    private func setupAutoLayout() {
        // ID View
        idInfoLabel.snp.makeConstraints { make in
            make.leading.equalTo(idTextFieldView.snp.leading).offset(8)
            make.trailing.equalTo(idTextFieldView.snp.trailing).offset(-8)
        }
        // 오토 레이아웃을 위해 변수로 선언 - 추후 값이 변경될 수 있기 때문에
        emailInfoLabelCenterYConstraint.isActive = true

        idTextField.snp.makeConstraints { make in
            make.top.equalTo(idTextFieldView.snp.top).offset(15)
            make.bottom.equalTo(idTextFieldView.snp.bottom).offset(-2)
            make.leading.equalTo(idTextFieldView.snp.leading).offset(8)
            make.trailing.equalTo(idTextFieldView.snp.trailing).offset(-8)
        }

        // Password View
        passwordInfoLabel.snp.makeConstraints { make in
            make.leading.equalTo(passwordTextFieldView.snp.leading).offset(8)
            make.trailing.equalTo(passwordTextFieldView.snp.trailing).offset(-8)
        }
        passwordInfoLabelCenterYConstraint.isActive = true

        // passwordTextField
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(passwordTextFieldView.snp.top).offset(15)
            make.bottom.equalTo(passwordTextFieldView.snp.bottom).offset(-2)
            make.leading.equalTo(passwordTextFieldView.snp.leading).offset(8)
            make.trailing.equalTo(passwordTextFieldView.snp.trailing).offset(-8)
        }

        // passwordSecureButton
        passwordSecureButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextFieldView.snp.top).offset(15)
            make.bottom.equalTo(passwordTextFieldView.snp.bottom).offset(-15)
            make.trailing.equalTo(passwordTextFieldView.snp.trailing).offset(-8)
        }

        // Id, Password View, Login Button, PasswordReset Button
        stackView.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.centerY.equalTo(view.snp.centerY)
            make.leading.equalTo(view.snp.leading).offset(30)
            make.trailing.equalTo(view.snp.trailing).offset(-30)
            make.height.equalTo(textViewHeight * 3 + 36)
        }
        
        passwordResetButton.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom).offset(10)
            make.leading.equalTo(view.snp.leading).offset(30)
            make.trailing.equalTo(view.snp.trailing).offset(-30)
            make.height.equalTo(textViewHeight)
        }
    }
    
    // MARK: - 비밀번호 가리기 모드 켜고 끄기
    @objc private func passwordSecureModeSetting() {
        passwordTextField.isSecureTextEntry.toggle()
    }
    
    // 로그인
    @objc func loginButtonTapped() {
        // 서버랑 통신해서, 다음 화면으로 넘어가는 내용 구현
        print("다음 화면으로 넘어가기")
        viewModel.showHomeScreen()
    }
    
    // 리셋버튼이 눌리면 동작하는 함수
    @objc func resetButtonTapped() {
        //만들기
        let alert = UIAlertController(title: "비밀번호 바꾸기", message: "비밀번호를 바꾸시겠습니까?", preferredStyle: .alert)
        let success = UIAlertAction(title: "확인", style: .default) { action in
            print("확인버튼이 눌렸습니다.")
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel) { action in
            print("취소버튼이 눌렸습니다.")
        }
        
        alert.addAction(success)
        alert.addAction(cancel)
        
        // 실제 띄우기
        self.present(alert, animated: true, completion: nil)
    }
    
    // 앱의 화면을 터치하면 동작하는 함수
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

// MARK: - UITextFieldDelegate 프로토콜 채택
extension LoginViewController: UITextFieldDelegate { // 프로토콜을 채택해서 선택적인 요구사항으로 선언되어있는 메서드를 사용해준다.
    // MARK: - 텍스트필드 편집 시작할때의 설정 - 문구가 위로올라가면서 크기 작아지고, 오토레이아웃 업데이트
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if textField == idTextField {
            idTextFieldView.backgroundColor = #colorLiteral(red: 0.2972877622, green: 0.2973434925, blue: 0.297280401, alpha: 1)
            idInfoLabel.font = UIFont.systemFont(ofSize: 11)
            // 오토레이아웃 업데이트
            emailInfoLabelCenterYConstraint.constant = -13
        }
        
        if textField == passwordTextField {
            passwordTextFieldView.backgroundColor = #colorLiteral(red: 0.2972877622, green: 0.2973434925, blue: 0.297280401, alpha: 1)
            passwordInfoLabel.font = UIFont.systemFont(ofSize: 11)
            // 오토레이아웃 업데이트
            passwordInfoLabelCenterYConstraint.constant = -13
        }
        
        // 실제 레이아웃 변경은 애니메이션으로 주는 효과
        UIView.animate(withDuration: 0.3) {
            self.stackView.layoutIfNeeded()
        }
    }
    
    // 텍스트필드 편집 종료되면 백그라운드 색 변경 (글자가 한개도 입력 안되었을때는 되돌리기)
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if textField == idTextField {
            idTextFieldView.backgroundColor = #colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
            // 빈칸이면 원래로 되돌리기
            if idTextField.text == "" {
                idInfoLabel.font = UIFont.systemFont(ofSize: 18)
                emailInfoLabelCenterYConstraint.constant = 0
            }
        }
        if textField == passwordTextField {
            passwordTextFieldView.backgroundColor = #colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
            // 빈칸이면 원래로 되돌리기
            if passwordTextField.text == "" {
                passwordInfoLabel.font = UIFont.systemFont(ofSize: 18)
                passwordInfoLabelCenterYConstraint.constant = 0
            }
        }
        
        // 실제 레이아웃 변경은 애니메이션으로 줄꺼야
        UIView.animate(withDuration: 0.3) {
            self.stackView.layoutIfNeeded()
        }
    }
    
    // MARK: - 이메일텍스트필드, 비밀번호 텍스트필드 두가지 다 채워져 있을때, 로그인 버튼 빨간색으로 변경
    @objc private func textFieldEditingChanged(_ textField: UITextField) {
        if textField.text?.count == 1 {
            if textField.text?.first == " " {
                textField.text = ""
                return
            }
        }
        guard
            let email = idTextField.text, !email.isEmpty,
            let password = passwordTextField.text, !password.isEmpty
        else {
            loginButton.backgroundColor = .clear
            loginButton.isEnabled = false
            return
        }
        loginButton.backgroundColor = .red
        loginButton.isEnabled = true
    }
    
    
    // 엔터 누르면 일단 키보드 내림
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
