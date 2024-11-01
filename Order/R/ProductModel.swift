//
//  ProductModel.swift
//  Order
//
//  Created by Максим Герасимов on 29.10.2024.
//

import SwiftUI

struct Product {
    let id: UUID
    let name: String
    let image: UIImage
    let size: Int
}

struct Review {
    var rating: Int = 0
    var pros: String = ""
    var cons: String = ""
    var comment: String = ""
    var photos: [UIImage] = []
    var isAnonymous: Bool = false
}
