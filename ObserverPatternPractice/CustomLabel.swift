//
//  CustomLabel.swift
//  ObserverPatternPractice
//
//  Created by Swain Yun on 12/5/23.
//

import UIKit

final class CustomLabel: UILabel, MessageObserverProtocol {
    let identifier: UUID
    
    init(identifier: UUID) {
        self.identifier = identifier
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("사람살려")
    }
    
    deinit {
        print("Label #\(identifier) Deinitialized")
    }
    
    // MessageBox의 최신 메세지로 업데이트
    func observe(message: String) {
        self.text = "구독자: \(message)"
    }
}


