//
//  SelfSizingViewController.swift
//  OneLabHW1
//
//  Created by Mereke on 29.03.2023.
//

import UIKit

class SelfSizingViewController: UIViewController {

    let tableText = ["Swift was introduced by Apple in 2014 as a replacement for Objective-C as the primary programming language for developing iOS, macOS, watchOS, and tvOS applications.", "Swift is designed to be easy to learn and use, with a syntax that is similar to many other programming languages.", "Swift is not just a language for app development. It is also used for server-side programming, machine learning, and many other areas of software development.", "Swift is constantly evolving, with new features and updates being released regularly. Recent updates to Swift include the introduction of SwiftUI, a declarative user interface framework, and the addition of async/await functionality for handling asynchronous programming tasks.", "Swift avoids the things that can make a language slow; e.g. it doesn't use garbage collection, allows you to use value types nearly"]

    lazy var buttons: [UIButton] = [createButton(text: "Previous", imageName: nil),createButton(text: "Next", imageName: "info.circle"),createButton(text: "Next", imageName: nil)]

    lazy var buttonStackView = createButtonStackview(buttons: buttons)

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.layer.cornerRadius = 12
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44
        return tableView
    }()

    private let stackView: UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .horizontal
        stackview.distribution = .fillEqually
        stackview.spacing = 16
        stackview.backgroundColor = .systemGray6
        stackview.layer.cornerRadius = 12
        stackview.layoutMargins = UIEdgeInsets(top: 24, left: 16, bottom: 24, right: 16)
        stackview.isLayoutMarginsRelativeArrangement = true
        return stackview
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Nested Stack View"
        tableView.dataSource = self
        tableView.delegate = self
        setupSubviews()
        setConstraints()
    }

    private func setupSubviews() {
        stackView.addArrangedSubview(tableView)
        view.addSubview(stackView)
        view.addSubview(buttonStackView)

        for button in buttons {
            buttonStackView.addArrangedSubview(button)
        }
    }

    private func setConstraints() {
        stackView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(16)
            $0.left.right.equalToSuperview().inset(24)
        }

        buttonStackView.snp.makeConstraints {
            $0.left.right.bottom.equalTo(view.safeAreaLayoutGuide).inset(36)
            $0.top.equalTo(stackView.snp.bottom).offset(24)
        }

        tableView.snp.makeConstraints {
            $0.edges.equalTo(stackView).inset(16)
        }
    }
}

extension SelfSizingViewController {
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

    private func createButtonStackview(buttons: [UIButton]) -> UIStackView {
        let stackview = UIStackView()
        stackview.axis = .horizontal
        stackview.alignment = .center
        stackview.distribution = .equalCentering
        stackview.spacing = 8
        return stackview
    }
}

extension SelfSizingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableText.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.text = tableText[indexPath.row]
        cell.backgroundColor = .clear
        cell.textLabel?.numberOfLines = 0
        return cell
    }
}


