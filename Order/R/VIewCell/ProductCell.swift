//
//  ProductCell.swift
//  Order
//
//  Created by Максим Герасимов on 01.11.2024.
//

import UIKit

class ProductCell: UITableViewCell {
    
    // MARK: - UI Components
    
    private lazy var productNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var sizeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    // MARK: - Initializers

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    // MARK: - Setup UI

    private func setupViews() {
        contentView.addSubview(productImageView)
        contentView.addSubview(productNameLabel)
        contentView.addSubview(sizeLabel)
        
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
            sizeLabel.topAnchor.constraint(equalTo: productNameLabel.bottomAnchor, constant: 5),
            sizeLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -9)
        ])
    }
    
    // MARK: - Configuration
    
    func configure(with product: Product) {
        productNameLabel.text = product.name
        productImageView.image = product.image
        sizeLabel.text = "Размер: \(product.size)"
    }
}
