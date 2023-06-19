//
//  CollectionViewCell.swift
//  PhotoFeed
//
//  Created by Mereke on 31.03.2023.
//

import UIKit
import SnapKit

class CollectionViewCell: UICollectionViewCell {

    static let identifier = "CollectionViewCell"

    let imageView: UIImageView = {
        let imageview = UIImageView()
        imageview.layer.cornerRadius = 12
        imageview.clipsToBounds = true
        imageview.contentMode = .scaleAspectFill
        return imageview
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
