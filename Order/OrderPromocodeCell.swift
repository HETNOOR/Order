//
//  OrderPromocodeCell.swift
//  Order
//
//  Created by Максим Герасимов on 18.10.2024.
//

import UIKit
import SnapKit

class OrderPromocodeCell: UITableViewCell {

    let promocodeTitleLabel = UILabel()
    let promocodeDiscountLabel = UILabel()
    let promocodeInfoButton = UIButton(type: .infoLight)
    let promocodeExpiryDateLabel = UILabel()
    let promocodeDescriptionLabel = UILabel()
    let promocodeSwitch = UISwitch()

    var switchToggledClosure: ((Bool) -> Void)?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupUI()
        promocodeSwitch.addTarget(self, action: #selector(switchToggled(_:)), for: .valueChanged)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // Настройка UI с использованием SnapKit
    func setupUI() {
        contentView.addSubview(promocodeTitleLabel)
        contentView.addSubview(promocodeDiscountLabel)
        contentView.addSubview(promocodeInfoButton)
        contentView.addSubview(promocodeExpiryDateLabel)
        contentView.addSubview(promocodeDescriptionLabel)
        contentView.addSubview(promocodeSwitch)

        // Настройки шрифтов
        promocodeTitleLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        promocodeDiscountLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        promocodeExpiryDateLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        promocodeExpiryDateLabel.textColor = .gray
        promocodeDescriptionLabel.font = UIFont.systemFont(ofSize: 12)
        promocodeDescriptionLabel.textColor = .gray
        promocodeDescriptionLabel.numberOfLines = 0

        // Констрейнты для первой строки: Название и скидка
        promocodeTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview().inset(20)
        }

        promocodeDiscountLabel.snp.makeConstraints { make in
            make.left.equalTo(promocodeTitleLabel.snp.right).offset(10)
            make.centerY.equalTo(promocodeTitleLabel)
        }

        promocodeInfoButton.snp.makeConstraints { make in
            make.left.equalTo(promocodeDiscountLabel.snp.right).offset(10)
            make.centerY.equalTo(promocodeTitleLabel)
        }

        // Констрейнты для второй строки: Срок действия
        promocodeExpiryDateLabel.snp.makeConstraints { make in
            make.top.equalTo(promocodeTitleLabel.snp.bottom).offset(5)
            make.left.equalToSuperview().inset(20)
        }

        // Констрейнты для третьей строки: Описание
        promocodeDescriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(promocodeExpiryDateLabel.snp.bottom).offset(5)
            make.left.equalToSuperview().inset(20)
            make.right.equalToSuperview().inset(80) // чтобы оставить место для свитчера
        }

        // Констрейнты для переключателя
        promocodeSwitch.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(20)
            make.centerY.equalToSuperview()
        }
    }

    // Конфигурация ячейки с данными о промокоде
    func configure(promocode: Order.Promocode) {
        promocodeTitleLabel.text = promocode.title
        promocodeDiscountLabel.text = "-\(promocode.percent)%"
        promocodeExpiryDateLabel.text = "По \(formatDate(promocode.endDate))"
        promocodeDescriptionLabel.text = promocode.info ?? "Нет дополнительной информации"
        promocodeSwitch.isOn = promocode.active
    }

    // Форматирование даты
    private func formatDate(_ date: Date?) -> String {
        guard let date = date else { return "Без срока действия" }
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMMM yyyy"
        return formatter.string(from: date)
    }

    @objc func switchToggled(_ sender: UISwitch) {
        switchToggledClosure?(sender.isOn)  // Вызов замыкания с новым состоянием свитчера
    }
}
