//
//  PromoCodeTopItemCell.swift
//  Order
//
//  Created by Максим Герасимов on 26.10.2024.
//

import UIKit
import SnapKit

final class HeaderOrderCell: UITableViewCell {

    private var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24)
        label.textColor = #colorLiteral(red: 0.1777858436, green: 0.1777858436, blue: 0.1777858436, alpha: 1)
        return label
    }()
    
    private var descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = #colorLiteral(red: 0.551900208, green: 0.5519001484, blue: 0.5519001484, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    private lazy var inputPromoCodeButton: UIButton = {
        let button = UIButton()
        var configuration = UIButton.Configuration.filled()
        configuration.image = .promocode
        configuration.baseForegroundColor = #colorLiteral(red: 1, green: 0.3689950705, blue: 0.06806527823, alpha: 1)
        configuration.imagePadding = 10
        configuration.background.backgroundColor = #colorLiteral(red: 1, green: 0.3689950705, blue: 0.06806527823, alpha: 0.1)
        configuration.background.cornerRadius = 12
        button.configuration = configuration
        button.addTarget(self, action: #selector(inputPromocodeTarget), for: .touchUpInside)
        return button
    }()
    
    var viewModel: OrderInfoTableViewModel.ViewModelType.TopItemCell? {
        didSet {
            updateUI()
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc
    func inputPromocodeTarget() {
        viewModel?.buttonAction?()
    }


    func setupUI() {
        backgroundColor = .white
        addSubviews()
        setupConstraints()
    }
    
    func addSubviews() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(inputPromoCodeButton)
    }
    
    func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalTo(descriptionLabel.snp.top).inset(-10)
            make.top.equalToSuperview().inset(24)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalTo(inputPromoCodeButton.snp.top).offset(-16)
        }
        
        inputPromoCodeButton.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview().inset(16)
            make.height.equalTo(54)
        }
    }

    func updateUI() {
        
        guard let viewModel else { return }
        
        titleLabel.text = viewModel.title
        descriptionLabel.text = viewModel.info
        inputPromoCodeButton.configuration?.title = viewModel.buttonTitle
    }
}

extension HeaderOrderCell {

    static var identifier: String {
        return String(describing: HeaderOrderCell.self)
    }
}
