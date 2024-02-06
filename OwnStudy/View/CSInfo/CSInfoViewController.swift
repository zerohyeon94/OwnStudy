//
//  CSInfoViewController.swift
//  OwnStudy
//
//  Created by 조영현 on 2/6/24.
//

import Foundation
import UIKit

// CS 정보 뷰컨트롤러
class CSInfoViewController: UIViewController {
    private let csInfoViewModel: CSInfoViewModel
    private let csInfoView: CSInfoView

    init(csInfoViewModel: CSInfoViewModel) {
        self.csInfoViewModel = csInfoViewModel
        self.csInfoView = CSInfoView()

        super.init(nibName: nil, bundle: nil)
    }

    override func viewWillAppear(_ animated: Bool) {
        // NavigationBar 숨김.
        navigationController?.isNavigationBarHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("CSInfo")

        // 뷰 초기화 및 레이아웃 설정
        view.addSubview(csInfoView)
        csInfoView.snp.makeConstraints { make in
            // 적절한 레이아웃 설정
        }

        // 뷰모델을 통해 데이터 업데이트
        csInfoView.updateView(with: csInfoViewModel)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
