//
//  TestCodeModel.swift
//  OwnStudy
//
//  Created by 조영현 on 2/19/24.
//

import Foundation

struct TestCode {
    let title: String
    var isBookmarked: Bool
}

struct TestCodeModel {
    var todayQuiz: TestCode? // 없을 수도 있어서.
    var testCodes: [TestCode]
}
