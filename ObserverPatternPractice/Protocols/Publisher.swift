//
//  Publisher.swift
//  ObserverPatternPractice
//
//  Created by Swain Yun on 12/5/23.
//

import Foundation

protocol MessageUpdatable {
    // 고유의 상태 저장
    func updateMessage(to message: String)
}

protocol ObserverAddable {
    // 옵저버 등록
    func addObserver(with observer: MessageObserverProtocol)
}

protocol ObserverRemovable {
    // 옵저버 제거
    func removeObserver(with observer: MessageObserverProtocol)
}

protocol MessagePublisherProtocol: ObserverAddable, ObserverRemovable, MessageUpdatable {
    // 옵저버 의존 목록 관리
    var observers: [MessageObserverProtocol] { get }
}







