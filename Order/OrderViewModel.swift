//
//  OrderViewModel.swift
//  Order
//
//  Created by Максим Герасимов on 18.10.2024.
//

import Foundation

class OrderViewModel {

    var order: Order
    
    // Error message if any validation fails
    var errorMessage: String?

    init(order: Order) {
        self.order = order
    }
    
    // Validate data before showing order
    func validateOrder() -> Bool {
        // Check if there are any products in the order
        if order.products.isEmpty {
            errorMessage = "Нет продуктов в заказе"
            return false
        }
        
        // Ensure each product has a price greater than 0
        for product in order.products {
            if product.price <= 0 {
                errorMessage = "У продукта стоимость должна быть больше 0"
                return false
            }
        }

        // Calculate discounts
        let totalProductPrice = order.products.reduce(0) { $0 + $1.price }
        let totalDiscount = (order.baseDiscount ?? 0) + (order.paymentDiscount ?? 0)
        
        // Ensure total discount isn't more than the total price
        if totalDiscount > totalProductPrice {
            errorMessage = "Сумма текущей скидки не может быть больше суммы заказа"
            return false
        }

        // Check if 2 active promo codes do not exceed product price
        let activePromocodes = order.promocodes.filter { $0.active }
        if activePromocodes.count > 1 {
            errorMessage = "Нельзя применять больше 2 промокодов"
            return false
        }
        
        let promocodeDiscount = activePromocodes.reduce(0) { $0 + (totalProductPrice * Double($1.percent) / 100) }
        
        if promocodeDiscount > totalProductPrice {
            errorMessage = "Сумма скидки не может быть больше суммы заказа"
            return false
        }

        return true
    }

    // Calculate final order price
    func calculateFinalPrice() -> Double {
        let totalProductPrice = order.products.reduce(0) { $0 + $1.price }
        let totalDiscount = (order.baseDiscount ?? 0) + (order.paymentDiscount ?? 0)
        let activePromocodes = order.promocodes.filter { $0.active }
        let promocodeDiscount = activePromocodes.reduce(0) { $0 + (totalProductPrice * Double($1.percent) / 100) }

        return totalProductPrice - totalDiscount - promocodeDiscount
    }
    func updatePromocodeActiveState(index: Int, isActive: Bool) {
        // Устанавливаем состояние активности для текущего промокода
        order.promocodes[index].active = isActive
        let activePromocodes = order.promocodes.filter { $0.active }

        if isActive {
            // Если новый промокод активируется и уже есть активные
            if activePromocodes.count > 1 {
                // Отключаем первый активный промокод, который не является текущим
                if let firstActiveIndex = order.promocodes.firstIndex(where: { $0.active && $0 != order.promocodes[index] }) {
                    order.promocodes[firstActiveIndex].active = false
                }
            }
        } else {
            // Если текущий промокод деактивируется
            //            if let previousPromocode = order.promocodes[index] as? Order, !previousPromocode.active {
            //                order.promocodes[index].active = true
        
        }
    }


}

