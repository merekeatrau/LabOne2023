//
//  ViewController.swift
//  AccountScrollView
//
//  Created by Mereke on 30.03.2023.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    private let accountOptionTitles = ["iCloud", "Microsoft Exchange", "Google", "Yahoo", "AOL.", "Outlook", "Other", "Zoho", "ProtonMail", "FastMail", "Mail.ru", "Yandex", "GMX", "Tutanota", "StartMail", "Posteo"]

    private let scrollView: UIScrollView = {
        let scrollview = UIScrollView()
        scrollview.backgroundColor = .white
        scrollview.layer.cornerRadius = 16
        return scrollview
    }()

    private let stackView: UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .vertical
        stackview.spacing = 12
        return stackview
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        title = "Add account"
        setupSubviews()
        setConstraints()
    }

    private func createAccountOptionButton(withTitle title: String) -> UIButton {
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.contentHorizontalAlignment = .left
        button.snp.makeConstraints {
            $0.height.equalTo(40)
        }
        return button
    }

    private func setConstraints() {
        scrollView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide).inset(16)
        }

        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(20)
            $0.width.equalToSuperview().offset(-40)
        }
    }

    private func setupSubviews() {
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)

        for title in accountOptionTitles {
            let button = createAccountOptionButton(withTitle: title)
            stackView.addArrangedSubview(button)

            let separator = UIView()
            separator.backgroundColor = .lightGray.withAlphaComponent(0.3)
            separator.snp.makeConstraints {
                $0.height.equalTo(0.5)
            }

            stackView.addArrangedSubview(separator)
        }

        if let lastSubview = stackView.arrangedSubviews.last {
            lastSubview.removeFromSuperview()
        }
    }
}


