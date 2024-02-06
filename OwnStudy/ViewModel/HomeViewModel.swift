//
//  HomeViewModel.swift
//  OwnStudy
//
//  Created by 조영현 on 1/8/24.
//

import Foundation

enum CellType {
    case quiz
    case csInfo
    //    case swiftSyntax
    // 추가적인 셀 유형들...
    
    var cellIdentifier: String {
        switch self {
        case .quiz:
            return HomeQuizCell.cellIdentifier
        case .csInfo:
            return HomeCSInfoCell.cellIdentifier
            //        case .swiftSyntax:
            //            return SwiftSyntaxCell.cellIdentifier
            // 추가적인 셀 식별자들...
        }
    }
}

// 데이터를 뷰에 바인딩하고, 뷰에서 필요한 동작을 처리하는 역할을 하는 뷰 모델 클래스.
// 각 항목에 대한 데이터를 가지고 있고, 뷰에서 필요한 처리 로직을 정의
class HomeViewModel {
    var quizData: HomeModel.TodayQuiz
    var csInfoData: HomeModel.CSInfo
    //    var swiftSyntaxData: HomeModel.SwiftSyntax
    //    var techInterviewData: HomeModel.TechInterview
    //    var codingTestData: HomeModel.CodingTest
    //    var projectInfoData: HomeModel.ProjectInfo
    
    var cellTypes: [CellType] = [.quiz, .csInfo] // , .csInfo, .swiftSyntax
    var cellHeightSize: [CGFloat] = [210, 160]
    
    init() {
        // 데이터 초기화 및 필요한 로직 수행...
        quizData = HomeModel.TodayQuiz(title: "오늘의 퀴즈", question: "프로젝트의 이름은?", answer: "온스터디")
        csInfoData = HomeModel.CSInfo(title: "CS 정보", questionCount: 10, bookmarkedCount: 5)
    }
    
    // 현재 날짜
    func getCurrentDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let currentDate = dateFormatter.string(from: Date())
        return currentDate
    }
}
