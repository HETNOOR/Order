//
//  SubmitReviewCell.swift
//  Order
//
//  Created by Максим Герасимов on 01.11.2024.
//

import UIKit

class SubmitReviewCell: UITableViewCell {

   
    private let anonymousReviewCheckbox: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "square"), for: .normal)
        button.setImage(UIImage(systemName: "checkmark.square.fill"), for: .selected)
        button.tintColor = #colorLiteral(red: 0.9987934232, green: 0.2710070908, blue: 0.07490523905, alpha: 1)
        return button
    }()
    
    private let anonymousLabel: UILabel = {
        let label = UILabel()
        label.text = "Оставить отзыв анонимно"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .black
        return label
    }()
    
    
    private let submitButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = #colorLiteral(red: 0.9987934232, green: 0.2710070908, blue: 0.07490523905, alpha: 1)
        button.layer.cornerRadius = 8
        button.setTitle("Отправить", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
  
    private let disclaimerLabel: UILabel = {
        let label = UILabel()
        let attributedText = NSMutableAttributedString(
            string: "Перед отправкой отзыва, пожалуйста,\n ознакомьтесь с ",
            attributes: [.font: UIFont.systemFont(ofSize: 12), .foregroundColor: UIColor.gray]
        )
        attributedText.append(NSAttributedString(
            string: "правилами публикации",
            attributes: [.font: UIFont.systemFont(ofSize: 12), .foregroundColor: UIColor.systemRed]
        ))
        label.attributedText = attributedText
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // Инициализация ячейки
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(anonymousReviewCheckbox)
        contentView.addSubview(anonymousLabel)
        contentView.addSubview(submitButton)
        contentView.addSubview(disclaimerLabel)
        
        // Добавляем целевое действие после инициализации кнопки
        anonymousReviewCheckbox.addTarget(self, action: #selector(toggleCheckbox), for: .touchUpInside)
        
        anonymousReviewCheckbox.translatesAutoresizingMaskIntoConstraints = false
        anonymousLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Настройка ограничений
        NSLayoutConstraint.activate([
            anonymousReviewCheckbox.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            anonymousReviewCheckbox.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 28),
            anonymousReviewCheckbox.widthAnchor.constraint(equalToConstant: 24),
            anonymousReviewCheckbox.heightAnchor.constraint(equalToConstant: 24),
            
            anonymousLabel.centerYAnchor.constraint(equalTo: anonymousReviewCheckbox.centerYAnchor),
            anonymousLabel.leadingAnchor.constraint(equalTo: anonymousReviewCheckbox.trailingAnchor, constant: 8),
            
            submitButton.topAnchor.constraint(equalTo: anonymousReviewCheckbox.bottomAnchor, constant: 16),
            submitButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            submitButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            submitButton.heightAnchor.constraint(equalToConstant: 54),
            
            disclaimerLabel.topAnchor.constraint(equalTo: submitButton.bottomAnchor, constant: 8),
            disclaimerLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            disclaimerLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            disclaimerLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
    }

    @objc private func toggleCheckbox() {
        anonymousReviewCheckbox.isSelected.toggle()
    }
}
