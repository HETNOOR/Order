//
//  OrderInfoViewController.swift
//  Order
//
//  Created by Максим Герасимов on 26.10.2024.
//

import UIKit

final class OrderViewController: UIViewController {
    
    private let contentView = OrderView()
    private let viewModel: OrderViewModel
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.setHidesBackButton(true, animated: true)
    }
    
    init(viewModel: OrderViewModel) {
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
        setupNavigationBar()
    }
    
    func setupNavigationBar() {
        let standard = UINavigationBarAppearance()
        standard.configureWithOpaqueBackground()
        standard.backgroundColor = .white
        standard.shadowColor = .black
        navigationController?.navigationBar.standardAppearance = standard
    }
}

extension OrderViewController: OrderViewModelDelegate {
    
    func openActivePromocode(_ data: [Order.Promocode]) {
            let viewModel = AddPromocodeViewModel(promoCodesList: data, previousViewModel: viewModel)
            let controller = AddPromocodeViewController(viewModel: viewModel)
            navigationController?.pushViewController(controller, animated: true)

    }
    
    func cellDidChange(_ data: [OrderInfoTableViewModel]) {
        contentView.setupTable(data)
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Ошибка", message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Ок", style: .cancel)
        alert.addAction(alertAction)
        present(alert, animated: true)
    }
    
    func setTitle(_ title: String) {
        self.title = title
    }
    
    func deleteRows(at indexes: [IndexPath], data: [OrderInfoTableViewModel]) {
        contentView.deleteRows(at: indexes, data: data)
    }
    
    func insertRows(at indexes: [IndexPath], data: [OrderInfoTableViewModel]) {
        contentView.insertRows(at: indexes, data: data)
    }
    
    func reloadCell(at indexes: [IndexPath], data: [OrderInfoTableViewModel]) {
        contentView.reloadCell(at: indexes, data: data)
    }
    
    func activateSnackBar(_ text: String) {
        contentView.activateSnackBar(text)
    }
    
    func deactivateSnackBar() {
        contentView.deactivateSnackBar()
    }
}
