//
//  ViewController.swift
//  Order
//
//  Created by Максим Герасимов on 18.10.2024.
//

import UIKit
import SnapKit

class OrderViewController: UIViewController {

    var viewModel: OrderViewModel!
    var tableView: UITableView!
    var showFullPromocodeList = false

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        title = "Оформление заказа"

        setupTableView()
        setupUI()
    }

    // UI Setup
    func setupUI() {
        // Первый блок: Заголовок и кнопка
        let headerView = UIView()
        headerView.backgroundColor = .white
        
        let titleLabel = UILabel()
        titleLabel.text = "Промокоды"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        headerView.addSubview(titleLabel)

        let subtitleLabel = UILabel()
        subtitleLabel.text = "На один товар можно применить только один промокод"
        subtitleLabel.font = UIFont.systemFont(ofSize: 14)
        subtitleLabel.textColor = .gray
        subtitleLabel.numberOfLines = 0
        headerView.addSubview(subtitleLabel)

        let applyButton = UIButton(type: .system)
        applyButton.setTitle("Применить промокод", for: .normal)
        applyButton.backgroundColor = UIColor.systemRed.withAlphaComponent(0.1)
        applyButton.layer.cornerRadius = 10
        applyButton.setTitleColor(.systemRed, for: .normal)
        headerView.addSubview(applyButton)

        // Констрейнты для первого блока
        headerView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 150)


        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.left.right.equalToSuperview().inset(16)
        }

        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.left.right.equalToSuperview().inset(16)
        }

        applyButton.snp.makeConstraints { make in
            make.top.equalTo(subtitleLabel.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
            make.left.right.equalToSuperview().inset(16)
        }

        // Добавляем headerView в таблицу
        tableView.tableHeaderView = headerView
    }

    @objc func togglePromocodeList() {
        showFullPromocodeList.toggle()
        tableView.reloadSections(IndexSet(integer: 0), with: .automatic)
    }

    // Setup TableView
    func setupTableView() {
        tableView = UITableView(frame: .zero, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        
        tableView.register(OrderPromocodeCell.self, forCellReuseIdentifier: "OrderPromocodeCell")

        view.addSubview(tableView)

        // Констрейнты для растягивания таблицы на весь экран
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }

    // Footer для кнопки Оформить заказ
    func setupFooterView() -> UIView {
        let footerView = UIView()
        
        // Кнопка для скрытия/показа списка промокодов
        let togglePromocodeButton = UIButton(type: .system)
        togglePromocodeButton.setTitle(showFullPromocodeList ? "Скрыть промокоды" : "Показать все промокоды", for: .normal)
        togglePromocodeButton.setTitleColor(.systemRed, for: .normal)
        togglePromocodeButton.addTarget(self, action: #selector(togglePromocodeList), for: .touchUpInside)
        footerView.addSubview(togglePromocodeButton)

        let priceLabel = UILabel()
        let totalProductPrice = viewModel.order.products.reduce(0) { $0 + $1.price }
        priceLabel.text = "Стоимость: \(totalProductPrice) ₽"
        priceLabel.font = UIFont.systemFont(ofSize: 12)
        footerView.addSubview(priceLabel)

        let discountLabel = UILabel()
        let activePromocodes = viewModel.order.promocodes.filter { $0.active }
        let promocodeDiscount = activePromocodes.reduce(0) { $0 + (totalProductPrice * Double($1.percent) / 100) }
        discountLabel.text = "Скидка: \(promocodeDiscount) ₽"
        discountLabel.font = UIFont.systemFont(ofSize: 12)
//        discountLabel.textColor = .green
        footerView.addSubview(discountLabel)
        
        let totalPriceLabel = UILabel()
        totalPriceLabel.text = "Итого: \(calculateTotalPrice()) ₽"
        totalPriceLabel.font = UIFont.boldSystemFont(ofSize: 18)
        footerView.addSubview(totalPriceLabel)

        let checkoutButton = UIButton(type: .system)
        checkoutButton.setTitle("Оформить заказ", for: .normal)
        checkoutButton.backgroundColor = UIColor.systemRed
        checkoutButton.layer.cornerRadius = 10
        checkoutButton.setTitleColor(.white, for: .normal)
        footerView.addSubview(checkoutButton)

        let termsLabel = UILabel()
        termsLabel.text = "Нажимая кнопку «Оформить заказ»,\n Вы соглашаетесь с Условиями оферты"
        termsLabel.font = UIFont.systemFont(ofSize: 12)
        termsLabel.textColor = .gray
        termsLabel.textAlignment = .center
        termsLabel.numberOfLines = 2
        footerView.addSubview(termsLabel)

//         Констрейнты для футера
        togglePromocodeButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview().inset(32)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(togglePromocodeButton.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(32)
        }

        discountLabel.snp.makeConstraints { make in
            make.top.equalTo(priceLabel.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(32)
        }

        totalPriceLabel.snp.makeConstraints { make in
            make.top.equalTo(discountLabel.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(32)
        }

        checkoutButton.snp.makeConstraints { make in
            make.top.equalTo(totalPriceLabel.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
            make.left.equalToSuperview().offset(32)
        }

        termsLabel.snp.makeConstraints { make in
            make.top.equalTo(checkoutButton.snp.bottom).offset(10)
            make.left.right.equalToSuperview().inset(32)
            make.bottom.equalToSuperview().offset(-10)
        }

        return footerView
    }

    func recalculateAndReloadData() {
        tableView.reloadData()
    }

    func calculateTotalPrice() -> Double {
        return viewModel.calculateFinalPrice()
    }
}

// Extension для UITableView Delegate и DataSource
extension OrderViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2 // Одна секция для промокодов, вторая для итоговой суммы
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return showFullPromocodeList ? viewModel.order.promocodes.count : min(3, viewModel.order.promocodes.count)
        } else {
            return 1
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "OrderPromocodeCell", for: indexPath) as! OrderPromocodeCell
            let promocode = viewModel.order.promocodes[indexPath.row]
            cell.configure(promocode: promocode)
            
            // Обработка переключения свитчера
            cell.switchToggledClosure = { [weak self] isActive in
                guard let self = self else { return }
                
                // Обновление состояния промокода
                self.viewModel.updatePromocodeActiveState(index: indexPath.row, isActive: isActive)
                
                // Проверка валидации заказа
                if !self.viewModel.validateOrder() {
                    // Показываем ошибку, если валидация не прошла
                    if let errorMessage = self.viewModel.errorMessage {
                        print(errorMessage) // Или можно вывести через UIAlertController
                    }
                }
                
                // Пересчет итоговой суммы и обновление таблицы
                self.recalculateAndReloadData()
            }
            return cell
        } else {
            let cell = UITableViewCell()
            let footerView = setupFooterView()
            cell.contentView.addSubview(footerView)

            footerView.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }

            return cell
        }
    }

    // Высота для строки
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 100 // Промокоды
        } else {
            return 250 // Футер с итоговой суммой
        }
    }

    // Высота для Header
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 50 : 0.1
    }
}
