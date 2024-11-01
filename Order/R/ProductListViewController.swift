//
//  ProductListViewController.swift
//  Order
//
//  Created by Максим Герасимов on 29.10.2024.
//

import UIKit

class ProductListViewController: UITableViewController {
    
    var products: [Product] = [
        Product(id: UUID(), name: "Золотое плоское обручальное кольцо 4 мм", image: UIImage(named: "ring1")!, size: 17),
        Product(id: UUID(), name: "Золотое плоское обручальное кольцо 4 мм", image: UIImage(named: "ring2")!, size: 20),
        Product(id: UUID(), name: "Золотое плоское обручальное кольцо 4 мм", image: UIImage(named: "ring3")!, size: 17),
        Product(id: UUID(), name: "Золотое плоское обручальное кольцо 4 мм", image: UIImage(named: "ring4")!, size: 20)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Напишите отзыв"
        tableView.register(ProductTableViewCell.self, forCellReuseIdentifier: "ProductCell")
        tableView.separatorStyle = .none
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath) as? ProductTableViewCell else {
            return UITableViewCell()
        }
        let product = products[indexPath.row]
        cell.productNameLabel.text = product.name
        cell.productImageView.image = product.image
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let product = products[indexPath.row]
        let reviewViewModel = ReviewViewModel(product: product)
        let reviewVC = ReviewViewController(viewModel: reviewViewModel)
        navigationController?.pushViewController(reviewVC, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 104
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
}
