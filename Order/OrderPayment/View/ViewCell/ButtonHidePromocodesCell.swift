//
//  HidePromoCodesCell.swift
//  Order
//
//  Created by Максим Герасимов on 26.10.2024.
//

import UIKit
import SnapKit

final class ButtonHidePromocodesCell: UITableViewCell {
    
    private lazy var hideButton: UIButton = {
        let button = UIButton()
        var configuration = UIButton.Configuration.plain()
        configuration.baseForegroundColor = #colorLiteral(red: 1, green: 0.3689950705, blue: 0.06806527823, alpha: 1)
        button.configuration = configuration
        button.addTarget(self, action: #selector(hide), for: .touchUpInside)
        return button
    }()
    
    var viewModel: OrderInfoTableViewModel.ViewModelType.HidePromoCell? {
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
    func hide() {
        viewModel?.hidePromoCode?()
    }
}

private extension ButtonHidePromocodesCell {

    func setupUI() {
        addSubviews()
        setupConstraints()
    }
    
    func addSubviews() {
        contentView.addSubview(hideButton)
    }
    
    func setupConstraints() {
        hideButton.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(32)
            make.top.equalToSuperview().inset(9)
            make.bottom.equalToSuperview().inset(33)
        }
    }
 
    func updateUI() {
        guard let data = viewModel else { return }
        hideButton.configuration?.title = data.title
    }
}


extension ButtonHidePromocodesCell {
    
  
    static var identifier: String {
        return String(describing: ButtonHidePromocodesCell.self)
    }
}
