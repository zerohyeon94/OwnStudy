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
class HomeViewController: UIViewController{
    
    let colorArray: [UIColor] = [.red, .blue, .green, .yellow, .orange, .purple]
    
    var viewModel: HomeViewModel = HomeViewModel()
    
    // dummyData
    let csDummyData: CSInfoViewModel = CSInfoViewModel(csInfoModel: CSInfoModel(
        todayQuiz: CSQuiz(title: "오늘의 퀴즈 있음.",isBookmarked: true),
        quizzes: [CSQuiz(title: "문제 1", isBookmarked: true),
                     CSQuiz(title: "문제 2", isBookmarked: true),
                     CSQuiz(title: "문제 3", isBookmarked: true),
                     CSQuiz(title: "문제 4", isBookmarked: false),
                     CSQuiz(title: "문제 5", isBookmarked: false)]))
    let testDummyData: TestCodeViewModel = TestCodeViewModel(testCodeModel: TestCodeModel(
        todayQuiz: TestCode(title: "오늘의 퀴즈 있음", isBookmarked: true),
        testCodes: [TestCode(title: "Delegate 패턴", isBookmarked: true),
                    TestCode(title: "KVO", isBookmarked: true)]))
    
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
        stackView.backgroundColor = .white
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
    
    override func viewWillAppear(_ animated: Bool) {
        // NavigationBar 숨김.
        //        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .yellow
        // 셀 등록
        collectionView.register(HomeQuizCell.self, forCellWithReuseIdentifier: HomeQuizCell.cellIdentifier)
        collectionView.register(HomeCSInfoCell.self, forCellWithReuseIdentifier: HomeCSInfoCell.cellIdentifier)
        collectionView.register(HomeTestCodeCell.self, forCellWithReuseIdentifier: HomeTestCodeCell.cellIdentifier)
        
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
            make.top.equalTo(titleStackView.snp.bottom).offset(10) // postStackView 바로 아래에 위치하도록 설정
            make.leading.trailing.bottom.equalToSuperview().inset(0) // 좌우, 아래 여백 설정
            //            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        }
    }
}

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    // UICollectionViewDataSource 메서드 구현
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.cellTypes.count // 셀 개수
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellType = viewModel.cellTypes[indexPath.row]
        let cellIdentifier = cellType.cellIdentifier
        print("cellType: \(cellType), cellIdentifier: \(cellIdentifier)")
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath)
        
        // 각 셀에 대한 데이터 설정
        switch cellType {
        case .quiz:
            if let quizCell = cell as? HomeQuizCell {
                quizCell.titleLabel.text = "Title \(indexPath.item + 1)"
                quizCell.questionLabel.text = "question title"
                quizCell.backgroundColor = colorArray[indexPath.item]
            }
        case .csInfo:
            if let csInfoCell = cell as? HomeCSInfoCell {
                csInfoCell.titleLabel.text = "Title \(indexPath.item + 1)"
                // 문제 수와 즐겨찾기 수를 확인한 후 그 값을 저장. - 해당 함수는 ViewModel에 구현 예정
                let bookmarkedQuizzes =  csDummyData.quizzes.filter { $0.isBookmarked == true }
                csInfoCell.setCount(questionCount: csDummyData.quizzes.count, bookmarkedCount: bookmarkedQuizzes.count)
                csInfoCell.backgroundColor = colorArray[indexPath.item]
            }
        case .testCode:
            if let testCodeCell = cell as? HomeTestCodeCell {
                testCodeCell.titleLabel.text = "Title \(indexPath.item + 1)"
                // 문제 수와 즐겨찾기 수를 확인한 후 그 값을 저장. - 해당 함수는 ViewModel에 구현 예정
                testCodeCell.setCount(codeTestCount: 1, bookmarkedCount: 1)
                testCodeCell.backgroundColor = colorArray[indexPath.item]
            }
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
    
    // UICollectionViewDelegate 메서드 중 didSelectItemAt을 구현
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // 선택한 셀에 대한 처리
        let selectedCellType = viewModel.cellTypes[indexPath.row]
        
        // 페이지로 이동하는 코드
        switch selectedCellType {
        case .quiz:
            print("quiz")
            // 선택한 셀이 Quiz 타입인 경우에 대한 처리
            // 예를 들어, 새로운 뷰 컨트롤러를 생성하고 필요한 데이터를 전달한 후 푸시
            //            let quizDetailViewController = QuizDetailViewController() // 예시 뷰 컨트롤러
            //            navigationController?.pushViewController(quizDetailViewController, animated: true)
            break
        case .csInfo:
            print("csInfo")
            // HomeViewController에서 CSInfo의 데이터를 가지고 오고, 해당 데이터를 넘겨주는게 좋음.
            let csInfoViewController = CSInfoViewController(csInfoViewModel: csDummyData) // 예시 뷰 컨트롤러
            navigationController?.pushViewController(csInfoViewController, animated: true)
        case .testCode:
            print("testCode")
            let testCodeViewController = TestCodeViewController(testCodeViewModel: testDummyData)
            navigationController?.pushViewController(testCodeViewController, animated: true)
//            let firstViewController = FirstViewController()
//            navigationController?.pushViewController(firstViewController, animated: true)
        }
    }
}
