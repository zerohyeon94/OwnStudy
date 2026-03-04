//
//  TestCodeViewController.swift
//  OwnStudy
//
//  Created by 조영현 on 2/19/24.
//

import Foundation
import UIKit
import SnapKit

// Test 뷰컨트롤러
final class TestCodeViewController: UIViewController {
    var testCodeViewModel: TestCodeViewModel
    var testCodeView: TestCodeView

    lazy var dateLabel: UILabel = {
        let label = UILabel()
        
        label.font = AppTheme.Font.Page.title
        label.textColor = AppTheme.Color.text
        label.text = HomeViewModel().getCurrentDate()
        label.textAlignment = .left
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    init(testCodeViewModel: TestCodeViewModel) {
        print("testCodeViewModel: \(testCodeViewModel.testCodes)")
        self.testCodeViewModel = testCodeViewModel
        self.testCodeView = TestCodeView(testCodeViewModel: testCodeViewModel)

        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("viewWillAppear")
        navigationController?.isNavigationBarHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("[TestCodeViewController] viewDidLoad")
        view.backgroundColor = .white
        testCodeView.delegate = self

        // 뷰 초기화 및 레이아웃 설정
        view.addSubview(testCodeView)
        testCodeView.translatesAutoresizingMaskIntoConstraints = false
        
        testCodeView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        }

        // 뷰모델을 통해 데이터 업데이트
        testCodeView.updateView(with: testCodeViewModel)
    }
}

// MARK: - Action Handling
extension TestCodeViewController: TestCodeViewDelegate {
    func bookmarkButtonTapped(index: Int) {
        print("TestCodeViewController) \(index) Cell Click")
        
        print("testCodeViewModel.testCodes[\(index)]: \(testCodeViewModel.testCodes[index])")
        // 해당 문제에 대한 즐겨찾기 여부를 토글
        
        testCodeViewModel.testCodes[index].isBookmarked.toggle()
        
        print("testCodeViewModel.testCodes[\(index)]: \(testCodeViewModel.testCodes[index])")
        // 버튼을 다시 그리기 위해 해당 셀을 다시 로드
        let indexPath = IndexPath(row: index, section: 0)
        testCodeView.contentTableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
    func cellSelected(index: Int) {
        print("cell Selected: \(index)")
        
        let selectedCellType = testCodeViewModel.cellTypes[index]
        
        // 페이지로 이동하는 코드
        switch selectedCellType {
        case .delegate:
            print("delegate")
            let delegateViewController = FirstViewController()
            navigationController?.pushViewController(delegateViewController, animated: true)
        case .kvo:
            print("kvo")
            let kvoViewController = KVOViewController()
            navigationController?.pushViewController(kvoViewController, animated: true)
        case .combine:
            print("combine")
            let combineViewController = CombineViewController()
            navigationController?.pushViewController(combineViewController, animated: true)
        }
    }
}
