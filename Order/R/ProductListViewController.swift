//
//  ProductListViewController.swift
//  Order
//
//  Created by Максим Герасимов on 29.10.2024.
//

import UIKit

class ProductListViewController: UITableViewController {
    
    var products: [Product] = [
        Product(id: UUID(), name: "Золотое плоское обручальное кольцо 4435490443543593945043590435904904359043590435904539044390435904539045390435904359045390435904509453904350945309453904343590453945904539045945390445954309450945390453904495304539045390459045343590453904539045390 мм", image: UIImage(named: "ring1")!, size: 17),
        Product(id: UUID(), name: "Золотое плоское обручальное кольцо 4 мм", image: UIImage(named: "ring2")!, size: 20),
        Product(id: UUID(), name: "Золотое плоское обручальное кольцо 4 мм", image: UIImage(named: "ring3")!, size: 17),
        Product(id: UUID(), name: "Золотое плоское обручальное кольцо 4 мм", image: UIImage(named: "ring4")!, size: 20)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Напишите отзыв"
        tableView.register(ProductTableViewCell.self, forCellReuseIdentifier: "ProductCell")
        tableView.separatorStyle = .none
        navigationItem.backButtonDisplayMode = .minimal
        navigationController?.navigationBar.tintColor = .red

    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath) as! ProductTableViewCell
        let product = products[indexPath.row]
        cell.configure(with: product)
        cell.accessoryType = .disclosureIndicator
        return cell
    }

    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let product = products[indexPath.row]
        let reviewViewModel = ReviewViewModel(product: product)
        let reviewVC = ReviewViewController(viewModel: reviewViewModel)
        navigationController?.pushViewController(reviewVC, animated: true)
    }
    
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
}
