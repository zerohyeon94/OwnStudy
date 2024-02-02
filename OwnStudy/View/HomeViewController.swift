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
    
    // collectionView를 선언할 때 lazy를 사용하여 초기화
    lazy var collectionView: UICollectionView = {
        // UICollectionViewFlowLayout 설정
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        
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
        view.backgroundColor = .yellow
        // 셀 등록
        collectionView.register(QuizCell.self, forCellWithReuseIdentifier: QuizCell.cellIdentifier)
        
        autoLayout()
    }
    
    func autoLayout() {
        // UICollectionView를 뷰에 추가
        view.addSubview(collectionView)
        
        // SnapKit을 사용하여 Auto Layout 설정
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        }
    }
    
    // UICollectionViewDataSource 메서드 구현
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.cellType.count // 셀 개수
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: QuizCell.cellIdentifier, for: indexPath) as! QuizCell
        // 각 셀에 대한 데이터 설정
        cell.titleLabel.text = "Title \(indexPath.item + 1)"
        cell.backgroundColor = colorArray[indexPath.item]
        return cell
    }
    
    // UICollectionViewDelegateFlowLayout 메서드 구현
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // 셀의 크기 설정
        return CGSize(width: view.frame.width - 32, height: viewModel.cellHeightSize[indexPath.row])
    }
}
