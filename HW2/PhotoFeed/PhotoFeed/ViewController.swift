//
//  ViewController.swift
//  PhotoFeed
//
//  Created by Mereke on 31.03.2023.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionview = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionview.backgroundColor = .clear
        collectionview.showsVerticalScrollIndicator = false
        return collectionview
    }()

    private let searchController: UISearchController = {
        let searchcontroller = UISearchController(searchResultsController: nil)
        searchcontroller.obscuresBackgroundDuringPresentation = false
        searchcontroller.searchBar.placeholder = "Search"
        return searchcontroller
    }()

    private let data = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setNavBar()
        setCollectionView()
        setupConstraints()
    }
}

extension ViewController {
    private func setNavBar() {
        title = "Feed"

        let userButton = UIBarButtonItem(image: UIImage(systemName: "person.circle"), style: .plain, target: nil, action: nil)
        navigationItem.rightBarButtonItem = userButton
        userButton.tintColor = .black

        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = true
    }

    private func setCollectionView() {
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.identifier)
        collectionView.delegate = self
        let layout = Layout()
        layout.delegate = self
        collectionView.collectionViewLayout = layout
        collectionView.dataSource = self
        view.addSubview(collectionView)
    }

    private func setupConstraints() {
        collectionView.snp.makeConstraints {
            $0.left.right.equalTo(view.safeAreaLayoutGuide).inset(12)
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, LayoutDelegate {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        data.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.identifier, for: indexPath) as? CollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.imageView.image = UIImage(named: data[indexPath.row])
        return cell
    }

    func collectionView(_ collectionView:UICollectionView, heightForPhotoAtIndexPath indexPath:IndexPath) -> CGFloat {
        let image = UIImage(named: data[indexPath.item])
        let height = (collectionView.frame.width / 2) / (image!.size.width / image!.size.height)
        return height
    }

    func collectionView(_ collectionView: UICollectionView, paddingForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    }

    func collectionView(_ collectionView: UICollectionView, contentWidthForSectionAt section: Int) -> CGFloat {
        let padding = self.collectionView(collectionView, paddingForSectionAt: section)
        let cellWidth = (collectionView.frame.width - padding.left - padding.right) / 2
        return cellWidth * CGFloat(data.count)
    }

    func collectionView(_ collectionView: UICollectionView, sizeForPhotoAtIndexPath indexPath: IndexPath) -> CGSize {
        let padding = self.collectionView(collectionView, paddingForSectionAt: indexPath.section)
        let cellWidth = (collectionView.frame.width - padding.left - padding.right) / 2
        let image = UIImage(named: data[indexPath.item])
        let height = (cellWidth / (image!.size.width / image!.size.height))
        return CGSize(width: cellWidth, height: height)
    }
}

