//
//  PhotoCollectionCell.swift
//  Order
//
//  Created by Максим Герасимов on 29.10.2024.
//

import UIKit

class PhotoCollectionCell: UITableViewCell {
    
    private let containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 12
        view.layer.masksToBounds = true
        view.backgroundColor = UIColor(white: 0.95, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let shapeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Shape")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Добавьте фото или видео"
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Нажмите, чтобы выбрать файлы"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(containerView)
        containerView.addSubview(shapeImageView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(subtitleLabel)
        
        NSLayoutConstraint.activate([
            // Настройка containerView с отступами
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            containerView.heightAnchor.constraint(equalToConstant: 80),
            
            // Позиционирование shapeImageView
            shapeImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            shapeImageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            shapeImageView.widthAnchor.constraint(equalToConstant: 24),
            shapeImageView.heightAnchor.constraint(equalToConstant: 24),
            
            // Позиционирование titleLabel и subtitleLabel
            titleLabel.leadingAnchor.constraint(equalTo: shapeImageView.trailingAnchor, constant: 16),
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 21),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            
            subtitleLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            subtitleLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor)
        ])
    }
    
    
}
