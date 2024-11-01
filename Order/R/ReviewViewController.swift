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
        return tableView
    }()

    
    init(viewModel: ReviewViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
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

    private func addPhoto() {
        // Логика добавления фото
    }

    private func deletePhoto(at index: Int) {
//        viewModel.photos.remove(at: index)
        tableView.reloadSections(IndexSet(integer: 2), with: .automatic)
    }

    private func submitReview() {
        viewModel.submitReview()
    }
}

// MARK: - UITableViewDataSource

extension ReviewViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 7 // 1 - Product Info, 2 - Rating, 3 - Photos, 4 - Pros/Cons/Comment, 5 - Submit Button
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     

            return 1
  
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath) as! ProductCell
            cell.configure(productName: viewModel.product.name, productImage: viewModel.product.image, size: viewModel.product.size)
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "RatingCell", for: indexPath) as! RatingCell
            cell.configure(rating: viewModel.review.rating) { [weak self] rating in
                // self?.viewModel.setRating(rating)
                // self?.tableView.reloadData()
            }
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoCollectionCell", for: indexPath) as! PhotoCollectionCell
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TextFieldCell", for: indexPath) as! TextFieldCell
            cell.configure(placeholder: "Достоинства", text: viewModel.review.pros) { [weak self] text in
                self?.viewModel.review.pros = text
            }
            return cell
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TextFieldCell", for: indexPath) as! TextFieldCell
            cell.configure(placeholder: "Недостатки", text: viewModel.review.cons) { [weak self] text in
                self?.viewModel.review.cons = text
            }
            return cell
        case 5:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TextFieldCell", for: indexPath) as! TextFieldCell
            cell.configure(placeholder: "Комментарий", text: viewModel.review.comment) { [weak self] text in
                self?.viewModel.review.comment = text
            }
            return cell
        case 6:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SubmitReviewCell", for: indexPath) as! SubmitReviewCell
            return cell
        default:
            return UITableViewCell()
        }
    }
}

// MARK: - UITableViewDelegate

extension ReviewViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 4 {
            submitReview()
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    
    // Задает отступ сверху для каждой секции
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 16 // Установите нужный отступ
    }
    
    // Задает отступ снизу для каждой секции
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0 // Установите нужный отступ
    }
    
    // Задает кастомное отображение для хедера (позволяет тонко настроить отступы)
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .clear // или другой цвет для хедера
        return headerView
    }
    
    // Задает кастомное отображение для футера
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        footerView.backgroundColor = .clear // или другой цвет для футера
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
            // добавить иконку "плюс"
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath)
            cell.backgroundView = UIImageView(image: viewModel.review.photos[indexPath.item])
            return cell
        }
    }
}

// MARK: - UICollectionViewDelegate

extension ReviewViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.item == viewModel.review.photos.count {
            addPhoto()
        } else {
            deletePhoto(at: indexPath.item)
        }
    }
}


