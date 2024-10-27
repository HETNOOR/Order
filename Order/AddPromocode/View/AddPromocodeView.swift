//
//  ActivatePromocodeView.swift
//  EltexOrderProject
//
//  Created by Максим Герасимов on 27.10.2024.
//

import UIKit
import SnapKit

final class AddPromocodeView: UIView {
    
    private lazy var verticalStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [promoCodeTextField, activeButton])
        stackView.axis = .vertical
        stackView.spacing = 16
        return stackView
    }()
    
    private lazy var activeButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 12
        var configuration = UIButton.Configuration.filled()
        configuration.baseBackgroundColor = #colorLiteral(red: 1, green: 0.3689950705, blue: 0.06806527823, alpha: 1)
        configuration.background.cornerRadius = 12
        configuration.contentInsets = .init(top: 16, leading: 0, bottom: 16, trailing: 0)
        button.configuration = configuration
        button.addTarget(self, action: #selector(activeButtonTarget), for: .touchUpInside)
        return button
    }()
    
    private lazy var promoCodeTextField: PromoCodeTextField = {
        let textField = PromoCodeTextField(delegate: self)
        return textField
    }()
    
    var viewModel: AddPromocodeModel.ActivePromocodeViewModelType.ActivePromocodeView? {
        didSet {
            updateUI()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc
    func activeButtonTarget() {
        viewModel?.activeButtonClicked?(promoCodeTextField.getTextFieldText())
    }

    func setupUI() {
        backgroundColor = .white
        addSubviews()
        setupConstraints()
    }
    
    func addSubviews() {
        addSubview(promoCodeTextField)
        addSubview(activeButton)
        addSubview(verticalStackView)
    }
    
    func setupConstraints() {
        verticalStackView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(safeAreaLayoutGuide).inset(16)
            make.bottom.lessThanOrEqualTo(safeAreaLayoutGuide).inset(16)
        }
    }
    
    func clearTextField() {
        promoCodeTextField.clearTextField()
    }
    
    func makeAlert(_ text: String) {
        promoCodeTextField.makeAlert(text)
    }
    
    func hideAlert() {
        promoCodeTextField.hideAlert()
    }
    
    func setupData(_ data: AddPromocodeModel) {
        switch data.type {
        case .view(let data):
            viewModel = data
        case .textField(let data):
            promoCodeTextField.viewModel = data
        }
    }
    
    func updateUI() {
        activeButton.configuration?.title = viewModel?.buttonText
    }
}


extension AddPromocodeView: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        viewModel?.textFieldShouldBeginEditing?()
        return true
    }
}
