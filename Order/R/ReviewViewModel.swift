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
    
    var onPhotosUpdated: (() -> Void)?
    
    // Массив доступных изображений
    private var availableImages: [UIImage] = [
        UIImage(named: "image1")!,
        UIImage(named: "image2")!,
        UIImage(named: "image3")!,
        UIImage(named: "image4")!,
        UIImage(named: "image5")!,
        UIImage(named: "image6")!,
        UIImage(named: "image7")!
    ]

    // Массив с добавленными изображениями
    var addedPhotos: [UIImage] {
        return review.photos
    }

    init(product: Product) {
        self.product = product
        self.review = Review()
    }
    
    func addPhoto() {
        guard !availableImages.isEmpty else {
            print("No more available images to add.")
            return
        }

      
        let nextImage = availableImages.removeFirst()
        review.photos.append(nextImage)
        print("Photo added. Total photos:", review.photos.count)
    }
    
    func deletePhoto(at index: Int) {
        if index >= 0 && index < review.photos.count {
            let removedPhoto = review.photos.remove(at: index)
            

            availableImages.insert(removedPhoto, at: 0)
            print("Photo deleted. Total photos:", review.photos.count)
            onPhotosUpdated?()
        }
    }
    
    func submitReview() {
        // Обработка отправки отзыва
    }
}

