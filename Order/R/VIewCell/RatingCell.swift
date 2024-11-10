//
//  RatingCell.swift
//  Order
//
//  Created by Максим Герасимов on 29.10.2024.
//

import UIKit

class RatingCell: UITableViewCell {
    
    // MARK: - UI Components
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 12
        view.layer.masksToBounds = true
        view.backgroundColor = UIColor(white: 0.95, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var starsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 4
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var ratingLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var ratingButtons: [UIButton] = []
    
    // MARK: - Properties
    
    private var currentRating: Int = 0 {
        didSet {
            updateStars()
            updateRatingLabel()
            onRatingChanged?(currentRating)
        }
    }
    
    var onRatingChanged: ((Int) -> Void)?
    
    // MARK: - Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup UI
    
    private func setupUI() {
        contentView.addSubview(containerView)
        containerView.addSubview(ratingLabel)
        containerView.addSubview(starsStackView)
        
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            containerView.heightAnchor.constraint(equalToConstant: 56),
            
            ratingLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            ratingLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            
            starsStackView.leadingAnchor.constraint(equalTo: ratingLabel.trailingAnchor, constant: 16),
            starsStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            starsStackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8),
            starsStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -8)
        ])
        
        for i in 1...5 {
            let button = UIButton(type: .system)
            button.tag = i
            button.setImage(UIImage(named: "star2")?.withRenderingMode(.alwaysOriginal), for: .normal)
            button.widthAnchor.constraint(equalToConstant: 24).isActive = true
            button.heightAnchor.constraint(equalToConstant: 24).isActive = true
            button.addTarget(self, action: #selector(starTapped(_:)), for: .touchUpInside)
            ratingButtons.append(button)
            starsStackView.addArrangedSubview(button)
        }
        
        updateStars()
        updateRatingLabel()
    }
    
    // MARK: - Configuration
    
    func configure(rating: Int, onRatingChanged: @escaping (Int) -> Void) {
        self.currentRating = rating
        self.onRatingChanged = onRatingChanged
    }
    
    // MARK: - Actions
    
    @objc private func starTapped(_ sender: UIButton) {
        currentRating = sender.tag
    }
    
    // MARK: - Helpers
    
    private func updateStars() {
        for button in ratingButtons {
            let imageName = button.tag <= currentRating ? "star1" : "star2"
            button.setImage(UIImage(named: imageName)?.withRenderingMode(.alwaysOriginal), for: .normal)
        }
    }
    
    private func updateRatingLabel() {
        let ratingTexts = ["Ужасно", "Плохо", "Нормально", "Хорошо", "Отлично"]
        ratingLabel.text = currentRating >= 1 && currentRating <= 5 ? ratingTexts[currentRating - 1] : "Ваша оценка"
    }
}
