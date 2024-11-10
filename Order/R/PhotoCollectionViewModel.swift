//
//  PhotoCollectionViewModel.swift
//  Order
//
//  Created by Максим Герасимов on 10.11.2024.
//

import UIKit

enum PhotoCollectionAction {
    case add
    case photo(image: UIImage)
}

class PhotoCollectionViewModel {
    var photos: [UIImage] = []
    var action: PhotoCollectionAction = .add
    var didChange: (() -> Void)?

    func addPhoto(_ image: UIImage) {
        if photos.count < 7 {
            photos.append(image)
            action = .photo(image: image)
            didChange?()
        }
    }

    func removePhoto(at index: Int) {
        guard photos.count > index else { return }
        photos.remove(at: index)
        if photos.isEmpty {
            action = .add
        }
        didChange?()
    }

    func getPhotoCount() -> Int {
        return photos.count
    }
}
