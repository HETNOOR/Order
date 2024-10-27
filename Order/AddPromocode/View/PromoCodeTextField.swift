//
//  PromoCodeTextField.swift
//  EltexOrderProject
//
//  Created by Максим Герасимов on 27.10.2024.
//

import UIKit
import SnapKit

final class PromoCodeTextField: UIView {
    

    private var alertLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textColor = #colorLiteral(red: 0.9758322835, green: 0.2742320597, blue: 0.2279928625, alpha: 1)
        label.isHidden = true
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var horizontalStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [verticalInternalStackView, clearButton])
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.layoutMargins = .init(top: 8, left: 12, bottom: 8, right: 12)
        stackView.isLayoutMarginsRelativeArrangement = true
        return stackView
    }()
    
    private lazy var verticalInternalStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [topTitleLabel, textField])
        stackView.axis = .vertical
        return stackView
    }()
    
    private var textField: UITextField = {
        let textField = UITextField()
        textField.tintColor = #colorLiteral(red: 1, green: 0.3689950705, blue: 0.06806527823, alpha: 1)
        textField.font = .boldSystemFont(ofSize: 16)
        return textField
    }()
    
    private var topTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textColor = #colorLiteral(red: 0.551900208, green: 0.5519001484, blue: 0.5519001484, alpha: 1)
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var clearButton: UIButton = {
        let button = UIButton()
        var configuration = UIButton.Configuration.plain()
        configuration.image = UIImage(systemName: "multiply.circle.fill")
        configuration.baseForegroundColor = #colorLiteral(red: 0.551900208, green: 0.5519001484, blue: 0.5519001484, alpha: 1)
        configuration.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)
        button.configuration = configuration
        button.addTarget(self, action: #selector(clearButtonTarget), for: .touchUpInside)
        return button
    }()
    
    var viewModel: AddPromocodeModel.ActivePromocodeViewModelType.PromocodeTextField? {
        didSet {
            updateUI()
        }
    }
    
    init(delegate: UITextFieldDelegate? = nil) {
        textField.delegate = delegate
        super.init(frame: .zero)
        setupUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        switch alertLabel.isHidden {
        case true:
            horizontalStackView.snp.remakeConstraints { make in
                make.leading.trailing.equalToSuperview()
                make.top.equalToSuperview().inset(8)
                make.bottom.equalToSuperview()
            }
        case false:
            horizontalStackView.snp.remakeConstraints { make in
                make.leading.trailing.equalToSuperview()
                make.top.equalToSuperview().inset(8)
                make.bottom.equalTo(alertLabel.snp.top).inset(-4)
            }
        }
    }
    
    @objc
    func clearButtonTarget() {
        viewModel?.clearButtonClicked?()
    }


    
    func setupUI() {
        horizontalStackView.layer.cornerRadius = 12
        horizontalStackView.layer.borderWidth = 1
        horizontalStackView.layer.borderColor = UIColor.black.cgColor
        addSubviews()
        setupConstraints()
    }
    
    func addSubviews() {
        addSubview(horizontalStackView)
        addSubview(alertLabel)
    }
    
    func setupConstraints() {
        horizontalStackView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalToSuperview().inset(8)
        }
        
        alertLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(12)
            make.bottom.equalToSuperview()
        }
        
        clearButton.snp.contentCompressionResistanceHorizontalPriority = 752
    }

    
    func getTextFieldText() -> String? {
        return textField.text
    }

    func clearTextField() {
        textField.text = ""
        hideAlert()
    }
    
    func makeAlert(_ text: String) {
        horizontalStackView.layer.borderColor = #colorLiteral(red: 0.9758322835, green: 0.2742320597, blue: 0.2279928625, alpha: 1)
        topTitleLabel.textColor = #colorLiteral(red: 0.9758322835, green: 0.2742320597, blue: 0.2279928625, alpha: 1)
        alertLabel.isHidden = false
        alertLabel.text = text
        layoutSubviews()
    }
    
    func hideAlert() {
        horizontalStackView.layer.borderColor = UIColor.black.cgColor
        topTitleLabel.textColor = #colorLiteral(red: 0.551900208, green: 0.5519001484, blue: 0.5519001484, alpha: 1)
        alertLabel.isHidden = true
        layoutSubviews()
    }
    
    func updateUI() {
        topTitleLabel.text = viewModel?.textFieldTitle
    }
}
