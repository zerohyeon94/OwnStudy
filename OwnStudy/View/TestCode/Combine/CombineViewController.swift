//
//  CombineViewController.swift
//  OwnStudy
//
//  Created by 조영현 on 5/6/24.
//

import Foundation
import UIKit
import Combine

class CombineViewController: UIViewController {
    private let dataLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "데이터 연동이 완료되면 text color가 빨간색으로 변합니다."
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var cancellables = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("[CombineViewController] viewDidLoad")
        view.backgroundColor = .white
        
        // UI 추가
        view.addSubview(dataLabel)
        NSLayoutConstraint.activate([
            dataLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            dataLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        fetchData()
            .sink(receiveCompletion: { completion in
                // 네트워크 호출이 완료되면 호출됩니다.
                switch completion {
                case .finished:
                    print("Network request completed.")
                case .failure(let error):
                    print("Error: \(error)")
                }
            }, receiveValue: { [weak self] data in
                // 데이터를 받으면 UI에 표시합니다.
                print("data: \(data)")
                self?.dataLabel.textColor = .red
            })
            .store(in: &cancellables)
    }
    
    func fetchData() -> AnyPublisher<String, Error> {
            // 임시로 데이터를 반환합니다.
            return Just("Temporary data")
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
    
//    func fetchData() -> AnyPublisher<String, Error> {
//        // 비동기 네트워크 호출을 수행하는 함수를 호출하여 데이터를 가져옵니다.
//        // 이 함수는 Future를 사용하여 데이터를 가져오는 비동기 작업을 수행합니다.
//        return Future<String, Error> { promise in
//            // 네트워크 호출을 수행하고 결과를 반환합니다.
//            DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
//                promise(.success("Data fetched from the network"))
//            }
//        }.eraseToAnyPublisher()
//    }
}
