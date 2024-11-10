//
//  PhotoCollectionCell.swift
//  Order
//
//  Created by Максим Герасимов on 29.10.2024.
//

import UIKit
import SnapKit

class PhotoCollectionCell: UITableViewCell {

    // MARK: - UI Components

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 8
        layout.minimumLineSpacing = 8
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.isScrollEnabled = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "ImageCell")
        return collectionView
    }()

    // MARK: - Properties
    var viewModel: ReviewViewModel? {
        didSet {
            updateCollectionViewHeight()
            collectionView.reloadData()
        }
    }
    
    weak var tableView: UITableView?
    private let baseHeight: CGFloat = 80
    private let increasedHeight: CGFloat = 168

    // MARK: - Initializer

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
   
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup UI

    private func setupUI() {
        contentView.addSubview(collectionView)
        
        collectionView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(contentView).inset(16)
            make.height.equalTo(baseHeight)
            make.top.bottom.equalTo(contentView)
        }
    }
    
    // MARK: - Helper Methods

    private func updateCollectionViewHeight() {
        let newHeight = (viewModel?.review.photos.count ?? 0 >= 4) ? increasedHeight : baseHeight
        collectionView.snp.updateConstraints { make in
            make.height.equalTo(newHeight)
        }
        tableView?.beginUpdates()
        tableView?.endUpdates()
    }
    
    @objc private func deletePhotoTapped(_ sender: UIButton) {
        guard let viewModel = viewModel else { return }
        let index = sender.tag
        viewModel.deletePhoto(at: index)
        updateCollectionViewHeight()
        collectionView.reloadData()
    }
}

// MARK: - UICollectionViewDataSource

extension PhotoCollectionCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let viewModel else { return 0 }
        return min(viewModel.review.photos.count + 1, 7) // Максимум 7 ячеек
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath)
        cell.contentView.subviews.forEach { $0.removeFromSuperview() }
        
        if let viewModel = viewModel {
            if indexPath.item < viewModel.review.photos.count {
                // Показываем изображение
                let imageView = UIImageView(image: viewModel.review.photos[indexPath.item])
                imageView.contentMode = .scaleAspectFill
                imageView.clipsToBounds = true
                imageView.frame = cell.contentView.bounds
                cell.contentView.addSubview(imageView)

                let deleteButton = UIButton(frame: CGRect(x: cell.contentView.bounds.width - 18, y: 10, width: 10, height: 10))
                deleteButton.setImage(UIImage(named: "XmarkC"), for: .normal)
                deleteButton.tintColor = .white
                deleteButton.addTarget(self, action: #selector(deletePhotoTapped(_:)), for: .touchUpInside)
                deleteButton.tag = indexPath.item
                cell.contentView.addSubview(deleteButton)
                
                cell.backgroundColor = .clear
            } else {
                // Ячейка для добавления фото
                cell.backgroundColor = UIColor(white: 0.95, alpha: 1)
                let shapeImageView = UIImageView(image: UIImage(named: "Shape"))
                shapeImageView.contentMode = .scaleAspectFit
                shapeImageView.frame = CGRect(x: (cell.contentView.bounds.width - 24) / 2, y: (cell.contentView.bounds.height - 24) / 2, width: 24, height: 24)
                shapeImageView.clipsToBounds = true
                cell.contentView.addSubview(shapeImageView)
            }
        }

        cell.layer.cornerRadius = 12
        cell.clipsToBounds = true
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension PhotoCollectionCell: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 80, height: 80)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.item == viewModel?.review.photos.count && viewModel?.review.photos.count ?? 0 < 7 {
            viewModel?.addPhoto()
            updateCollectionViewHeight()
            collectionView.reloadData()
        }
    }
}
