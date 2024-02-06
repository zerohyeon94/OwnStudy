//
//  CSInfoViewModel.swift
//  OwnStudy
//
//  Created by 조영현 on 2/6/24.
//

import Foundation

// CS 정보 뷰모델
class CSInfoViewModel {
    private let csInfoModel: CSInfoModel

    init(csInfoModel: CSInfoModel) {
        self.csInfoModel = csInfoModel
    }

    var shouldDisplayTodayQuiz: Bool {
        return csInfoModel.todayQuiz != nil
    }

    var bookmarkedQuizzes: [CSQuiz] {
        return csInfoModel.bookmarkedQuizzes
    }

    var allQuizzes: [CSQuiz] {
        return csInfoModel.allQuizzes
    }

    // 다른 유용한 메서드 및 속성 추가
}
