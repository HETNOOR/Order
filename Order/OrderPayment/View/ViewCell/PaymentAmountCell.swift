//
//  PromoCodeBottomItemCell.swift
//  Order
//
//  Created by Максим Герасимов on 26.10.2024.
//

import UIKit
import SnapKit

final class PaymentAmountCell: UITableViewCell {

    private lazy var verticalStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [priceStack, discountStack, promoCodeStack, paymentMethodStack, separatorView, finalPriceStack, placeAnOrderButton, userAgreementLabel])
        stack.axis = .vertical
        stack.spacing = 10
        stack.distribution = .equalSpacing
        return stack
    }()
    
    private var priceLabel = createLeftAlignedLabel()
    private var priceValueLabel = createRightAlignedLabel()
    
    private var discountLabel  = createLeftAlignedLabel()
       
    private var discountValueLabel: UILabel = {
        let label = createRightAlignedLabel()
        label.textColor = #colorLiteral(red: 1, green: 0.3689950705, blue: 0.06806527823, alpha: 1)
        return label
    }()
    private var promoCodeLabel = createLeftAlignedLabel()
        
   
    private var promoCodeValueLabel: UILabel = {
        let label = createRightAlignedLabel()
        label.textColor = #colorLiteral(red: 0, green: 0.754624784, blue: 0.5331450701, alpha: 1)
        return label
    }()
    private var paymentMethodLabel = createLeftAlignedLabel()
    private var paymentMethodValueLabel = createRightAlignedLabel()
    
    private var finalPriceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    private var finalPriceValueLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    
    private var separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.9341433644, green: 0.9341433644, blue: 0.9341433644, alpha: 1)
        return view
    }()
    
    private var placeAnOrderButton: UIButton = {
        let button = UIButton()
        var configuration = UIButton.Configuration.filled()
        configuration.baseBackgroundColor = #colorLiteral(red: 1, green: 0.3689950705, blue: 0.06806527823, alpha: 1)
        configuration.background.cornerRadius = 12
        configuration.baseForegroundColor = .white
        button.configuration = configuration
        return button
    }()
    
    private var userAgreementLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    var viewModel: OrderInfoTableViewModel.ViewModelType.BottomItemCell? {
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
}

private extension PaymentAmountCell {
    
 
    static func createLeftAlignedLabel() -> UILabel {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }
    
    static func createRightAlignedLabel() -> UILabel {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .right
        return label
    }

    func setupUI() {
        backgroundColor = #colorLiteral(red: 0.9719485641, green: 0.9719484448, blue: 0.9719485641, alpha: 1)
        addSubviews()
        setupConstraints()
    }
    
    func addSubviews() {
        contentView.addSubview(verticalStack)
    }
    
    func setupConstraints() {
        verticalStack.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(24)
            make.left.right.equalToSuperview().inset(24)
            make.bottom.equalToSuperview()
        }
        
        separatorView.snp.makeConstraints { make in
            make.height.equalTo(1)
        }
        
        placeAnOrderButton.snp.makeConstraints { make in
            make.height.equalTo(54)
        }
    }

    func updateUI() {
        guard let data = viewModel else { return }
        
        priceLabel.text = data.generalTitle
        priceValueLabel.text = data.generalPrice
        discountLabel.text = data.discountTitle
        discountValueLabel.text = data.discountPrice
        promoCodeLabel.text = data.promoCodeTitle
        promoCodeValueLabel.text = data.promoCodePrice
        paymentMethodLabel.text = data.paymentMethodTitle
        paymentMethodValueLabel.text = data.paymentMethodPrice
        finalPriceLabel.text = data.resultTitle
        finalPriceValueLabel.text = data.resultPrice
        placeAnOrderButton.configuration?.title = data.nextButtonTitle
        userAgreementLabel.attributedText = data.userAgreement
    }

    private var priceStack: UIStackView {
        return createStack(for: priceLabel, and: priceValueLabel)
    }
    
    private var discountStack: UIStackView {
        return createStack(for: discountLabel, and: discountValueLabel)
    }

    private var promoCodeStack: UIStackView {
        return createStack(for: promoCodeLabel, and: promoCodeValueLabel)
    }

    private var paymentMethodStack: UIStackView {
        return createStack(for: paymentMethodLabel, and: paymentMethodValueLabel)
    }

    private var finalPriceStack: UIStackView {
        return createStack(for: finalPriceLabel, and: finalPriceValueLabel)
    }
    
    func createStack(for leftLabel: UILabel, and rightLabel: UILabel) -> UIStackView {
        let stack = UIStackView(arrangedSubviews: [leftLabel, rightLabel])
        stack.axis = .horizontal
        stack.spacing = 10
        return stack
    }
}

extension PaymentAmountCell {

    static var identifier: String {
        return String(describing: PaymentAmountCell.self)
    }
}
