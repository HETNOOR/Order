//
//  Order.swift
//  Order
//
//  Created by Максим Герасимов on 18.10.2024.
//

import Foundation

struct Order {

    struct Promocode: Equatable {
        let title: String
        let percent: Int
        let endDate: Date?
        let info: String?
        var active: Bool
        
        static func ==(lhs: Promocode, rhs: Promocode) -> Bool {
                return lhs.title == rhs.title && lhs.active == rhs.active
            }
    }

    struct Product {
        let price: Double
        let title: String
    }

    var screenTitle: String
    var promocodes: [Promocode]
    var products: [Product]
    var paymentDiscount: Double?
    var baseDiscount: Double?
}

