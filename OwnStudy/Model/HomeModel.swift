//
//  HomeModel.swift
//  OwnStudy
//
//  Created by 조영현 on 1/8/24.
//
import Foundation

// 홈 화면에 표시되는 항목에 대한 데이터를 담당
struct HomeModel {
    struct Quiz {
        var title: String
        var question: String
        var answer: String
    }

    struct CSInfo {
        var title: String
        var questionCount: Int
        var bookmarkedCount: Int
    }

    struct SwiftSyntax {
        // Swift 문법 모델 정의...
    }

    struct TechInterview {
        // 기술 면접 모델 정의...
    }

    struct CodingTest {
        // 코딩 테스트 모델 정의...
    }

    struct ProjectInfo {
        // 프로젝트 정보 모델 정의...
    }
}
