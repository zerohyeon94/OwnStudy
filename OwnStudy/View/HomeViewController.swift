//
//  HomeViewController.swift
//  OwnStudy
//
//  Created by 조영현 on 1/8/24.
//

import Foundation
import UIKit

// ViewModel과 상호작용하여 화면을 구성하는 곳.

class HomeViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var collectionView: UICollectionView!

    var viewModel: HomeViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // ViewModel 초기화
        viewModel = HomeViewModel()

        // UICollectionView 설정
        collectionView.dataSource = self
        collectionView.delegate = self

        // 셀 등록...
    }

    // UICollectionViewDataSource, UICollectionViewDelegate 메서드 구현...
}

