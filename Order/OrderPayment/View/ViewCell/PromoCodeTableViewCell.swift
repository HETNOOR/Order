//
//  PromoCodeTableViewCell.swift
//  Order
//
//  Created by Максим Герасимов on 26.10.2024.
//

import UIKit
import SnapKit

final class PromoCodeTableViewCell: UITableViewCell {

    private var mainContentView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 12
        view.backgroundColor = #colorLiteral(red: 0.9719485641, green: 0.9719484448, blue: 0.9719485641, alpha: 1)
        return view
    }()
    
    private var circleViewLeft: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        view.backgroundColor = .white
        return view
    }()
    
    private var circleViewRight: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var promoCodeTitleHorizontalStack =  PromocodeStack()
    
    private lazy var promoCodeTitleAndDateVerticalStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [promoCodeTitleHorizontalStack, promoCodeDateLabel])
        stack.spacing = 10
        stack.distribution = .equalSpacing
        stack.axis = .vertical
        return stack
    }()
    
    private lazy var promoCodeTopItemHorizontalStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [promoCodeTitleAndDateVerticalStack, promoCodeActiveSwitch])
        stack.axis = .horizontal
        stack.spacing = 12
        stack.distribution = .equalSpacing
        stack.alignment = .center
        return stack
    }()
    
    private lazy var promoCodeVerticalStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [promoCodeTopItemHorizontalStack, promoCodeDescriptionLabel])
        stack.spacing = 8
        stack.distribution = .fill
        stack.axis = .vertical
        return stack
    }()
    
    private var promoCodeDateLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = #colorLiteral(red: 0.551900208, green: 0.5519001484, blue: 0.5519001484, alpha: 1)
        return label
    }()
    
    private var promoCodeDescriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = #colorLiteral(red: 0.551900208, green: 0.5519001484, blue: 0.5519001484, alpha: 1)
        return label
    }()
    
    private lazy var promoCodeActiveSwitch: UISwitch = {
        let promoCodeSwitch = UISwitch()
        promoCodeSwitch.onTintColor = .red
        promoCodeSwitch.addTarget(self, action: #selector(togglePromocode), for: .valueChanged)
        return promoCodeSwitch
    }()
    
    private var toggle: ((Bool, UUID) -> Void)?
    
    var viewModel: OrderInfoTableViewModel.ViewModelType.PromoCell? {
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

    override func prepareForReuse() {
        super.prepareForReuse()
        isHidden = false
        isSelected = false
        isHighlighted = false
    }
}
private extension PromoCodeTableViewCell {

    func setupUI() {
        addSubviews()
        setupConstraints()
    }
    
    func addSubviews() {
        contentView.addSubview(mainContentView)
        contentView.addSubview(promoCodeDateLabel)
        contentView.addSubview(promoCodeDescriptionLabel)
        contentView.addSubview(promoCodeActiveSwitch)
        contentView.addSubview(promoCodeTitleHorizontalStack)
        contentView.addSubview(promoCodeTitleAndDateVerticalStack)
        contentView.addSubview(promoCodeTopItemHorizontalStack)
        contentView.addSubview(promoCodeVerticalStack)
        contentView.addSubview(circleViewLeft)
        contentView.addSubview(circleViewRight)
    }
    
    func setupConstraints() {
        mainContentView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(16)
            make.top.bottom.equalToSuperview().inset(4)
        }
        
        promoCodeVerticalStack.snp.makeConstraints { make in
            make.top.bottom.equalTo(mainContentView).inset(12)
            make.left.right.equalTo(mainContentView).inset(20)
        }
        
        circleViewLeft.snp.makeConstraints { make in
            make.centerX.equalTo(mainContentView.snp.left)
            make.centerY.equalTo(mainContentView.snp.centerY)
            make.height.width.equalTo(16)
        }
        
        circleViewRight.snp.makeConstraints { make in
            make.centerX.equalTo(mainContentView.snp.right)
            make.centerY.equalTo(mainContentView.snp.centerY)
            make.height.width.equalTo(16)
        }
    }
    
    //MARK: - Setup data function
    func updateUI() {
        guard let data = viewModel else { return }
        
        promoCodeTitleHorizontalStack.setElements((data.title, data.percent))
        promoCodeDateLabel.text = data.date
        switch data.additionalInformation {
        case "", nil:
            promoCodeDescriptionLabel.isHidden = true
        default:
            promoCodeDescriptionLabel.isHidden = false
            promoCodeDescriptionLabel.text = data.additionalInformation
        }
        promoCodeActiveSwitch.isOn = data.isToggle
        toggle = data.toggle
    }
    
    @objc
    func togglePromocode() {
        guard let viewModel else { return }
        toggle?(promoCodeActiveSwitch.isOn, viewModel.id)
    }
}

//MARK: - Extension
extension PromoCodeTableViewCell {
    
    //MARK: - Static properties
    static var identifier: String {
        return String(describing: PromoCodeTableViewCell.self)
    }
}


final class PromocodeStack: UIView {
    
    //MARK: - Properties
    private var leftElement: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = #colorLiteral(red: 0.1777858436, green: 0.1777858436, blue: 0.1777858436, alpha: 1)
        return label
    }()
    
    private var middleElement: DiscountView = {
        let view = DiscountView()
        return view
    }()
    
    private var rightElement: UIButton = {
        let button = UIButton()
        button.tintColor = .gray
        var configuration = UIButton.Configuration.plain()
        configuration.image = .info
        configuration.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)
        button.configuration = configuration
        button.isHidden = false
        return button
    }()
    
    private lazy var itemHorizontalStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [leftElement, middleElement, rightElement])
        stack.axis = .horizontal
        stack.spacing = 4
        stack.distribution = .fill
        return stack
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupUI() {
        addSubviews()
        setupConstraints()
    }
    
    func addSubviews() {
        addSubview(leftElement)
        addSubview(middleElement)
        addSubview(rightElement)
        addSubview(itemHorizontalStack)
    }
    
    func setupConstraints() {
        itemHorizontalStack.snp.makeConstraints { make in
            make.top.bottom.trailing.leading.equalToSuperview()
        }
        
        rightElement.snp.contentCompressionResistanceHorizontalPriority = 752
        middleElement.snp.contentCompressionResistanceHorizontalPriority = 752
    }
}

extension PromocodeStack {
    
    func setElements(_ data: (String, Int)) {
        leftElement.text = data.0
        middleElement.setDiscount(data.1)
    }
}


final class DiscountView: UIView {
    
    //MARK: - Properties
    private var discountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.textColor = .white
        return label
    }()
    
    private var contentMainView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0, green: 0.754624784, blue: 0.5331450701, alpha: 1)
        return view
    }()
    
    //MARK: - Initialization functions
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func layoutSubviews() {
        super.layoutSubviews()
        contentMainView.layer.cornerRadius = contentMainView.frame.height / 2
    }
    

    func setupUI() {
        addSubviews()
        setupConstraints()
    }
    
    func addSubviews() {
        addSubview(contentMainView)
        contentMainView.addSubview(discountLabel)
    }
    
    func setupConstraints() {
        contentMainView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.trailing.leading.greaterThanOrEqualToSuperview()
            make.width.greaterThanOrEqualTo(40)
        }
        
        discountLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(3)
            make.trailing.leading.equalToSuperview().inset(5)
        }
    }

    
    func setDiscount(_ discount: Int) {
        discountLabel.text = "-\(discount)%"
    }
}
