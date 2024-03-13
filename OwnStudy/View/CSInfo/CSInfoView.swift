//
//  CSInfoView.swift
//  OwnStudy
//
//  Created by 조영현 on 2/6/24.
//

import Foundation
import UIKit

protocol CSInfoViewDelegate: AnyObject {
    func bookmarkButtonTapped(index: Int)
}

// CS 정보 뷰
class CSInfoView: UIView {
    
    weak var delegate: CSInfoViewDelegate?
    var csInfoViewModel: CSInfoViewModel
    
    lazy var csInfotableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        
//        tableView.separatorStyle = .none // Cell 사이 줄 제거
        tableView.backgroundColor = .white
        
//        let petInfoCellHeight: CGFloat = 50
//        tableView.rowHeight = petInfoCellHeight // 모든 Cell의 높이를 동일하게 할 경우에 해당 속성을 설정.
        tableView.register(CSInfoCell.self, forCellReuseIdentifier: CSInfoCell.cellIdentifier)

        return tableView
    }()
    
    init(csInfoViewModel: CSInfoViewModel) {
        print("csInfoViewModel: \(csInfoViewModel.quizzes.count)")
        self.csInfoViewModel = csInfoViewModel
        
        super.init(frame: .zero) // 상위 클래스의 초기화 메서드 호출
        setupUI() // UI 초기화
        csInfotableView.reloadData() // 테이블 뷰 데이터 리로드
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //    override init(frame: CGRect) {
    //        super.init(frame: frame)
    //        setupUI()
    //    }
    
    func setTableViewConstraints() {
        addSubview(csInfotableView)
        csInfotableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            csInfotableView.topAnchor.constraint(equalTo: topAnchor),
            csInfotableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            csInfotableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            csInfotableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func setupUI() {
        setTableViewConstraints()
    }
    
    func updateView(with viewModel: CSInfoViewModel) {
        print("viewModel: \(viewModel.quizzes.count)")
        // 뷰모델로부터 받은 데이터를 사용하여 UI 업데이트
        // 예를 들어, 오늘의 퀴즈 표시 여부에 따라 UI를 조절
        if viewModel.shouldDisplayTodayQuiz {
            // 오늘의 퀴즈 표시하는 UI 업데이트
        } else {
            // 오늘의 퀴즈를 표시하지 않는 UI 업데이트
            
        }
        
        // 즐겨찾기 문제와 전체 문제를 표시하는 UI 업데이트
        // 각각의 테이블뷰 또는 셀에 뷰모델의 데이터를 바인딩하여 표시
        
        csInfotableView.reloadData()
    }
}

// MARK: - TableView DataSource
extension CSInfoView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return csInfoViewModel.quizzes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CSInfoCell.cellIdentifier, for: indexPath) as! CSInfoCell
        let quiz = csInfoViewModel.quizzes[indexPath.row]
        print("quizzes[\(indexPath.row): \(quiz)]")
        
        // 선택된 상태일 때의 배경 뷰를 설정하여 선택 효과를 없앰 -> 우선 선택 효과 표시
//        let selectedView = UIView()
//        selectedView.backgroundColor = UIColor.clear
//        cell.selectedBackgroundView = selectedView

        cell.titleLabel.text = quiz.title
        
        // 즐겨찾기 여부 버튼
        cell.bookmarkButton.setTitle(quiz.isBookmarked ? "즐겨찾기 해제" : "즐겨찾기", for: .normal)
        cell.bookmarkButton.addTarget(self, action: #selector(bookmarkButtonTapped(_:)), for: .touchUpInside)
        cell.bookmarkButton.tag = indexPath.row // 버튼을 터치할 때 어떤 셀의 버튼이 눌렸는지 식별하기 위해 태그를 사용
        
        return cell
    }
}

// MARK: - TableView Delegate
extension CSInfoView: UITableViewDelegate {
    // cell Touch 효과
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 셀이 선택되었을 때 필요한 동작을 구현
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50 // 각 셀의 기본 높이
    }

    
}

// MARK: - Action Handling
extension CSInfoView {
    @objc func bookmarkButtonTapped(_ sender: UIButton) {
        let index = sender.tag
        print("CSInfoView) \(index) Cell Click")
        
        delegate?.bookmarkButtonTapped(index: index)
    }
}
