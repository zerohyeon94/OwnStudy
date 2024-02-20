//
//  TestCodeView.swift
//  OwnStudy
//
//  Created by 조영현 on 2/19/24.
//

import Foundation
import UIKit

protocol TestCodeViewDelegate: AnyObject {
    func bookmarkButtonTapped(index: Int)
    func cellSelected(index: Int)
}

// CS 정보 뷰
class TestCodeView: UIView {
    
    weak var delegate: TestCodeViewDelegate?
    var viewModel: TestCodeViewModel
    
    lazy var contentTableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .white
        tableView.register(TestCodeCell.self, forCellReuseIdentifier: TestCodeCell.cellIdentifier)

        return tableView
    }()
    
    init(testCodeViewModel: TestCodeViewModel) {
        print("testCodeViewModel: \(testCodeViewModel.testCodes.count)")
        self.viewModel = testCodeViewModel
        
        super.init(frame: .zero) // 상위 클래스의 초기화 메서드 호출
        
        setupUI() // UI 초기화
        contentTableView.reloadData() // 테이블 뷰 데이터 리로드
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setTableViewConstraints() {
        addSubview(contentTableView)
        contentTableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            contentTableView.topAnchor.constraint(equalTo: topAnchor),
            contentTableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentTableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentTableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func setupUI() {
        setTableViewConstraints()
    }
    
    func updateView(with viewModel: TestCodeViewModel) {
        print("viewModel: \(viewModel.testCodes.count)")
        // 뷰모델로부터 받은 데이터를 사용하여 UI 업데이트
        // 예를 들어, 오늘의 퀴즈 표시 여부에 따라 UI를 조절
        if viewModel.shouldDisplayTodayQuiz {
            // 오늘의 퀴즈 표시하는 UI 업데이트
        } else {
            // 오늘의 퀴즈를 표시하지 않는 UI 업데이트
            
        }
        
        // 즐겨찾기 문제와 전체 문제를 표시하는 UI 업데이트
        // 각각의 테이블뷰 또는 셀에 뷰모델의 데이터를 바인딩하여 표시
        
        contentTableView.reloadData()
    }
}

// MARK: - TableView DataSource
extension TestCodeView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.testCodes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TestCodeCell.cellIdentifier, for: indexPath) as! TestCodeCell
        let testCode = viewModel.testCodes[indexPath.row]
        print("testCodes[\(indexPath.row): \(testCode)]")
        
        // 선택된 상태일 때의 배경 뷰를 설정하여 선택 효과를 없앰 -> 우선 선택 효과 표시
//        let selectedView = UIView()
//        selectedView.backgroundColor = UIColor.clear
//        cell.selectedBackgroundView = selectedView

        cell.titleLabel.text = testCode.title
        
        // 즐겨찾기 여부 버튼
        cell.bookmarkButton.setTitle(testCode.isBookmarked ? "즐겨찾기 해제" : "즐겨찾기", for: .normal)
        cell.bookmarkButton.addTarget(self, action: #selector(bookmarkButtonTapped(_:)), for: .touchUpInside)
        cell.bookmarkButton.tag = indexPath.row // 버튼을 터치할 때 어떤 셀의 버튼이 눌렸는지 식별하기 위해 태그를 사용
        
        return cell
    }
}

// MARK: - TableView Delegate
extension TestCodeView: UITableViewDelegate {
    // cell Touch 효과
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 셀이 선택되었을 때 필요한 동작을 구현
        let index = indexPath.row
        let selectedCellType = viewModel.cellTypes[index]
        
        // 페이지로 이동하는 코드
        switch selectedCellType {
        case .delegate:
            print("delegate")
            delegate?.cellSelected(index: index)
            break
        case .kvo:
            print("kvo")
            delegate?.cellSelected(index: index)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50 // 각 셀의 기본 높이
    }

    
}

// MARK: - Action Handling
extension TestCodeView {
    @objc func bookmarkButtonTapped(_ sender: UIButton) {
        let index = sender.tag
        print("TestCodeView) \(index) Cell Click")
        
        delegate?.bookmarkButtonTapped(index: index)
    }
}
