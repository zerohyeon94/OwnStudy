//
//  HomeViewController.swift
//  OwnStudy
//
//  Created by 조영현 on 1/8/24.
//

import Foundation
import UIKit

// ViewModel과 상호작용하여 화면을 구성하는 곳.
class HomeViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    let colorArray: [UIColor] = [.red, .blue, .green, .yellow, .orange, .purple]
    
    private let cellIdentifier = "CustomCell"
    private var collectionView: UICollectionView!
    var viewModel: HomeViewModel = HomeViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // UICollectionViewFlowLayout 설정
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)

        // UICollectionView 초기화
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.dataSource = self
        collectionView.delegate = self

        // 셀 등록
        collectionView.register(CustomCell.self, forCellWithReuseIdentifier: cellIdentifier)
        
        autoLayout()
    }
    
    func autoLayout() {
        // UICollectionView를 뷰에 추가
        view.addSubview(collectionView)
    }

    // UICollectionViewDataSource 메서드 구현
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6 // 셀 개수
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! CustomCell
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

class CustomCell: UICollectionViewCell {
    var titleLabel: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)

        // 셀 내부의 UI 요소들 초기화
        titleLabel = UILabel(frame: contentView.bounds)
        titleLabel.textAlignment = .center
        titleLabel.textColor = .black

        // 셀에 UI 요소 추가
        contentView.addSubview(titleLabel)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
