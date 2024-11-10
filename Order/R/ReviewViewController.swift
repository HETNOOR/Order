//
//  ReviewViewController.swift
//  Order
//
//  Created by Максим Герасимов on 29.10.2024.
//

import UIKit

class ReviewViewController: UIViewController {

    private let viewModel: ReviewViewModel

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ProductCell.self, forCellReuseIdentifier: "ProductCell")
        tableView.register(RatingCell.self, forCellReuseIdentifier: "RatingCell")
        tableView.register(PhotoCollectionCell.self, forCellReuseIdentifier: "PhotoCollectionCell")
        tableView.register(TextFieldCell.self, forCellReuseIdentifier: "TextFieldCell")
        tableView.register(SubmitReviewCell.self, forCellReuseIdentifier: "SubmitReviewCell")
        tableView.keyboardDismissMode = .onDrag
        return tableView
    }()
    
    // Массив моделей для текстовых полей
    var textFieldViewModels: [TextFieldViewModel]!
    
    init(viewModel: ReviewViewModel) {
        self.viewModel = viewModel
        
        // Инициализация массива ViewModel для текстовых полей
        super.init(nibName: nil, bundle: nil)  // Важно вызвать super.init() первым

        self.textFieldViewModels = [
            TextFieldViewModel(placeholder: "Достоинства", text: viewModel.review.pros, returnKeyType: .next, action: .next, didChangeText: { [weak self] text in
                self?.viewModel.review.pros = text
            }, nextResponderAction: { [weak self] in
                self?.focusOnNextTextField(at: 1)
            }),
            TextFieldViewModel(placeholder: "Недостатки", text: viewModel.review.cons, returnKeyType: .next, action: .next, didChangeText: { [weak self] text in
                self?.viewModel.review.cons = text
            }, nextResponderAction: { [weak self] in
                self?.focusOnNextTextField(at: 2)
            }),
            TextFieldViewModel(placeholder: "Комментарий", text: viewModel.review.comment, returnKeyType: .done, action: .done, didChangeText: { [weak self] text in
                self?.viewModel.review.comment = text
            })
        ]
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
    }

    private func setupUI() {
        title = "Напишите отзыв"
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    private func submitReview() {
        viewModel.submitReview()
    }

    // Переход к следующему текстовому полю
    private func focusOnNextTextField(at index: Int) {
        if index < textFieldViewModels.count {
            let indexPath = IndexPath(row: 0, section: index + 3)  // Смещение на 3, так как первые три секции не имеют текстовых полей
            if let cell = tableView.cellForRow(at: indexPath) as? TextFieldCell {
                cell.textField.becomeFirstResponder()
            }
        }
    }
}

// MARK: - UITableViewDataSource

extension ReviewViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 7  // Всего 7 секций
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1  // Каждая секция содержит одну строку
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell
        
        switch indexPath.section {
        case 0:
            let productCell = tableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath) as! ProductCell
            productCell.configure(with: viewModel.product)
            cell = productCell
        case 1:
            let ratingCell = tableView.dequeueReusableCell(withIdentifier: "RatingCell", for: indexPath) as! RatingCell
            ratingCell.configure(rating: viewModel.review.rating) { [weak self] rating in
                // Обработка изменений рейтинга
            }
            cell = ratingCell
        case 2:
            let photoCollectionCell = tableView.dequeueReusableCell(withIdentifier: "PhotoCollectionCell", for: indexPath) as! PhotoCollectionCell
            photoCollectionCell.viewModel = viewModel
            cell = photoCollectionCell
        case 3...5:
            let textFieldCell = tableView.dequeueReusableCell(withIdentifier: "TextFieldCell", for: indexPath) as! TextFieldCell
            let textFieldViewModel = textFieldViewModels[indexPath.section - 3]  // Смещение индекса для правильного обращения к ViewModel
            textFieldCell.configure(with: textFieldViewModel)
            cell = textFieldCell
        case 6:
            let submitReviewCell = tableView.dequeueReusableCell(withIdentifier: "SubmitReviewCell", for: indexPath) as! SubmitReviewCell
            cell = submitReviewCell
        default:
            cell = UITableViewCell()
        }

        cell.selectionStyle = .none
        return cell
    }
}

// MARK: - UITableViewDelegate

extension ReviewViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 6 {
            submitReview()
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }

    // Задает отступ сверху для каждой секции
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 16
    }
    
    // Задает отступ снизу для каждой секции
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    // Кастомное отображение хедера
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .clear
        return headerView
    }
    
    // Кастомное отображение футера
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        footerView.backgroundColor = .clear
        return footerView
    }
}

// MARK: - UITextFieldDelegate

extension ReviewViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

// MARK: - UICollectionViewDataSource

extension ReviewViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.review.photos.count < 7 ? viewModel.review.photos.count + 1 : viewModel.review.photos.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == viewModel.review.photos.count {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AddPhotoCell", for: indexPath)
            cell.contentView.backgroundColor = .lightGray
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath)
            cell.backgroundView = UIImageView(image: viewModel.review.photos[indexPath.item])
            return cell
        }
    }
}

