//
//  LoginViewModel.swift
//  OwnStudy
//
//  Created by 조영현 on 3/12/24.
//

import Foundation

class LoginViewModel {
    func login(with credentials: LoginModel, completion: @escaping (Bool) -> Void) {
        // 여기서는 로그인 처리 로직을 구현합니다.
        // 예를 들어, 서버에 요청하여 사용자 인증을 확인하고 결과를 반환합니다.
//        let isLoggedIn = // 로그인 처리 로직
//        completion(isLoggedIn)
        if credentials.id == "exampleUser" && credentials.password == "password123" {
                completion(true) // 로그인 성공
            } else {
                completion(false) // 로그인 실패
            }
    }
}
