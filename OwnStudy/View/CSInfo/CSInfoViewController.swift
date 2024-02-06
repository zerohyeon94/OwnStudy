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
    private let csInfoViewModel: CSInfoViewModel
    private let csInfoView: CSInfoView

    init(csInfoViewModel: CSInfoViewModel) {
        print("csInfoViewModel: \(csInfoViewModel.allQuizzes.count)")
        self.csInfoViewModel = csInfoViewModel
        self.csInfoView = CSInfoView(csInfoViewModel: csInfoViewModel) // csInfoViewModel 전달

        super.init(nibName: nil, bundle: nil)
    }

    override func viewWillAppear(_ animated: Bool) {
        // NavigationBar 숨김.
        navigationController?.isNavigationBarHidden = false
    }
    
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        
        label.font = AppTheme.Font.Page.title
        label.textColor = AppTheme.Color.text
        label.text = HomeViewModel().getCurrentDate()
        label.textAlignment = .left
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("CSInfo")
        view.backgroundColor = .white

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

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
