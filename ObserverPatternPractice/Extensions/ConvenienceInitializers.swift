//
//  ConvenienceInitializers.swift
//  ObserverPatternPractice
//
//  Created by Swain Yun on 12/5/23.
//

import UIKit

extension UIView {
    func addSubviews(_ views: [UIView]) {
        views.forEach {
            self.addSubview($0)
        }
    }
}

extension UIStackView {
    convenience init(axis: NSLayoutConstraint.Axis, alignment: UIStackView.Alignment = .fill, distribution: UIStackView.Distribution = .fill, spacing: CGFloat) {
        self.init()
        
        self.axis = axis
        self.alignment = alignment
        self.distribution = distribution
        self.spacing = spacing
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func addArrangedSubviews(_ views: [UIView]) {
        views.forEach {
            self.addArrangedSubview($0)
        }
    }
    
    func removeArrangedSubviews(_ views: [UIView]) {
        views.forEach {
            self.removeArrangedSubview($0)
            $0.removeFromSuperview()
        }
    }
}

extension UIButton {
    convenience init(type: ButtonType = .system, title: String, titleColor: UIColor = .systemBlue) {
        self.init(type: type)
        
        self.setTitle(title, for: .normal)
        self.setTitleColor(titleColor, for: .normal)
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}

extension CustomLabel {
    convenience init(identifier: UUID, text: String = "Label", font: UIFont, textColor: UIColor = .label, backgroundColor: UIColor = .clear, textAlignment: NSTextAlignment = .center) {
        self.init(identifier: identifier)
        
        self.text = text
        self.font = font
        self.textColor = textColor
        self.backgroundColor = backgroundColor
        self.textAlignment = textAlignment
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
