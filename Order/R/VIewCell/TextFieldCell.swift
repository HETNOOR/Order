//
//  TextFieldCell.swift
//  Order
//
//  Created by Максим Герасимов on 29.10.2024.
//

import UIKit

class TextFieldCell: UITableViewCell, UITextFieldDelegate {
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.95, alpha: 1)
        view.layer.cornerRadius = 12
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let textField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .none
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private var onTextChanged: ((String) -> Void)?
    private var nextResponderAction: (() -> Void)?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        textField.addTarget(self, action: #selector(textChanged), for: .editingChanged)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.backgroundColor = .clear
        contentView.addSubview(containerView)
        containerView.addSubview(textField)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            containerView.heightAnchor.constraint(equalToConstant: 56)
        ])
        
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: containerView.topAnchor),
            textField.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            textField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 12),
            textField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12)
        ])
    }
    
    func configure(placeholder: String, text: String, returnKeyType: UIReturnKeyType, onTextChanged: @escaping (String) -> Void, nextResponderAction: (() -> Void)? = nil) {
        textField.placeholder = placeholder
        textField.text = text
        textField.returnKeyType = returnKeyType
        textField.delegate = self
        self.onTextChanged = onTextChanged
        self.nextResponderAction = nextResponderAction
    }
    
    @objc private func textChanged() {
        onTextChanged?(textField.text ?? "")
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let nextAction = nextResponderAction {
            nextAction()
        } else {
            textField.resignFirstResponder()
        }
        return true
    }
}
