//
//  HomeViewController.swift
//  OwnStudy
//
//  Created by 조영현 on 1/8/24.
//

import Foundation
import UIKit
import SnapKit

// ViewModel과 상호작용하여 화면을 구성하는 곳.
class HomeViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    let colorArray: [UIColor] = [.red, .blue, .green, .yellow, .orange, .purple]
    
    var viewModel: HomeViewModel = HomeViewModel()
    
    // 오늘 날짜. 공부가 유지되는 일차 표시
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        
        label.font = AppTheme.Font.Page.title
        label.textColor = AppTheme.Color.text
        label.text = viewModel.getCurrentDate()
        label.textAlignment = .left
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var dDayLabel: UILabel = {
        let label = UILabel()
        
        label.font = AppTheme.Font.Page.title
        label.textColor = AppTheme.Color.text
        label.text = "1일차"
        label.textAlignment = .right
        
        return label
    }()
    
    private lazy var titleStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [dateLabel, dDayLabel])
        stackView.backgroundColor = .blue
        stackView.spacing = 0
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    // collectionView를 선언할 때 lazy를 사용하여 초기화
    lazy var collectionView: UICollectionView = {
        // UICollectionViewFlowLayout 설정
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 16, right: 16)
        
        // UICollectionView 초기화
        // collectionView를 뷰 컨트롤러 내에서 생성
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.dataSource = self
        collectionView.delegate = self
        
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for family in UIFont.familyNames {
            print("family: \(family)")
            for name in UIFont.fontNames(forFamilyName: family) {
                print("name: \(name)")
            }
        }
        
        view.backgroundColor = .yellow
        // 셀 등록
        collectionView.register(QuizCell.self, forCellWithReuseIdentifier: QuizCell.cellIdentifier)
        
        autoLayout()
    }
    
    func autoLayout() {
        view.addSubview(titleStackView) // date관련된 정보를 모은 UItitleStackView를 뷰에 추가
        view.addSubview(collectionView) // UICollectionView를 뷰에 추가
        
        
        // SnapKit을 사용하여 Auto Layout 설정
        titleStackView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(0) // 원하는 top 여백 설정
            make.leading.trailing.equalToSuperview().inset(16) // 좌우 여백 설정
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(titleStackView.snp.bottom).offset(0) // postStackView 바로 아래에 위치하도록 설정
            make.leading.trailing.bottom.equalToSuperview().inset(0) // 좌우, 아래 여백 설정
//            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        }
    }
    
    // UICollectionViewDataSource 메서드 구현
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.cellTypes.count // 셀 개수
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellType = viewModel.cellTypes[indexPath.row]
        let cellIdentifier = cellType.cellIdentifier
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath)
        
        // 각 셀에 대한 데이터 설정
        switch cellType {
        case .quiz:
            if let quizCell = cell as? QuizCell {
                quizCell.titleLabel.text = "Title \(indexPath.item + 1)"
                quizCell.questionLabel.text = "question title"
                quizCell.backgroundColor = colorArray[indexPath.item]
            }
//        case .csInfo:
            // CSInfoCell에 대한 설정...
//        case .swiftSyntax:
            // SwiftSyntaxCell에 대한 설정...
            // 추가적인 셀 유형들...
        }
        
        return cell
    }
    
    // UICollectionViewDelegateFlowLayout 메서드 구현
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // 셀의 크기 설정
        return CGSize(width: view.frame.width - 32, height: viewModel.cellHeightSize[indexPath.row])
    }
}
