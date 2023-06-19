//
//  RestaurantTableViewCell.swift
//  OneLabHW5
//
//  Created by Mereke on 13.04.2023.
//

import UIKit
import SnapKit

class BookTableViewCell: UITableViewCell {

    static let identifier = "BookTableViewCell"

    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 12
        stackView.alignment = .top
        return stackView
    }()

    private let textStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 4
        return stackView
    }()

    private var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.snp.makeConstraints {
            $0.size.equalTo(96)
        }
        return imageView
    }()

    private var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.numberOfLines = 0
        return label
    }()

    private var subheaderLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .light)
        label.textColor = .black.withAlphaComponent(0.7)
        label.numberOfLines = 2
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setConstraints()
    }

    private func setupUI() {
        selectionStyle = .none
        backgroundColor = .clear
        textStackView.addArrangedSubview(titleLabel)
        textStackView.addArrangedSubview(subheaderLabel)
        textStackView.addArrangedSubview(subheaderLabel)
        stackView.addArrangedSubview(iconImageView)
        stackView.addArrangedSubview(textStackView)
        contentView.addSubview(stackView)
    }

    private func setConstraints() {
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(16)
        }
    }

    func configure(_ book: Book) {
        titleLabel.text = "\(book.title) by \(book.author)"
        subheaderLabel.text = book.overview
        if let image = book.image {
            iconImageView.image = image
        }
        else {
            iconImageView.image = UIImage(named: "igm")
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

