//
//  Observer.swift
//  ObserverPatternPractice
//
//  Created by Swain Yun on 12/5/23.
//

import UIKit

protocol MessageObservable {
    // Publisher의 상태 추적, 감시
    func observe(message: String)
}

protocol MessageObserverProtocol: MessageObservable {
    // Publisher가 자신을 식별할 수 있도록 식별자 제공
    var identifier: UUID { get }
}


