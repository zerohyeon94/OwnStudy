//
//  CSInfoViewModel.swift
//  OwnStudy
//
//  Created by 조영현 on 2/6/24.
//

import Foundation

// CS 정보 뷰모델
class CSInfoViewModel {
    var csInfoModel: CSInfoModel
    
    init(csInfoModel: CSInfoModel) {
        self.csInfoModel = csInfoModel
    }
    
    var shouldDisplayTodayQuiz: Bool {
        return csInfoModel.todayQuiz != nil
    }
    
    var quizzes: [CSQuiz] {
        get {
            return csInfoModel.Quizzes
        }
        set {
            csInfoModel.Quizzes = newValue
        }
    }
    
    // 다른 유용한 메서드 및 속성 추가
}
