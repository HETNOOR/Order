//
//  AddPhotoCell.swift
//  Order
//
//  Created by Максим Герасимов on 02.11.2024.
//

import UIKit

class AddPhotoCell: UICollectionViewCell {

    static let identifier = "AddPhotoCell"

    let addButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.tintColor = .gray
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 8
        button.clipsToBounds = true
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(addButton)
        
        addButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            addButton.topAnchor.constraint(equalTo: contentView.topAnchor),
            addButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            addButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            addButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
