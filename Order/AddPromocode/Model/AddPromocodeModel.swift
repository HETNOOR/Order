//
//  ActivePromocodeModel.swift
//  EltexOrderProject
//
//  Created by Максим Герасимов on 27.10.2024.
//

import Foundation

struct AddPromocodeModel {
    var type: ActivePromocodeViewModelType
    
    enum ActivePromocodeViewModelType {
        
        struct ActivePromocodeView {
            let buttonText: String
            let textFieldShouldBeginEditing: (() -> Void)?
            let activeButtonClicked: ((String?) -> Void)?
        }
        
        struct PromocodeTextField {
            let textFieldTitle: String
            let clearButtonClicked: (() -> Void)?
        }
        
        case view(ActivePromocodeView)
        case textField(PromocodeTextField)
    }
}
