//
//  ActivatePromocodeViewController.swift
//  EltexOrderProject
//
//  Created by Максим Герасимов on 27.10.2024.
//

import UIKit

final class AddPromocodeViewController: UIViewController {
    

    private var contentView: AddPromocodeView = AddPromocodeView()
    private var viewModel: AddPromocodeViewModel

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    init(viewModel: AddPromocodeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        viewModel.delegate = self
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupUI() {
        self.view = contentView
        setupBackButton()
    }
    
    func setupBackButton() {
        self.navigationController?.navigationBar.topItem?.backButtonDisplayMode = .minimal
        self.navigationController?.navigationBar.tintColor = #colorLiteral(red: 1, green: 0.3689950705, blue: 0.06806527823, alpha: 1)
    }
}

//MARK: - View model delegate
extension AddPromocodeViewController: AddPromocodeViewModelDelegate {
    func clearTextField() {
        contentView.clearTextField()
    }
    
    func makeAlert(_ text: String) {
        contentView.makeAlert(text)
    }
    
    func hideAlert() {
        contentView.hideAlert()
    }
    
    func setData(_ data: AddPromocodeModel) {
        contentView.setupData(data)
    }
    
    func setupTitle(_ title: String) {
        self.title = title
    }
    
    func closeWindow() {
        navigationController?.popViewController(animated: true)
    }
}
