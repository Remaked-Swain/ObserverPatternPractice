//
//  MessageBox.swift
//  ObserverPatternPractice
//
//  Created by Swain Yun on 12/5/23.
//

import Foundation

final class MessageBox: MessagePublisherProtocol {
    // 옵저버 의존 목록 관리
    var observers: [MessageObserverProtocol] = []
    
    // UITextField에서 작성한 메세지 보관
    private var recentMessage: String? = nil {
        didSet {
            observers.forEach { observer in
                observer.observe(message: recentMessage ?? String())
            }
        }
    }
    
    // 옵저버 등록
    func addObserver(with observer: MessageObserverProtocol) {
        observers.append(observer)
    }
    
    // 옵저버 추가
    func removeObserver(with observer: MessageObserverProtocol) {
        observers = observers.filter { $0.identifier != observer.identifier }
    }
    
    // UITextField의 메세지 수신
    func updateMessage(to message: String) {
        recentMessage = message
    }
}

