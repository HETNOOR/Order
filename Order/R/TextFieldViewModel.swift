//
//  TextFieldViewModel.swift
//  Order
//
//  Created by Максим Герасимов on 10.11.2024.
//

import UIKit

enum TextFieldAction {
    case next
    case done
}

class TextFieldViewModel {
    var text: String
    var placeholder: String
    var returnKeyType: UIReturnKeyType
    var action: TextFieldAction
    var didChangeText: ((String) -> Void)?
    var nextResponderAction: (() -> Void)?

    init(placeholder: String, text: String = "", returnKeyType: UIReturnKeyType = .next, action: TextFieldAction = .next, didChangeText: @escaping (String) -> Void, nextResponderAction: (() -> Void)? = nil) {
        self.placeholder = placeholder
        self.text = text
        self.returnKeyType = returnKeyType
        self.action = action
        self.didChangeText = didChangeText
        self.nextResponderAction = nextResponderAction
    }

    func textDidChange(_ text: String) {
        self.text = text
        didChangeText?(text)
    }

    func didReturnKeyPressed() {
        switch action {
        case .next:
            nextResponderAction?()
        case .done:
            // Закрываем клавиатуру
            NotificationCenter.default.post(name: UIResponder.keyboardWillHideNotification, object: nil)
        }
    }
}
