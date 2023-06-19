//
//  ViewController.swift
//  OneLabHW1
//
//  Created by Mereke on 28.03.2023.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    private let headerLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .black
        label.text = "Abstract"
        return label
    }()

    private let imageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "first"))
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 12
        return imageView
    }()

    private let stackView: UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .vertical
        stackview.alignment = .center
        stackview.distribution = .equalSpacing
        stackview.backgroundColor = .systemGray6
        stackview.layer.cornerRadius = 24
        stackview.layoutMargins = UIEdgeInsets(top: 24, left: 16, bottom: 24, right: 16)
        stackview.isLayoutMarginsRelativeArrangement = true
        return stackview
    }()

    lazy var editButton = createButton(text: "Edit", imageName: nil)
    lazy var previousButton = createButton(text: "Previous", imageName: nil)
    lazy var infoButton = createButton(text: "Next", imageName: "info.circle")
    lazy var nextButton = createButton(text: "Next", imageName: nil)

    private let buttonStackView: UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .horizontal
        stackview.alignment = .center
        stackview.distribution = .equalCentering
        stackview.spacing = 8
        return stackview
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Simple Stack View"
        setupSubviews()
        setConstraints()
    }

    private func setupSubviews() {
        stackView.addArrangedSubview(headerLabel)
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(editButton)
        view.addSubview(stackView)

        buttonStackView.addArrangedSubview(previousButton)
        buttonStackView.addArrangedSubview(infoButton)
        buttonStackView.addArrangedSubview(nextButton)
        view.addSubview(buttonStackView)
    }

    private func setConstraints() {
        headerLabel.snp.makeConstraints() {
            $0.height.equalTo(24)
        }

        imageView.snp.makeConstraints() {
            $0.height.greaterThanOrEqualTo(180)
            $0.height.lessThanOrEqualTo(360)
            $0.width.lessThanOrEqualTo(480)
        }

        stackView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(16)
            $0.left.right.equalToSuperview().inset(24)
        }

        buttonStackView.snp.makeConstraints {
            $0.left.right.bottom.equalTo(view.safeAreaLayoutGuide).inset(36)
            $0.top.equalTo(stackView.snp.bottom).offset(24)
        }
    }

    private func createButton(text: String, imageName: String?) -> UIButton {
        let button = UIButton(type: .system)
        if let imageName = imageName {
            let infoImage = UIImage(systemName: imageName)
            button.setImage(infoImage, for: .normal)
        }
        else {
            button.setTitle(text, for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
            button.setTitleColor(.systemBlue, for: .normal)
        }
        button.snp.makeConstraints {
            $0.width.greaterThanOrEqualTo(96)
            $0.height.greaterThanOrEqualTo(24)
        }
        return button
    }
}

