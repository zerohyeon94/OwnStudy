//
//  CSInfoViewController.swift
//  OwnStudy
//
//  Created by 조영현 on 2/6/24.
//

import Foundation
import UIKit
import SnapKit

// CS 정보 뷰컨트롤러
class CSInfoViewController: UIViewController {
    var csInfoViewModel: CSInfoViewModel
    var csInfoView: CSInfoView

    lazy var dateLabel: UILabel = {
        let label = UILabel()
        
        label.font = AppTheme.Font.Page.title
        label.textColor = AppTheme.Color.text
        label.text = HomeViewModel().getCurrentDate()
        label.textAlignment = .left
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    init(csInfoViewModel: CSInfoViewModel) {
        print("csInfoViewModel: \(csInfoViewModel.quizzes.count)")
        self.csInfoViewModel = csInfoViewModel
        self.csInfoView = CSInfoView(csInfoViewModel: csInfoViewModel) // csInfoViewModel 전달

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
        print("viewDidLoad")
        view.backgroundColor = .white
        csInfoView.delegate = self

//        view.addSubview(dateLabel) // date관련된 정보를 모은 UItitleStackView를 뷰에 추가
//        
//        // SnapKit을 사용하여 Auto Layout 설정
//        dateLabel.snp.makeConstraints { make in
//            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(0) // 원하는 top 여백 설정
//            make.leading.trailing.equalToSuperview().inset(16) // 좌우 여백 설정
//        }

        // 뷰 초기화 및 레이아웃 설정
        view.addSubview(csInfoView)
        csInfoView.translatesAutoresizingMaskIntoConstraints = false
        
        csInfoView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        }

        // 뷰모델을 통해 데이터 업데이트
        csInfoView.updateView(with: csInfoViewModel)
    }
}

// MARK: - Action Handling
extension CSInfoViewController: CSInfoViewDelegate {
    func bookmarkButtonTapped(index: Int) {
        print("CSInfoViewController) \(index) Cell Click")
        
        print("csInfoViewModel.quizzes[\(index)]: \(csInfoViewModel.quizzes[index])")
        // 해당 문제에 대한 즐겨찾기 여부를 토글
        
        csInfoViewModel.quizzes[index].isBookmarked.toggle()
        
        print("csInfoViewModel.quizzes[\(index)]: \(csInfoViewModel.quizzes[index])")
        // 버튼을 다시 그리기 위해 해당 셀을 다시 로드
        let indexPath = IndexPath(row: index, section: 0)
        csInfoView.csInfotableView.reloadRows(at: [indexPath], with: .automatic)
    }
}
