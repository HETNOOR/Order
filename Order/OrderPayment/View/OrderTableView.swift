//
//  OrderInfoTableView.swift
//  Order
//
//  Created by Максим Герасимов on 26.10.2024.
//

import UIKit

typealias TableProtocols = UITableViewDelegate & UITableViewDataSource

final class OrderTableView: UITableView {
    
    private var data: [OrderInfoTableViewModel] = []

    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        setupTable()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension OrderTableView {
    
    func setupTable() {
        self.delegate = self
        self.dataSource = self
        self.register(PromoCodeTableViewCell.self, forCellReuseIdentifier: PromoCodeTableViewCell.identifier)
        self.register(HeaderOrderCell.self, forCellReuseIdentifier: HeaderOrderCell.identifier)
        self.register(ButtonHidePromocodesCell.self, forCellReuseIdentifier: ButtonHidePromocodesCell.identifier)
        self.register(PaymentAmountCell.self, forCellReuseIdentifier: PaymentAmountCell.identifier)
    }
}

extension OrderTableView {

    func setupData(_ data: [OrderInfoTableViewModel]) {
        self.data = data
    }
}

extension OrderTableView: UITableViewDelegate,UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currentData = data[indexPath.row]
        
        switch currentData.type {
        case .topItem(let data):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: HeaderOrderCell.identifier, for: indexPath) as? HeaderOrderCell else { return UITableViewCell() }
            cell.viewModel = data
            cell.selectionStyle = .none
            return cell
        case .promo(let data):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PromoCodeTableViewCell.identifier, for: indexPath) as? PromoCodeTableViewCell else { return UITableViewCell() }
            cell.viewModel = data
            cell.selectionStyle = .none
            return cell
        case .hidePromo(let data):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ButtonHidePromocodesCell.identifier, for: indexPath) as? ButtonHidePromocodesCell else { return UITableViewCell() }
            cell.viewModel = data
            cell.selectionStyle = .none
            return cell
        case .bottomItem(let data):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PaymentAmountCell.identifier, for: indexPath) as? PaymentAmountCell else { return UITableViewCell() }
            cell.viewModel = data
            cell.selectionStyle = .none
            return cell
        }
    }
}
