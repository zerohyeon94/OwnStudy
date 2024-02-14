//
//  CSInfoModel.swift
//  OwnStudy
//
//  Created by 조영현 on 2/5/24.
//

import Foundation

struct CSQuiz {
    let title: String
    let details: String
    var isBookmarked: Bool
}

struct CSInfoModel {
    let todayQuiz: CSQuiz? // 없을 수도 있어서.
    let bookmarkedQuizzes: [CSQuiz]
    let allQuizzes: [CSQuiz]
}