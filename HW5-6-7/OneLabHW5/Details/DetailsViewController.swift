//
//  DetailsViewController.swift
//  OneLabHW5
//
//  Created by Mereke on 15.04.2023.
//

import UIKit
import SnapKit

class DetailsViewController: UIViewController {

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()

    private let authorLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()

    private let typeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .black.withAlphaComponent(0.8)
        label.numberOfLines = 0
        return label
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .black.withAlphaComponent(0.6)
        label.numberOfLines = 0
        return label
    }()

    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 4
        return stackView
    }()

    private var isFavorite: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setConstraints()
    }

    func setBook(_ book: Book) {
        var bookBuilder = BookBuilder()
        bookBuilder.setTitle(book.title)
        bookBuilder.setAuthor(book.author)
        bookBuilder.setType(book.type)
        bookBuilder.setOverview(book.overview)
        bookBuilder.setImage(book.image)

        if let image = bookBuilder.getImage() {
            imageView.image = image
        } else {
            imageView.image = UIImage(named: "igm")
        }
        authorLabel.text = "\(bookBuilder.getTitle()) by \(bookBuilder.getAuthor())"
        typeLabel.text = bookBuilder.getType()
        descriptionLabel.text = bookBuilder.getOverview()
    }

    private func setupUI() {
        title = "book"
        view.backgroundColor = .white

        let defaults = UserDefaults.standard
        if let favoriteBooks = defaults.array(forKey: "favoriteBooks") as? [String], let bookTitle = authorLabel.text {
            isFavorite = favoriteBooks.contains(bookTitle)
        }

        let favouriteButtonImage = isFavorite ? UIImage(systemName: "star.fill") : UIImage(systemName: "star")
        let favouriteButton = UIBarButtonItem(image: favouriteButtonImage, style: .plain, target: self, action: #selector(favouriteButtonTapped))
        favouriteButton.tintColor = .systemBlue
        navigationItem.rightBarButtonItem = favouriteButton

        view.addSubview(imageView)
        view.addSubview(stackView)

        stackView.addArrangedSubview(authorLabel)
        stackView.addArrangedSubview(typeLabel)

        view.addSubview(descriptionLabel)
    }

    @objc private func favouriteButtonTapped() {
        let defaults = UserDefaults.standard
        if let bookTitle = authorLabel.text {
            var favoriteBooks = defaults.array(forKey: "favoriteBooks") as? [String] ?? []
            if isFavorite {
                favoriteBooks.removeAll(where: { $0 == bookTitle })
            } else {
                favoriteBooks.append(bookTitle)
            }
            defaults.set(favoriteBooks, forKey: "favoriteBooks")
            isFavorite.toggle()

            let favouriteButtonImage = isFavorite ? UIImage(systemName: "star.fill") : UIImage(systemName: "star")
            navigationItem.rightBarButtonItem?.image = favouriteButtonImage
        }
    }

    private func setConstraints() {
        imageView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(16)
            $0.height.equalTo(180)
        }

        stackView.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(16)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(16)
        }

        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(stackView.snp.bottom).offset(16)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(16)
        }
    }
}


