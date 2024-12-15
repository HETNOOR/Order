//
//  OrderCancellationViewModel.swift
//  Order
//
//  Created by Максим Герасимов on 14.12.2024.
//

import Foundation
import Combine

final class OrderCancellationViewModel: ObservableObject {
    
    @Published var data: [OrderCancellationListModel] = [
        .init(type: .checkRow("Не подходит дата получения")),
        .init(type: .checkRow("Часть товаров из заказа была отменена")),
        .init(type: .checkRow("Не получилось применить скидку")),
        .init(type: .checkRow("Хочу изменить заказ и оформить заново")),
        .init(type: .checkRow("Нашелся товар дешевле")),
        .init(type: .checkRow("Другое", true)),
        .init(type: .screenDescription("Обычно деньги сразу возвращаются на карту. В некоторых случаях это может занять до 3 рабочих дней.")),
        .init(type: .cancelButton("Отменить заказ"))
    ]
    
    func cancelOrder() {
        
    }
    
    func showErrorCell() {
        if data.contains(where: { value in
            if value.type.caseType == OrderCancellationListModel.Types.error().caseType {
                return true
            }
            return false
        }) {
            return
        } else {
            data.insert(.init(type: .error("Пожалуйста, выберите причину")), at: 0)
        }
    }
    
    func hideErrorCell() {
        data.removeAll { value in
            if value.type.caseType == OrderCancellationListModel.Types.error().caseType {
                return true
            }
            return false
        }
    }
    
    func prepareProblemDescription(isOther: Bool) {
        if isOther {
            if data.contains(where: { value in
                if value.type.caseType == OrderCancellationListModel.Types.problemDescriptionTextField("").caseType {
                    return true
                }
                return false
            }) {
                return
            } else {
                data.insert(.init(type: .problemDescriptionTextField("Опишите проблему")), at: data.count - 2)
            }
        } else {
            data.removeAll { value in
                if value.type.caseType == OrderCancellationListModel.Types.problemDescriptionTextField("").caseType {
                    return true
                }
                return false
            }
        }
    }
}
