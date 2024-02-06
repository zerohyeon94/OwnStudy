//
//  CSInfoView.swift
//  OwnStudy
//
//  Created by 조영현 on 2/6/24.
//

import Foundation
import UIKit

// CS 정보 뷰
class CSInfoView: UIView {
    // UI 요소들을 정의하고 초기화하는 코드 추가
    
    var csInfotableView = UITableView()
    var allQuizzes: [CSQuiz] = []
    var bookmarkedQuizzes: [CSQuiz] = []
    
    init(csInfoViewModel: CSInfoViewModel) {
        print("csInfoViewModel: \(csInfoViewModel.allQuizzes.count)")
        self.allQuizzes = csInfoViewModel.allQuizzes
        self.bookmarkedQuizzes = csInfoViewModel.bookmarkedQuizzes
        
        super.init(frame: .zero) // 상위 클래스의 초기화 메서드 호출
        setupUI() // UI 초기화
        csInfotableView.reloadData() // 테이블 뷰 데이터 리로드
    }
    
    //    override init(frame: CGRect) {
    //        super.init(frame: frame)
    //        setupUI()
    //    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
    func setupTableView(){
        print("setupTableView 실행")
        print("count: \(bookmarkedQuizzes.count)")
        csInfotableView.separatorStyle = .none // Cell 사이 줄 제거
        let petInfoCellHeight: CGFloat = 150 // Cell의 여유분의 높이 10을 줌.
        csInfotableView.rowHeight = petInfoCellHeight
        csInfotableView.register(CSInfoCell.self, forCellReuseIdentifier: CSInfoCell.cellIdentifier)
        
        csInfotableView.dataSource = self
    }
    
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
        setupTableView()
        setTableViewConstraints()
    }
    
    func updateView(with viewModel: CSInfoViewModel) {
        print("viewModel: \(viewModel.allQuizzes.count)")
        // 뷰모델로부터 받은 데이터를 사용하여 UI 업데이트
        // 예를 들어, 오늘의 퀴즈 표시 여부에 따라 UI를 조절
        if viewModel.shouldDisplayTodayQuiz {
            // 오늘의 퀴즈 표시하는 UI 업데이트
        } else {
            // 오늘의 퀴즈를 표시하지 않는 UI 업데이트
            
        }
        
        // 즐겨찾기 문제와 전체 문제를 표시하는 UI 업데이트
        // 각각의 테이블뷰 또는 셀에 뷰모델의 데이터를 바인딩하여 표시
        
        bookmarkedQuizzes = viewModel.bookmarkedQuizzes
        csInfotableView.reloadData()
    }
}

// MARK: - TableView DataSource
extension CSInfoView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allQuizzes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CSInfoCell.cellIdentifier, for: indexPath) as! CSInfoCell
        let quiz = allQuizzes[indexPath.row]
        
        cell.numberLabel.text = "문제 \(indexPath.row + 1)"
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 셀이 선택되었을 때 필요한 동작을 구현
    }
}

// MARK: - Action Handling
extension CSInfoView {
    @objc func bookmarkButtonTapped(_ sender: UIButton) {
        print("눌렀다!")
        print("index: \(sender.tag)")
        let index = sender.tag
        // 해당 문제에 대한 즐겨찾기 여부를 토글
        bookmarkedQuizzes[index].isBookmarked.toggle()
        // 버튼을 다시 그리기 위해 해당 셀을 다시 로드
        csInfotableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
    }
}
