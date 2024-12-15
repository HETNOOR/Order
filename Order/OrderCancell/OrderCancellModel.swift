//
//  OrderCancellModel.swift
//  Order
//
//  Created by Максим Герасимов on 14.12.2024.
//

import Foundation

struct OrderCancellationListModel: Identifiable {
    var type: Types
    var id = UUID()
    
    enum Types: Equatable {
        case error(String = "error")
        case checkRow(String, Bool = false)
        case problemDescriptionTextField(String)
        case screenDescription(String)
        case cancelButton(String)
        
        var caseType: String {
            switch self {
            case .error: return "error"
            case .checkRow: return "checkRow"
            case .problemDescriptionTextField: return "problemDescriptionTextField"
            case .screenDescription: return "screenDescription"
            case .cancelButton: return "cancelButton"
            }
        }
    }
}
