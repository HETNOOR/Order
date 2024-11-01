//
//  ProductCell.swift
//  Order
//
//  Created by Максим Герасимов on 01.11.2024.
//

import UIKit

class ProductCell: UITableViewCell {
    
    
    let productNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    let sizeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    private func setupViews() {
        contentView.addSubview(productImageView)
        contentView.addSubview(productNameLabel)
        contentView.addSubview(sizeLabel)
        
        // Set up constraints
        NSLayoutConstraint.activate([
            productImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            productImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            productImageView.widthAnchor.constraint(equalToConstant: 80),
            productImageView.heightAnchor.constraint(equalToConstant: 80),
            
            productNameLabel.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 12),
            productNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -40),
            productNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 9),
            
            sizeLabel.leadingAnchor.constraint(equalTo: productNameLabel.leadingAnchor),
            sizeLabel.trailingAnchor.constraint(equalTo: productNameLabel.trailingAnchor),
            sizeLabel.topAnchor.constraint(equalTo: productNameLabel.bottomAnchor,  constant: 5),
            sizeLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -9)
        ])
    }
    
    func configure(productName: String, productImage: UIImage?, size: Int) {
        productNameLabel.text = productName
        productImageView.image = productImage
        sizeLabel.text = "Размер: \(size)"
    }
}
