//
//  RootViewController.swift
//  ObserverPatternPractice
//
//  Created by Swain Yun on 12/5/23.
//

import UIKit

final class RootViewController: UIViewController {
    // MARK: Constants
    enum Constants {
        static let defaultStackViewSpacing: CGFloat = 20
        static let messageTextFieldPlaceholder: String = "보낼 메세지를 입력하세요."
        static let initialObserverLabelText: String = "구독자: ?"
    }
    
    enum ButtonType {
        case add, remove
        
        var title: String {
            switch self {
            case .add: "구독자 추가"
            case .remove: "구독자 제거"
            }
        }
    }
    
    // MARK: View Components
    private lazy var messageTextField: UITextField = {
        let textField = UITextField()
        textField.addTarget(self, action: #selector(textFieldMessageDidChange), for: .editingChanged)
        textField.placeholder = Constants.messageTextFieldPlaceholder
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var buttonsStackView: UIStackView = {
        let stackView = UIStackView(axis: .horizontal, distribution: .fillEqually, spacing: Constants.defaultStackViewSpacing)
        return stackView
    }()
    
    private lazy var addLabelButton: UIButton = {
        let button = UIButton(title: ButtonType.add.title, titleColor: .systemBlue)
        button.addTarget(self, action: #selector(addLabel), for: .touchUpInside)
        return button
    }()
    
    private lazy var removeLabelButton: UIButton = {
        let button = UIButton(title: ButtonType.remove.title, titleColor: .systemRed)
        button.addTarget(self, action: #selector(removeLabel), for: .touchUpInside)
        return button
    }()
    
    private lazy var labelsScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var labelsStackView: UIStackView = {
        let stackView = UIStackView(axis: .vertical, spacing: Constants.defaultStackViewSpacing)
        return stackView
    }()
    
    // MARK: Dependency
    private let messageBox: MessagePublisherProtocol = MessageBox()
    
    // MARK: Public
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        makeLayout()
        makeConstraints()
    }
}

// MARK: Layout Configuring Methods
extension RootViewController {
    private func makeLayout() {
        self.view.addSubviews([messageTextField, labelsScrollView, buttonsStackView])
        labelsScrollView.addSubview(labelsStackView)
        buttonsStackView.addArrangedSubviews([addLabelButton, removeLabelButton])
    }
    
    private func makeConstraints() {
        NSLayoutConstraint.activate([
            messageTextField.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: Constants.defaultStackViewSpacing * 2),
            messageTextField.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: Constants.defaultStackViewSpacing),
            messageTextField.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: Constants.defaultStackViewSpacing),
        ])
        
        NSLayoutConstraint.activate([
            labelsScrollView.topAnchor.constraint(equalTo: messageTextField.bottomAnchor, constant: Constants.defaultStackViewSpacing),
            labelsScrollView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: Constants.defaultStackViewSpacing),
            labelsScrollView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -Constants.defaultStackViewSpacing),
        ])
        
        NSLayoutConstraint.activate([
            labelsStackView.topAnchor.constraint(equalTo: labelsScrollView.contentLayoutGuide.topAnchor),
            labelsStackView.bottomAnchor.constraint(equalTo: labelsScrollView.contentLayoutGuide.bottomAnchor),
            labelsStackView.leadingAnchor.constraint(equalTo: labelsScrollView.contentLayoutGuide.leadingAnchor),
            labelsStackView.trailingAnchor.constraint(equalTo: labelsScrollView.contentLayoutGuide.trailingAnchor),
            labelsStackView.widthAnchor.constraint(equalTo: labelsScrollView.frameLayoutGuide.widthAnchor)
        ])
        
        NSLayoutConstraint.activate([
            buttonsStackView.topAnchor.constraint(equalTo: labelsScrollView.bottomAnchor, constant: Constants.defaultStackViewSpacing),
            buttonsStackView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -Constants.defaultStackViewSpacing * 2),
            buttonsStackView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            buttonsStackView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
}

// MARK: Action Methods
extension RootViewController {
    @objc private func textFieldMessageDidChange() {
        if let newMessage = messageTextField.text {
            messageBox.updateMessage(to: newMessage)
        }
    }
    
    @objc private func addLabel() {
        let uuid = UUID()
        let label = CustomLabel(identifier: uuid)
        label.text = Constants.initialObserverLabelText
        labelsStackView.addArrangedSubview(label)
        messageBox.addObserver(with: label)
    }
    
    @objc private func removeLabel() {
        if let label = labelsStackView.arrangedSubviews.last as? CustomLabel {
            labelsStackView.removeArrangedSubview(label)
            label.removeFromSuperview()
            messageBox.removeObserver(with: label)
        }
    }
}
