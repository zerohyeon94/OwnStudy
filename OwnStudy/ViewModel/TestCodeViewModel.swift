//
//  TestCodeViewModel.swift
//  OwnStudy
//
//  Created by 조영현 on 2/19/24.
//

import Foundation

enum TestCodeCellType {
    case delegate
    case kvo
}

// CS 정보 뷰모델
class TestCodeViewModel {
    var cellTypes: [TestCodeCellType] = [.delegate, .kvo]
    
    var testCodeModel: TestCodeModel
    
    init(testCodeModel: TestCodeModel) {
        self.testCodeModel = testCodeModel
    }
    
    var shouldDisplayTodayQuiz: Bool {
        return testCodeModel.todayQuiz != nil
    }
    
    var testCodes: [TestCode] {
        get {
            return testCodeModel.testCodes
        }
        set {
            testCodeModel.testCodes = newValue
        }
    }
    
    // 다른 유용한 메서드 및 속성 추가
}
