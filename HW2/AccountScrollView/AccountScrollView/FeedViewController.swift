//
//  FeedViewController.swift
//  AccountScrollView
//
//  Created by Mereke on 31.03.2023.
//

import UIKit
import SnapKit

class FeedViewController: UIViewController {

    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        return collectionView
    }()

    private let reuseIdentifier = "PinterestCell"

    private let data = [
        "1",
        "2",
        "3",
        "4",
        "5",
        "6",
        "7",
        "8",
        "9"
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Feed"
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        collectionView.register(PinterestCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.dataSource = self
        collectionView.delegate = self
    }
}

extension FeedViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PinterestCell
        let imageName = data[indexPath.item]
        cell.imageView.image = UIImage(named: imageName)
        return cell
    }
}


extension FeedViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let image = UIImage(named: data[indexPath.item])!
        let aspectRatio = image.size.width / image.size.height
        let availableWidth = collectionView.frame.width - 30 // subtracting section insets and minimum interitem spacing
        let targetWidth = availableWidth / 2
        let targetHeight = targetWidth / aspectRatio
        let minHeight: CGFloat = 150 // set a minimum height for the cell
        return CGSize(width: targetWidth, height: max(targetHeight, minHeight))
    }
}



class PinterestCell: UICollectionViewCell {

    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .lightGray
        imageView.layer.cornerRadius = 16
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

