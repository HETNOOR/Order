//
//  ReviewViewModel.swift
//  Order
//
//  Created by Максим Герасимов on 29.10.2024.
//

import UIKit

class ReviewViewModel {
    var product: Product
    var review: Review
    
    // Observable properties
    var ratingText: ((String) -> Void)?
    var photosUpdated: (() -> Void)?
    
    init(product: Product) {
        self.product = product
        self.review = Review()
    }
    
    func addPhoto(_ photo: UIImage) {
        guard review.photos.count < 7 else { return }
        review.photos.append(photo)
        photosUpdated?()
    }
    
    func removePhoto(at index: Int) {
        review.photos.remove(at: index)
        photosUpdated?()
    }
    
    func submitReview() {
        // Обработка отправки отзыва
    }
}
